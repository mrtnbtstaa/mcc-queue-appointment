import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../storage/token_store.dart';
import 'api_client.dart';
import 'dio_api_client.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/logging_interceptor.dart';
import 'interceptors/retry_interceptor.dart';

/// Builds the ApiClient with all interceptors wired.
///
/// [onRefreshFailed] must clear tokens and signal your auth BLoC/Cubit.
/// It must not navigate and must not throw — see `AuthInterceptor`.
ApiClient buildApiClient({
  required String baseUrl,
  required TokenStore tokenStore,
  required Future<void> Function() onRefreshFailed,
}) {
  final mainDio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 20),
      sendTimeout: const Duration(seconds: 20),
    ),
  );

  final refreshDio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 20),
    ),
  );

  mainDio.interceptors.addAll([
    AuthInterceptor(
      dio: mainDio,
      refreshDio: refreshDio,
      tokenStore: tokenStore,
      onRefreshFailed: onRefreshFailed,
    ),
    RetryInterceptor(dio: mainDio),
    if (kDebugMode) LoggingInterceptor(),
  ]);

  return DioApiClient(mainDio);
}
