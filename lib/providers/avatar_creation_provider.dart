import 'dart:async';
import 'dart:convert';

import 'package:avarium_avatar_creator/providers/secret_value_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:avarium_avatar_creator/common/service_const.dart';
import 'package:avarium_avatar_creator/common/utils.dart';
import 'package:avarium_avatar_creator/models/avatar_create_session_model.dart';
import 'package:avarium_avatar_creator/models/avatar_creation_chat_model.dart';
import 'package:avarium_avatar_creator/models/avatar_creation_model.dart';
import 'package:avarium_avatar_creator/models/avatar_object_creation_model.dart';
import 'package:avarium_avatar_creator/repository/avatar_repository.dart';
import 'package:just_audio/just_audio.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

final avatarCreationProvider =
    StateNotifierProvider<AvatarCreationStateNotifier, AvatarCreationModel?>(
  (ref) {
    final avatarRepository = ref.watch(avatarRepositoryProvider);
    return AvatarCreationStateNotifier(
      ref: ref,
      avatarRepository: avatarRepository,
    );
  },
);

/// Avatar creation chat
/// family: objectType (image, character, voice)
final avatarCreationChatProvider = StateNotifierProviderFamily<
    AvatarObjectCreationChatStateNotifier,
    List<AvatarCreationChatModel>,
    String>(
  (ref, objectType) {
    return AvatarObjectCreationChatStateNotifier();
  },
);

class AvatarCreationStateNotifier extends StateNotifier<AvatarCreationModel?> {
  final Ref ref;
  final AvatarRepository avatarRepository;
  final AudioPlayer audioPlayer = AudioPlayer();
  WebSocketChannel? _channel;

  Stream<double> get progressStream => audioPlayer.positionStream.map(
        (duration) =>
            duration.inMilliseconds /
            (audioPlayer.duration?.inMilliseconds ?? 1),
      );

  Stream<bool> get isPlayingStream => audioPlayer.playerStateStream.map(
        (state) =>
            state.playing && state.processingState != ProcessingState.completed,
      );

  Future<void> pressPlayButton() async {
    if (audioPlayer.processingState == ProcessingState.completed) {
      await audioPlayer.seek(Duration.zero);
      // await audioPlayer.play();
      return;
    }
    if (audioPlayer.playing) {
      await audioPlayer.pause();
    } else {
      await audioPlayer.play();
    }
  }

  AvatarCreationStateNotifier({
    required this.ref,
    required this.avatarRepository,
  }) : super(null);

  Future<void> startSession(AvatarCreationRequestModel requestModel) async {
    state = await avatarRepository.startNewAvatarCreationSession(requestModel);
    String? accessToken = await ref
        .read(secretValueProvider("access_token").notifier)
        .fetchIfNull();
    if (accessToken == null) {
      Utils.showErrorToast(message: 'invalid access token');
      return;
    }
    // Websocket connection -> GET /avatar/create/{id}/enter/
    _channel = WebSocketChannel.connect(
      Uri.parse('$wsOrigin/avatar/create/${state?.id}/enter/'),
    );

    accessToken = accessToken.replaceAll('"', '').replaceAll('\\', '');
    _channel!.sink.add(jsonEncode({'access_token': accessToken}));
    Utils.d('access token sent $accessToken');
    // receive data from server
    _channel!.stream.listen(_handleEvent);
  }

  void _handleEvent(event) async {
    final jsonData = event is String ? event : event.toString();
    Utils.d('avatar creation event: $jsonData');
    final Map<String, dynamic> data = jsonDecode(jsonData);
    final response = AvatarCreateSessionResponse.fromJson(data);
    if (response.event == 'chunk') {
      ref
          .read(avatarCreationChatProvider(response.objectType).notifier)
          .addChunk(response.content);
    } else if (response.event == 'chat') {
      final chatJson = jsonDecode(response.content);
      final chat = AvatarCreationChatModel.fromJson(chatJson);
      ref
          .read(avatarCreationChatProvider(response.objectType).notifier)
          .addMessage(chat);
    } else if (response.event == 'creation') {
      final creationJson = jsonDecode(response.content);
      if (response.objectType == 'image') {
        final imageCreation = AvatarImageCreationModel.fromJson(creationJson);
        handleImageCreation(imageCreation);
      } else if (response.objectType == 'character') {
        final characterCreation =
            AvatarCharacterCreationModel.fromJson(creationJson);
        handleCharacterCreation(characterCreation);
      } else if (response.objectType == 'voice') {
        final voiceCreation = AvatarVoiceCreationModel.fromJson(creationJson);
        handleVoiceCreation(voiceCreation);
      }
    } else if (response.event == 'error') {
      Utils.showErrorToast(message: 'Error: ${response.content}');
    }
  }

  void sendMessage({
    required String objectType,
    required String message,
  }) {
    _channel?.sink.add(jsonEncode(AvatarCreateSessionRequest(
      objectType: objectType,
      event: 'chat',
      content: message,
    ).toJson()));
  }

  void handleImageCreation(AvatarImageCreationModel imageCreation) {
    if (state == null) {
      return;
    }
    if (imageCreation.status == AvatarObjectCreationStatus.failed) {
      Utils.showErrorToast(message: imageCreation.failedReason);
    }
    if (state!.imageCreations == null) {
      state = state!.copyWith(imageCreations: [imageCreation]);
    } else {
      bool isContinaed = false;
      for (var creation in state!.imageCreations!) {
        if (creation.id == imageCreation.id) {
          isContinaed = true;
          break;
        }
      }
      if (!isContinaed) {
        state = state!.copyWith(
            imageCreations: [...state!.imageCreations!, imageCreation]);
      } else {
        state = state!.copyWith(
          imageCreations: state!.imageCreations!
              .map((e) => e.id == imageCreation.id ? imageCreation : e)
              .toList(),
        );
      }
      Utils.d('updated image creation: ${state!.imageUrl}');
    }
  }

  void handleCharacterCreation(AvatarCharacterCreationModel characterCreation) {
    if (state == null) {
      return;
    }
    if (characterCreation.status == AvatarObjectCreationStatus.failed) {
      Utils.showErrorToast(message: characterCreation.failedReason);
    }
    if (state!.characterCreations == null) {
      state = state!.copyWith(characterCreations: [characterCreation]);
    } else {
      bool isContained = false;
      for (var creation in state!.characterCreations!) {
        if (creation.id == characterCreation.id) {
          isContained = true;
          break;
        }
      }
      if (!isContained) {
        state = state!.copyWith(characterCreations: [
          ...state!.characterCreations!,
          characterCreation
        ]);
      } else {
        state = state!.copyWith(
          characterCreations: state!.characterCreations!
              .map((e) => e.id == characterCreation.id ? characterCreation : e)
              .toList(),
        );
      }
      Utils.d('updated character creation: ${state!.characterCreations}');
    }
  }

  void handleVoiceCreation(AvatarVoiceCreationModel voiceCreation) async {
    if (state == null) {
      return;
    }

    // on error
    if (voiceCreation.status == AvatarObjectCreationStatus.failed) {
      Utils.showErrorToast(message: voiceCreation.failedReason);
    }

    // update state
    if (state!.voiceCreations == null) {
      state = state!.copyWith(voiceCreations: [voiceCreation]);
    } else {
      bool isContained = false;
      for (var creation in state!.voiceCreations!) {
        if (creation.id == voiceCreation.id) {
          isContained = true;
          break;
        }
      }
      if (!isContained) {
        state = state!.copyWith(
            voiceCreations: [...state!.voiceCreations!, voiceCreation]);
      } else {
        state = state!.copyWith(
          voiceCreations: state!.voiceCreations!
              .map((e) => e.id == voiceCreation.id ? voiceCreation : e)
              .toList(),
        );
      }
      Utils.d('updated voice creation: ${state!.voiceCreations}');
    }

    // if new, play it
    // if (voiceCreation.status == AvatarObjectCreationStatus.completed &&
    //     voiceCreation.voiceUrl.isNotEmpty) {
    //   await audioPlayer.setUrl(voiceCreation.voiceUrl);
    //   await audioPlayer.play();
    // }
  }

  void reset() {
    if (_channel != null) {
      _channel!.sink.close();
      _channel = null;
    }
    ref.read(avatarCreationChatProvider('image').notifier).resetAll();
    ref.read(avatarCreationChatProvider('character').notifier).resetAll();
    ref.read(avatarCreationChatProvider('voice').notifier).resetAll();
    state = null;
  }
}

class AvatarObjectCreationChatStateNotifier
    extends StateNotifier<List<AvatarCreationChatModel>> {
  StreamController<String>? _messageController;
  String currentMessage = '';

  Stream<String>? get messageStream => _messageController?.stream;

  AvatarObjectCreationChatStateNotifier() : super([]);

  void addMessage(AvatarCreationChatModel message) {
    if (_messageController != null) {
      _messageController!.close();
      _messageController = null;
    }
    state = [...state, message];
  }

  void addChunk(String chunk) {
    if (_messageController == null) {
      _messageController = StreamController<String>.broadcast();
      currentMessage = '';
      state = [...state];
    }
    currentMessage += chunk;
    _messageController!.add(currentMessage);
  }

  void resetAll() {
    state = [];
  }
}
