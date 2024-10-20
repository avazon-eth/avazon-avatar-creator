// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PageResponseModel _$PageResponseModelFromJson(Map<String, dynamic> json) =>
    PageResponseModel(
      items: (json['items'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
      total: (json['total'] as num).toInt(),
    );

Map<String, dynamic> _$PageResponseModelToJson(PageResponseModel instance) =>
    <String, dynamic>{
      'items': instance.items,
      'total': instance.total,
    };
