// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'avatar_creation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AvatarCreationRequestModel _$AvatarCreationRequestModelFromJson(
        Map<String, dynamic> json) =>
    AvatarCreationRequestModel(
      name: json['name'] as String,
      species: json['species'] as String,
      gender: json['gender'] as String,
      age: (json['age'] as num).toInt(),
      language: json['language'] as String,
      country: json['country'] as String,
      imageStyle: $enumDecode(_$AvatarStyleEnumMap, json['image_style']),
      description: json['description'] as String?,
    );

Map<String, dynamic> _$AvatarCreationRequestModelToJson(
        AvatarCreationRequestModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'species': instance.species,
      'gender': instance.gender,
      'age': instance.age,
      'language': instance.language,
      'country': instance.country,
      'image_style': _$AvatarStyleEnumMap[instance.imageStyle]!,
      'description': instance.description,
    };

const _$AvatarStyleEnumMap = {
  AvatarStyle.realistic: 'realistic',
  AvatarStyle.cartoon: 'cartoon',
};

AvatarCreationModel _$AvatarCreationModelFromJson(Map<String, dynamic> json) =>
    AvatarCreationModel(
      id: json['id'] as String,
      imageCreations: (json['images'] as List<dynamic>?)
          ?.map((e) =>
              AvatarImageCreationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      characterCreations: (json['characters'] as List<dynamic>?)
          ?.map((e) =>
              AvatarCharacterCreationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      voiceCreations: (json['voices'] as List<dynamic>?)
          ?.map((e) =>
              AvatarVoiceCreationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      name: json['name'] as String,
      species: json['species'] as String,
      gender: json['gender'] as String,
      language: json['language'] as String,
      country: json['country'] as String,
      description: json['description'] as String?,
      imageStyle: json['image_style'] as String,
      startedAt: DateTime.parse(json['started_at'] as String),
      completedAt: json['completed_at'] == null
          ? null
          : DateTime.parse(json['completed_at'] as String),
      status: $enumDecode(_$AvatarObjectCreationStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$AvatarCreationModelToJson(
        AvatarCreationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'images': instance.imageCreations,
      'characters': instance.characterCreations,
      'voices': instance.voiceCreations,
      'name': instance.name,
      'species': instance.species,
      'gender': instance.gender,
      'language': instance.language,
      'country': instance.country,
      'description': instance.description,
      'image_style': instance.imageStyle,
      'started_at': instance.startedAt.toIso8601String(),
      'completed_at': instance.completedAt?.toIso8601String(),
      'status': _$AvatarObjectCreationStatusEnumMap[instance.status]!,
    };

const _$AvatarObjectCreationStatusEnumMap = {
  AvatarObjectCreationStatus.ready: 'ready',
  AvatarObjectCreationStatus.processing: 'processing',
  AvatarObjectCreationStatus.completed: 'completed',
  AvatarObjectCreationStatus.failed: 'failed',
};
