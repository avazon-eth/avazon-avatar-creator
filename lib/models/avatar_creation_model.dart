import 'package:avarium_avatar_creator/models/avatar_object_creation_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'avatar_creation_model.g.dart';

enum AvatarStyle {
  realistic,
  cartoon,
}

@JsonSerializable()
class AvatarCreationRequestModel {
  String name; // ex) John Doe
  String species; // ex) human, alien, robot, etc.
  String gender; // ex) male, female, mixed, etc.
  int age; // Age must be greater than 0
  String language; // ex) English
  String country; // ex) United States
  @JsonKey(name: 'image_style')
  AvatarStyle imageStyle; // cartoon, realistic
  String? description; // optional

  AvatarCreationRequestModel({
    required this.name,
    required this.species,
    required this.gender,
    required this.age,
    required this.language,
    required this.country,
    required this.imageStyle,
    this.description,
  });

  factory AvatarCreationRequestModel.fromJson(Map<String, dynamic> json) =>
      _$AvatarCreationRequestModelFromJson(json);
  Map<String, dynamic> toJson() => _$AvatarCreationRequestModelToJson(this);
}

@JsonSerializable()
class AvatarCreationModel {
  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'images')
  List<AvatarImageCreationModel>? imageCreations;

  @JsonKey(name: 'characters')
  List<AvatarCharacterCreationModel>? characterCreations;

  @JsonKey(name: 'voices')
  List<AvatarVoiceCreationModel>? voiceCreations;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'species')
  String species;

  @JsonKey(name: 'gender')
  String gender;

  // @JsonKey(name: 'age')
  // int age;

  @JsonKey(name: 'language')
  String language;

  @JsonKey(name: 'country')
  String country;

  @JsonKey(name: 'description')
  String? description;

  @JsonKey(name: 'image_style')
  String imageStyle;

  @JsonKey(name: 'started_at')
  DateTime startedAt;

  @JsonKey(name: 'completed_at')
  DateTime? completedAt;

  @JsonKey(name: 'status')
  AvatarObjectCreationStatus status;

  AvatarCreationModel({
    required this.id,
    this.imageCreations,
    this.characterCreations,
    this.voiceCreations,
    required this.name,
    required this.species,
    required this.gender,
    // required this.age,
    required this.language,
    required this.country,
    this.description,
    required this.imageStyle,
    required this.startedAt,
    this.completedAt,
    required this.status,
  });

  String? get imageUrl {
    if (imageCreations == null || imageCreations!.isEmpty) {
      return null;
    }
    return imageCreations!.last.imageUrl;
  }

  String? get voiceUrl {
    if (voiceCreations == null || voiceCreations!.isEmpty) {
      return null;
    }
    return voiceCreations!.last.voiceUrl;
  }

  bool get canCreateNow =>
      imageStatus == AvatarObjectCreationStatus.completed &&
      characterStatus == AvatarObjectCreationStatus.completed &&
      voiceStatus == AvatarObjectCreationStatus.completed;

  AvatarObjectCreationStatus get imageStatus {
    if (imageCreations == null || imageCreations!.isEmpty) {
      return AvatarObjectCreationStatus.ready;
    }
    return imageCreations!.last.status;
  }

  AvatarObjectCreationStatus get characterStatus {
    if (characterCreations == null || characterCreations!.isEmpty) {
      return AvatarObjectCreationStatus.ready;
    }
    return characterCreations!.last.status;
  }

  AvatarObjectCreationStatus get voiceStatus {
    if (voiceCreations == null || voiceCreations!.isEmpty) {
      return AvatarObjectCreationStatus.ready;
    }
    return voiceCreations!.last.status;
  }

  factory AvatarCreationModel.fromJson(Map<String, dynamic> json) =>
      _$AvatarCreationModelFromJson(json);
  Map<String, dynamic> toJson() => _$AvatarCreationModelToJson(this);

  AvatarCreationModel copyWith({
    String? id,
    List<AvatarImageCreationModel>? imageCreations,
    List<AvatarCharacterCreationModel>? characterCreations,
    List<AvatarVoiceCreationModel>? voiceCreations,
    String? name,
    String? species,
    String? gender,
    // int? age,
    String? language,
    String? country,
    String? description,
    String? imageStyle,
    DateTime? startedAt,
    DateTime? completedAt,
    AvatarObjectCreationStatus? status,
  }) {
    return AvatarCreationModel(
      id: id ?? this.id,
      imageCreations: imageCreations ?? this.imageCreations,
      characterCreations: characterCreations ?? this.characterCreations,
      voiceCreations: voiceCreations ?? this.voiceCreations,
      name: name ?? this.name,
      species: species ?? this.species,
      gender: gender ?? this.gender,
      // age: age ?? this.age,
      language: language ?? this.language,
      country: country ?? this.country,
      description: description ?? this.description,
      imageStyle: imageStyle ?? this.imageStyle,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      status: status ?? this.status,
    );
  }
}
