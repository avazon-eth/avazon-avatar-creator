import 'package:json_annotation/json_annotation.dart';

enum AvatarContentCreationStatus {
  yet,
  @JsonValue('image_progressing')
  imageProgressing,
  @JsonValue('image_completed')
  imageCompleted,
  @JsonValue('content_progressing')
  contentProgressing,
  @JsonValue('content_completed')
  contentCompleted,
  @JsonValue('completed')
  completed,
  @JsonValue('failed')
  failed;
}
