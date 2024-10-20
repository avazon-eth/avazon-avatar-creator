import 'package:json_annotation/json_annotation.dart';

part 'avatar_create_session_model.g.dart';

@JsonSerializable()
class AvatarCreateSessionRequest {
  @JsonKey(name: 'object_type')
  String objectType; // image, character, voice, all
  String event; // chat, close, confirm
  String content;

  AvatarCreateSessionRequest({
    required this.objectType,
    required this.event,
    required this.content,
  });

  factory AvatarCreateSessionRequest.fromJson(Map<String, dynamic> json) =>
      _$AvatarCreateSessionRequestFromJson(json);
  Map<String, dynamic> toJson() => _$AvatarCreateSessionRequestToJson(this);
}

@JsonSerializable()
class AvatarCreateSessionResponse {
  @JsonKey(name: 'object_type')
  String objectType; // image, character, voice, all
  String event; // chat, chunk, creation, close, error
  String content;

  AvatarCreateSessionResponse({
    required this.objectType,
    required this.event,
    required this.content,
  });

  factory AvatarCreateSessionResponse.fromJson(Map<String, dynamic> json) =>
      _$AvatarCreateSessionResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AvatarCreateSessionResponseToJson(this);
}
