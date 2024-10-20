import 'package:avarium_avatar_creator/common/service_const.dart';
import 'package:avarium_avatar_creator/models/avatar_creation_model.dart';
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
}
