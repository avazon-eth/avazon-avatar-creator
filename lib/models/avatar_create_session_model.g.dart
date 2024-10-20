// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'avatar_create_session_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AvatarCreateSessionRequest _$AvatarCreateSessionRequestFromJson(
        Map<String, dynamic> json) =>
    AvatarCreateSessionRequest(
      objectType: json['object_type'] as String,
      event: json['event'] as String,
      content: json['content'] as String,
    );

Map<String, dynamic> _$AvatarCreateSessionRequestToJson(
        AvatarCreateSessionRequest instance) =>
    <String, dynamic>{
      'object_type': instance.objectType,
      'event': instance.event,
      'content': instance.content,
    };

AvatarCreateSessionResponse _$AvatarCreateSessionResponseFromJson(
        Map<String, dynamic> json) =>
    AvatarCreateSessionResponse(
      objectType: json['object_type'] as String,
      event: json['event'] as String,
      content: json['content'] as String,
    );

Map<String, dynamic> _$AvatarCreateSessionResponseToJson(
        AvatarCreateSessionResponse instance) =>
    <String, dynamic>{
      'object_type': instance.objectType,
      'event': instance.event,
      'content': instance.content,
    };
