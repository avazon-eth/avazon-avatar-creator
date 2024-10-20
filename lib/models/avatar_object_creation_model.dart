import 'package:json_annotation/json_annotation.dart';

part 'avatar_object_creation_model.g.dart';

enum AvatarObjectCreationStatus {
  ready(1),
  processing(2),
  completed(3),
  failed(4);

  final int progressNumber;

  const AvatarObjectCreationStatus(this.progressNumber);

  bool get isCompleted => this == AvatarObjectCreationStatus.completed;
}

@JsonSerializable()
class AvatarImageCreationModel {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'avatar_creation_id')
  String avatarCreationId;

  @JsonKey(name: 'prompt')
  String prompt;

  @JsonKey(name: 'image_url')
  String imageUrl;

  @JsonKey(name: 'status')
  AvatarObjectCreationStatus status;

  @JsonKey(name: 'failed_reason')
  String failedReason;

  @JsonKey(name: 'created_at')
  DateTime createdAt;

  AvatarImageCreationModel({
    required this.id,
    required this.avatarCreationId,
    required this.prompt,
    required this.imageUrl,
    required this.status,
    required this.failedReason,
    required this.createdAt,
  });

  factory AvatarImageCreationModel.fromJson(Map<String, dynamic> json) =>
      _$AvatarImageCreationModelFromJson(json);
  Map<String, dynamic> toJson() => _$AvatarImageCreationModelToJson(this);
}

@JsonSerializable()
class AvatarCharacterCreationModel {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'avatar_creation_id')
  String avatarCreationId;

  @JsonKey(name: 'prompt')
  String prompt;

  @JsonKey(name: 'content')
  String content;

  @JsonKey(name: 'status')
  AvatarObjectCreationStatus status;

  @JsonKey(name: 'failed_reason')
  String? failedReason; // Changed to nullable

  @JsonKey(name: 'created_at')
  DateTime createdAt;

  AvatarCharacterCreationModel({
    required this.id,
    required this.avatarCreationId,
    required this.prompt,
    required this.content,
    required this.status,
    this.failedReason, // Made optional
    required this.createdAt,
  });

  factory AvatarCharacterCreationModel.fromJson(Map<String, dynamic> json) =>
      _$AvatarCharacterCreationModelFromJson(json);
  Map<String, dynamic> toJson() => _$AvatarCharacterCreationModelToJson(this);
}

@JsonSerializable()
class AvatarVoiceCreationModel {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'avatar_creation_id')
  String avatarCreationId;

  @JsonKey(name: 'prompt')
  String prompt;

  @JsonKey(name: 'voice_url')
  String voiceUrl;

  @JsonKey(name: 'status')
  AvatarObjectCreationStatus status;

  @JsonKey(name: 'failed_reason')
  String? failedReason; // Changed to nullable

  @JsonKey(name: 'created_at')
  DateTime createdAt;

  AvatarVoiceCreationModel({
    required this.id,
    required this.avatarCreationId,
    required this.prompt,
    required this.voiceUrl,
    required this.status,
    this.failedReason, // Made optional
    required this.createdAt,
  });

  factory AvatarVoiceCreationModel.fromJson(Map<String, dynamic> json) =>
      _$AvatarVoiceCreationModelFromJson(json);
  Map<String, dynamic> toJson() => _$AvatarVoiceCreationModelToJson(this);
}
