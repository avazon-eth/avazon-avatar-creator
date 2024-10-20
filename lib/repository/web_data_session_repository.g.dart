// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_data_session_repository.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _WebDataSessionRepository implements WebDataSessionRepository {
  _WebDataSessionRepository(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://ava.cast-ing.kr';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<WebDataSessionTokenModel> getToken(requestModel) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(requestModel.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<WebDataSessionTokenModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/web-data-session/token/fetch',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = WebDataSessionTokenModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<void> putNewAvatarCreationSession(
    requestModel,
    accessToken,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': accessToken};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(requestModel.toJson());
    await _dio.fetch<void>(_setStreamType<void>(Options(
      method: 'PUT',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/web-data-session/data',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
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
