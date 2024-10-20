import 'package:avarium_avatar_creator/common/service_const.dart';
import 'package:avarium_avatar_creator/models/web_data_session_token_model.dart';
import 'package:avarium_avatar_creator/providers/dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

part 'web_data_session_repository.g.dart';

final webDataSessionRepositoryProvider =
    Provider<WebDataSessionRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return WebDataSessionRepository(dio);
});

@RestApi(baseUrl: origin)
abstract class WebDataSessionRepository {
  factory WebDataSessionRepository(Dio dio, {String baseUrl}) =
      _WebDataSessionRepository;

  @POST('/web-data-session/token/fetch')
  Future<WebDataSessionTokenModel> getToken(
    @Body() WebDataSessionTokenRequestModel requestModel,
  );

  @PUT('/web-data-session/data')
  Future<void> putNewAvatarCreationSession(
    @Body() WebDataSessionPutRequestModel requestModel,
    @Header('Authorization') String accessToken,
  );
}
