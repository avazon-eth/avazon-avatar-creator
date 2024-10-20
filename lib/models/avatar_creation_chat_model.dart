import 'package:json_annotation/json_annotation.dart';

part 'avatar_creation_chat_model.g.dart';

@JsonSerializable()
class AvatarCreationChatModel {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'avatar_creation_id')
  String avatarCreationId;

  @JsonKey(name: 'role')
  String role; // user, assistant, tool

  @JsonKey(name: 'object_type')
  String objectType; // image, character, voice

  @JsonKey(name: 'created_at')
  DateTime createdAt;

  @JsonKey(name: 'content')
  String content;

  @JsonKey(name: 'created_object_number')
  int createdObjectNumber; // current number of objects created

  @JsonKey(name: 'tool_call_id')
  String toolCallId;

  @JsonKey(name: 'tool_call_name')
  String toolCallName;

  @JsonKey(name: 'tool_call_arguments')
  String toolCallArguments;

  AvatarCreationChatModel({
    required this.id,
    required this.avatarCreationId,
    required this.role,
    required this.objectType,
    required this.createdAt,
    required this.content,
    required this.createdObjectNumber,
    required this.toolCallId,
    required this.toolCallName,
    required this.toolCallArguments,
  });

  factory AvatarCreationChatModel.fromJson(Map<String, dynamic> json) =>
      _$AvatarCreationChatModelFromJson(json);
  Map<String, dynamic> toJson() => _$AvatarCreationChatModelToJson(this);
}
