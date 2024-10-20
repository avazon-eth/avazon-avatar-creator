// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_data_session_token_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebDataSessionTokenModel _$WebDataSessionTokenModelFromJson(
        Map<String, dynamic> json) =>
    WebDataSessionTokenModel(
      dataSessionId: json['data_session_id'] as String,
      token: json['token'] as String,
    );

Map<String, dynamic> _$WebDataSessionTokenModelToJson(
        WebDataSessionTokenModel instance) =>
    <String, dynamic>{
      'data_session_id': instance.dataSessionId,
      'token': instance.token,
    };

WebDataSessionTokenRequestModel _$WebDataSessionTokenRequestModelFromJson(
        Map<String, dynamic> json) =>
    WebDataSessionTokenRequestModel(
      tokenKey: json['token_key'] as String,
    );

Map<String, dynamic> _$WebDataSessionTokenRequestModelToJson(
        WebDataSessionTokenRequestModel instance) =>
    <String, dynamic>{
      'token_key': instance.tokenKey,
    };

WebDataSessionPutRequestModel _$WebDataSessionPutRequestModelFromJson(
        Map<String, dynamic> json) =>
    WebDataSessionPutRequestModel(
      sessionId: json['session_id'] as String,
      data: json['data'] as String,
    );

Map<String, dynamic> _$WebDataSessionPutRequestModelToJson(
        WebDataSessionPutRequestModel instance) =>
    <String, dynamic>{
      'session_id': instance.sessionId,
      'data': instance.data,
    };
