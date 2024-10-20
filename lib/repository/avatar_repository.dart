import 'package:avarium_avatar_creator/common/service_const.dart';
import 'package:avarium_avatar_creator/models/avatar_creation_model.dart';
import 'package:avarium_avatar_creator/models/avatar_model.dart';
import 'package:avarium_avatar_creator/models/avatar_video_creation_model.dart';
import 'package:avarium_avatar_creator/models/web_data_session_token_model.dart';
import 'package:avarium_avatar_creator/providers/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'avatar_repository.g.dart';

final avatarRepositoryProvider = Provider<AvatarRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return AvatarRepository(dio);
});

@RestApi(baseUrl: origin)
abstract class AvatarRepository {
  factory AvatarRepository(Dio dio, {String baseUrl}) = _AvatarRepository;

  @POST("/avatar/create/new")
  Future<AvatarCreationModel> startNewAvatarCreationSession(
    @Body() AvatarCreationRequestModel requestModel,
  );

  @PUT("/avatar/create/new")
  Future<void> putNewAvatarCreationSession(
    @Body() WebDataSessionPutRequestModel requestModel,
  );

  @GET("/avatar/{id}")
  Future<AvatarModel> getAvatar(@Path('id') String id);

  @POST('/avatar/{avatarId}/contents/create/video/image')
  Future<AvatarVideoCreationModel> createVideoImage(
    @Body() AvatarVideoImageCreationRequestModel requestModel, {
    @Path('avatarId') required String avatarId,
  });

  @GET('/avatar/{avatarId}/contents/create/video/{creationId}')
  Future<AvatarVideoCreationModel> getVideoCreation({
    @Path('avatarId') required String avatarId,
    @Path('creationId') required String creationId,
  });

  @POST('/avatar/{avatarId}/contents/create/video/{creationId}/create')
  Future<AvatarVideoCreationModel> createVideoFromImage(
    @Body() AvatarVideoCreationRequestModel requestModel, {
    @Path('avatarId') required String avatarId,
    @Path('creationId') required String creationId,
  });

  @POST('/avatar/{avatarId}/contents/create/video/{creationId}/confirm')
  Future<AvatarVideoCreationModel> confirmVideoCreation({
    @Path('avatarId') required String avatarId,
    @Query('contentId') required String contentId,
  });
}
