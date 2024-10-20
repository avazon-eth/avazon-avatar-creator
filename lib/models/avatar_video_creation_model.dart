import 'package:avarium_avatar_creator/models/avatar_content_creation_status.dart';
import 'package:json_annotation/json_annotation.dart';

part 'avatar_video_creation_model.g.dart';

@JsonSerializable()
class AvatarVideoCreationModel {
  final String id;
  @JsonKey(name: 'avatar_id')
  final String avatarId;
  @JsonKey(name: 'thumbnail_image_url')
  final String? thumbnailImageUrl;
  @JsonKey(name: 'content_url')
  final String? contentUrl;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  final AvatarContentCreationStatus status;
  @JsonKey(name: 'failed_reason')
  final String? failedReason;

  AvatarVideoCreationModel({
    required this.id,
    required this.avatarId,
    this.thumbnailImageUrl,
    this.contentUrl,
    required this.createdAt,
    required this.status,
    this.failedReason,
  });

  factory AvatarVideoCreationModel.fromJson(Map<String, dynamic> json) =>
      _$AvatarVideoCreationModelFromJson(json);

  Map<String, dynamic> toJson() => _$AvatarVideoCreationModelToJson(this);
}

@JsonSerializable()
class AvatarVideoImageCreationRequestModel {
  final String prompt;

  const AvatarVideoImageCreationRequestModel({
    required this.prompt,
  });

  factory AvatarVideoImageCreationRequestModel.fromJson(
          Map<String, dynamic> json) =>
      _$AvatarVideoImageCreationRequestModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AvatarVideoImageCreationRequestModelToJson(this);
}

@JsonSerializable()
class AvatarVideoCreationRequestModel {
  final String title;
  final String prompt;

  const AvatarVideoCreationRequestModel({
    required this.title,
    required this.prompt,
  });

  factory AvatarVideoCreationRequestModel.fromJson(Map<String, dynamic> json) =>
      _$AvatarVideoCreationRequestModelFromJson(json);
}
