import 'package:json_annotation/json_annotation.dart';

part 'page_response_model.g.dart';

@JsonSerializable()
class PageResponseModel {
  final List<Map<String, dynamic>> items;
  final int total;

  const PageResponseModel({
    required this.items,
    required this.total,
  });

  factory PageResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PageResponseModelFromJson(json);

  List<T> getData<T>(T Function(Map<String, dynamic>) fromJsonCbk) {
    return items.map(fromJsonCbk).toList();
  }
}
