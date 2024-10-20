// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'avatar_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AvatarModel _$AvatarModelFromJson(Map<String, dynamic> json) => AvatarModel(
      id: json['id'] as String,
      remixAvatarID: json['remix_avatar_id'] as String?,
      name: json['name'] as String,
      species: json['species'] as String,
      gender: json['gender'] as String,
      language: json['language'] as String,
      country: json['country'] as String,
      description: json['description'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      profileImageUrl: json['profile_image_url'] as String,
      voiceURL: json['voice_url'] as String,
      avatarVideoURL: json['avatar_video_url'] as String?,
      characterDescription: json['character_description'] as String,
    );

Map<String, dynamic> _$AvatarModelToJson(AvatarModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'remix_avatar_id': instance.remixAvatarID,
      'name': instance.name,
      'species': instance.species,
      'gender': instance.gender,
      'language': instance.language,
      'country': instance.country,
      'description': instance.description,
      'created_at': instance.createdAt.toIso8601String(),
      'profile_image_url': instance.profileImageUrl,
      'voice_url': instance.voiceURL,
      'avatar_video_url': instance.avatarVideoURL,
      'character_description': instance.characterDescription,
    };
