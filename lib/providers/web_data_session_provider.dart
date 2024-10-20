import 'package:avarium_avatar_creator/common/utils.dart';
import 'package:avarium_avatar_creator/models/web_data_session_token_model.dart';
import 'package:avarium_avatar_creator/repository/web_data_session_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final webTokenProvider = StateNotifierProvider<WebTokenStateNotifier, bool>(
  (ref) {
    final repository = ref.watch(webDataSessionRepositoryProvider);
    return WebTokenStateNotifier(repository: repository);
  },
);

class WebTokenStateNotifier extends StateNotifier<bool> {
  final WebDataSessionRepository repository;
  static const secureStorage = FlutterSecureStorage();

  WebTokenStateNotifier({required this.repository}) : super(false);

  Future<bool> initWith(String tokenKey) async {
    try {
      final tokenInfo = await repository.getToken(
        WebDataSessionTokenRequestModel(tokenKey: tokenKey),
      );
      await secureStorage.write(
        key: "session_id",
        value: tokenInfo.dataSessionId,
      );
      await secureStorage.write(
        key: "access_token",
        value: tokenInfo.token,
      );
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
    final sessionId = await secureStorage.read(key: "session_id");
    String? accessToken = await secureStorage.read(key: "access_token");
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
