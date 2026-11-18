import 'dart:typed_data';

import 'package:dio/dio.dart';

import 'api_result.dart';

abstract interface class ApiClient {
  Future<ApiResult<Uint8List>> getBytes(
    String path, {
    Map<String, dynamic>? query,
    CancelToken? cancelToken,
    bool requireAuth = true,
  });

  Future<ApiResult<T>> get<T>(
    String path, {
    Map<String, dynamic>? query,
    required T Function(Object? json) decode,
    CancelToken? cancelToken,
    bool requireAuth = true,
  });

  Future<ApiResult<T>> post<T>(
    String path, {
    Object? body,
    required T Function(Object? json) decode,
    CancelToken? cancelToken,
    bool requireAuth = true,
    bool isIdempotent = false,
  });

  Future<ApiResult<T>> put<T>(
    String path, {
    Object? body,
    required T Function(Object? json) decode,
    CancelToken? cancelToken,
    bool requireAuth = true,
    bool isIdempotent = false,
  });

  Future<ApiResult<T>> patch<T>(
    String path, {
    Object? body,
    required T Function(Object? json) decode,
    CancelToken? cancelToken,
    bool requireAuth = true,
    bool isIdempotent = false,
  });

  Future<ApiResult<T>> delete<T>(
    String path, {
    Object? body,
    required T Function(Object? json) decode,
    CancelToken? cancelToken,
    bool requireAuth = true,
    bool isIdempotent = true,
  });
}
