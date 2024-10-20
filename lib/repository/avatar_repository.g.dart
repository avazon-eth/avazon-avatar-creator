// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'avatar_repository.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _AvatarRepository implements AvatarRepository {
  _AvatarRepository(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'http://13.52.74.27:8080';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<AvatarCreationModel> startNewAvatarCreationSession(
      requestModel) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(requestModel.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AvatarCreationModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/avatar/create/new',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AvatarCreationModel.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
