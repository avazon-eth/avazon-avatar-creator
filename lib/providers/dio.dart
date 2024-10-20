import 'package:avarium_avatar_creator/common/utils.dart';
import 'package:avarium_avatar_creator/providers/secret_value_provider.dart';
import 'package:avarium_avatar_creator/providers/secure_storage_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(connectTimeout: const Duration(minutes: 10)),
  );
  dio.interceptors.add(CustomInterceptor(ref: ref));
  return dio;
});

class CustomInterceptor extends Interceptor {
  final Ref ref;

  const CustomInterceptor({required this.ref});

  Future<String?> get accessTokenAsync async => await ref
      .read(secretValueProvider("access_token").notifier)
      .fetchIfNull();

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    Utils.d('[REQ] [${options.method}] ${options.uri}');
    Utils.d('[REQ] data(type=${options.data.runtimeType}) = ${options.data}');
    String? accessToken = await accessTokenAsync;
    if (accessToken != null) {
      Utils.d('accessToken inserted');
      options.headers.addAll({"Authorization": "Bearer $accessToken"});
    }
    return super.onRequest(options, handler);
  }
}
