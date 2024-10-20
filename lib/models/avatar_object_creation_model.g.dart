// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'avatar_object_creation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AvatarImageCreationModel _$AvatarImageCreationModelFromJson(
        Map<String, dynamic> json) =>
    AvatarImageCreationModel(
      id: (json['id'] as num).toInt(),
      avatarCreationId: json['avatar_creation_id'] as String,
      prompt: json['prompt'] as String,
      imageUrl: json['image_url'] as String,
      status: $enumDecode(_$AvatarObjectCreationStatusEnumMap, json['status']),
      failedReason: json['failed_reason'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$AvatarImageCreationModelToJson(
        AvatarImageCreationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'avatar_creation_id': instance.avatarCreationId,
      'prompt': instance.prompt,
      'image_url': instance.imageUrl,
      'status': _$AvatarObjectCreationStatusEnumMap[instance.status]!,
      'failed_reason': instance.failedReason,
      'created_at': instance.createdAt.toIso8601String(),
    };

const _$AvatarObjectCreationStatusEnumMap = {
  AvatarObjectCreationStatus.ready: 'ready',
  AvatarObjectCreationStatus.processing: 'processing',
  AvatarObjectCreationStatus.completed: 'completed',
  AvatarObjectCreationStatus.failed: 'failed',
};

AvatarCharacterCreationModel _$AvatarCharacterCreationModelFromJson(
        Map<String, dynamic> json) =>
    AvatarCharacterCreationModel(
      id: (json['id'] as num).toInt(),
      avatarCreationId: json['avatar_creation_id'] as String,
      prompt: json['prompt'] as String,
      content: json['content'] as String,
      status: $enumDecode(_$AvatarObjectCreationStatusEnumMap, json['status']),
      failedReason: json['failed_reason'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$AvatarCharacterCreationModelToJson(
        AvatarCharacterCreationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'avatar_creation_id': instance.avatarCreationId,
      'prompt': instance.prompt,
      'content': instance.content,
      'status': _$AvatarObjectCreationStatusEnumMap[instance.status]!,
      'failed_reason': instance.failedReason,
      'created_at': instance.createdAt.toIso8601String(),
    };

AvatarVoiceCreationModel _$AvatarVoiceCreationModelFromJson(
        Map<String, dynamic> json) =>
    AvatarVoiceCreationModel(
      id: (json['id'] as num).toInt(),
      avatarCreationId: json['avatar_creation_id'] as String,
      prompt: json['prompt'] as String,
      voiceUrl: json['voice_url'] as String,
      status: $enumDecode(_$AvatarObjectCreationStatusEnumMap, json['status']),
      failedReason: json['failed_reason'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$AvatarVoiceCreationModelToJson(
        AvatarVoiceCreationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'avatar_creation_id': instance.avatarCreationId,
      'prompt': instance.prompt,
      'voice_url': instance.voiceUrl,
      'status': _$AvatarObjectCreationStatusEnumMap[instance.status]!,
      'failed_reason': instance.failedReason,
      'created_at': instance.createdAt.toIso8601String(),
    };
