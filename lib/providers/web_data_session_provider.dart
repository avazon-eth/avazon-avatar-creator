import 'package:avarium_avatar_creator/common/utils.dart';
import 'package:avarium_avatar_creator/models/web_data_session_token_model.dart';
import 'package:avarium_avatar_creator/providers/secret_value_provider.dart';
import 'package:avarium_avatar_creator/repository/web_data_session_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final webTokenProvider = StateNotifierProvider<WebTokenStateNotifier, bool>(
  (ref) {
    final repository = ref.watch(webDataSessionRepositoryProvider);
    return WebTokenStateNotifier(ref: ref, repository: repository);
  },
);

class WebTokenStateNotifier extends StateNotifier<bool> {
  final Ref ref;
  final WebDataSessionRepository repository;

  WebTokenStateNotifier({
    required this.ref,
    required this.repository,
  }) : super(false);

  Future<bool> initWith(String tokenKey) async {
    try {
      final tokenInfo = await repository.getToken(
        WebDataSessionTokenRequestModel(tokenKey: tokenKey),
      );
      await ref
          .read(secretValueProvider("session_id").notifier)
          .save(tokenInfo.dataSessionId);
      await ref
          .read(secretValueProvider("access_token").notifier)
          .save(tokenInfo.token);
      state = true;
      Utils.d('token fetch success');
    } catch (e) {
      Utils.d(e.toString());
      Utils.showErrorToast();
      state = false;
    }
    return state;
  }

  Future<void> putData(String data) async {
    final sessionId = await ref
        .read(secretValueProvider("session_id").notifier)
        .fetchIfNull();
    String? accessToken = await ref
        .read(secretValueProvider("access_token").notifier)
        .fetchIfNull();
    if (sessionId != null && accessToken != null) {
      if (!accessToken.startsWith('Bearer ')) {
        accessToken = 'Bearer $accessToken';
      }
      await repository.putNewAvatarCreationSession(
        WebDataSessionPutRequestModel(
          sessionId: sessionId,
          data: data,
        ),
        accessToken,
      );
    } else {
      Utils.showErrorToast(message: 'Session ID is not found');
    }
  }
}
