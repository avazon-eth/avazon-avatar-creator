import 'package:json_annotation/json_annotation.dart';

part 'avatar_model.g.dart';

@JsonSerializable()
class AvatarModel {
  final String id;
  @JsonKey(name: 'remix_avatar_id')
  final String? remixAvatarID;
  final String name;
  final String species;
  final String gender;
  final String language;
  final String country;
  final String description;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'profile_image_url')
  final String profileImageUrl;
  @JsonKey(name: 'voice_url')
  final String voiceURL;
  @JsonKey(name: 'avatar_video_url')
  final String? avatarVideoURL; // mock: used for test realtime chatting
  @JsonKey(name: 'character_description')
  final String characterDescription;

  AvatarModel({
    required this.id,
    required this.remixAvatarID,
    required this.name,
    required this.species,
    required this.gender,
    required this.language,
    required this.country,
    required this.description,
    required this.createdAt,
    required this.profileImageUrl,
    required this.voiceURL,
    this.avatarVideoURL,
    required this.characterDescription,
  });

  factory AvatarModel.fromJson(Map<String, dynamic> json) =>
      _$AvatarModelFromJson(json);
  Map<String, dynamic> toJson() => _$AvatarModelToJson(this);
}
