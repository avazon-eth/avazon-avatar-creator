// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'avatar_video_creation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AvatarVideoCreationModel _$AvatarVideoCreationModelFromJson(
        Map<String, dynamic> json) =>
    AvatarVideoCreationModel(
      id: json['id'] as String,
      avatarId: json['avatar_id'] as String,
      title: json['title'] as String,
      thumbnailUrl: json['thumbnail_url'] as String?,
      videoUrl: json['video_url'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      status: $enumDecode(_$AvatarContentCreationStatusEnumMap, json['status']),
      failedReason: json['failed_reason'] as String?,
    );

Map<String, dynamic> _$AvatarVideoCreationModelToJson(
        AvatarVideoCreationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'avatar_id': instance.avatarId,
      'title': instance.title,
      'thumbnail_url': instance.thumbnailUrl,
      'video_url': instance.videoUrl,
      'created_at': instance.createdAt.toIso8601String(),
      'status': _$AvatarContentCreationStatusEnumMap[instance.status]!,
      'failed_reason': instance.failedReason,
    };

const _$AvatarContentCreationStatusEnumMap = {
  AvatarContentCreationStatus.yet: 'yet',
  AvatarContentCreationStatus.imageProgressing: 'image_progressing',
  AvatarContentCreationStatus.imageCompleted: 'image_completed',
  AvatarContentCreationStatus.contentProgressing: 'content_progressing',
  AvatarContentCreationStatus.contentCompleted: 'content_completed',
  AvatarContentCreationStatus.completed: 'completed',
  AvatarContentCreationStatus.failed: 'failed',
};

AvatarVideoImageCreationRequestModel
    _$AvatarVideoImageCreationRequestModelFromJson(Map<String, dynamic> json) =>
        AvatarVideoImageCreationRequestModel(
          prompt: json['prompt'] as String,
        );

Map<String, dynamic> _$AvatarVideoImageCreationRequestModelToJson(
        AvatarVideoImageCreationRequestModel instance) =>
    <String, dynamic>{
      'prompt': instance.prompt,
    };

AvatarVideoCreationRequestModel _$AvatarVideoCreationRequestModelFromJson(
        Map<String, dynamic> json) =>
    AvatarVideoCreationRequestModel(
      title: json['title'] as String,
      prompt: json['prompt'] as String,
    );

Map<String, dynamic> _$AvatarVideoCreationRequestModelToJson(
        AvatarVideoCreationRequestModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'prompt': instance.prompt,
    };
