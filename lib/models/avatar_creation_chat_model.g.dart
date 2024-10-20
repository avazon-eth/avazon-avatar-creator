// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'avatar_creation_chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AvatarCreationChatModel _$AvatarCreationChatModelFromJson(
        Map<String, dynamic> json) =>
    AvatarCreationChatModel(
      id: (json['id'] as num).toInt(),
      avatarCreationId: json['avatar_creation_id'] as String,
      role: json['role'] as String,
      objectType: json['object_type'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      content: json['content'] as String,
      objectCreatedNumber: (json['object_created_number'] as num).toInt(),
      toolCallId: json['tool_call_id'] as String,
      toolCallName: json['tool_call_name'] as String,
      toolCallArguments: json['tool_call_arguments'] as String,
    );

Map<String, dynamic> _$AvatarCreationChatModelToJson(
        AvatarCreationChatModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'avatar_creation_id': instance.avatarCreationId,
      'role': instance.role,
      'object_type': instance.objectType,
      'created_at': instance.createdAt.toIso8601String(),
      'content': instance.content,
      'object_created_number': instance.objectCreatedNumber,
      'tool_call_id': instance.toolCallId,
      'tool_call_name': instance.toolCallName,
      'tool_call_arguments': instance.toolCallArguments,
    };
