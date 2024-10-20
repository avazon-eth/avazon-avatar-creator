import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gid_app_v2/models/avatar/avatar_video_creation_model.dart';
import 'package:gid_app_v2/models/common/fair_model.dart';
import 'package:gid_app_v2/providers/common/abstract_object_provider.dart';
import 'package:gid_app_v2/repository/avatar_repository.dart';

final avatarVideoCreateProvider = StateNotifierProviderFamily<
    AvatarVideoCreateStateNotifier,
    AvatarVideoCreationModel?,
    Pair<String, String>>(
  (ref, pair) {
    return AvatarVideoCreateStateNotifier(
      avatarRepository: ref.watch(avatarRepositoryProvider),
      avatarId: pair.first,
      creationId: pair.second,
    );
  },
);

class AvatarVideoCreateStateNotifier
    extends AbstractObjectNotifier<AvatarVideoCreationModel> {
  final AvatarRepository avatarRepository;
  final String avatarId;
  final String creationId;

  AvatarVideoCreateStateNotifier({
    required this.avatarRepository,
    required this.avatarId,
    required this.creationId,
  });

  Future<AvatarVideoCreationModel> createVideo({
    required String title,
    required String prompt,
  }) async {
    return data = await avatarRepository.createVideoFromImage(
      AvatarVideoCreationRequestModel(
        title: title,
        prompt: prompt,
      ),
      avatarId: avatarId,
      creationId: creationId,
    );
  }

  @override
  Future<AvatarVideoCreationModel> getData() async {
    return avatarRepository.getVideoCreation(
      avatarId: avatarId,
      creationId: creationId,
    );
  }

  @override
  void onState(AvatarVideoCreationModel? data) {
    // TODO: implement onState
  }
}
