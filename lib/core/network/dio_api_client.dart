import 'dart:typed_data';

import 'package:dio/dio.dart';

import 'api_client.dart';
import 'api_error.dart';
import 'api_error_mapper.dart';
import 'api_result.dart';

final class DioApiClient implements ApiClient {
  DioApiClient(this._dio, {ApiErrorMapper? errorMapper})
    : _errorMapper = errorMapper ?? const ApiErrorMapper();

  final Dio _dio;
  final ApiErrorMapper _errorMapper;

  @override
  Future<ApiResult<Uint8List>> getBytes(
    String path, {
    Map<String, dynamic>? query,
    CancelToken? cancelToken,
    bool requireAuth = true,
  }) => _run(
    () => _dio.get<List<int>>(
      path,
      queryParameters: query,
      cancelToken: cancelToken,
      options: _opts(requireAuth).copyWith(responseType: ResponseType.bytes),
    ),
    (json) => Uint8List.fromList(json as List<int>),
  );

  @override
  Future<ApiResult<T>> get<T>(
    String path, {
    Map<String, dynamic>? query,
    required T Function(Object? json) decode,
    CancelToken? cancelToken,
    bool requireAuth = true,
  }) => _run(
    () => _dio.get<dynamic>(
      path,
      queryParameters: query,
      cancelToken: cancelToken,
      options: _opts(requireAuth),
    ),
    decode,
  );

  @override
  Future<ApiResult<T>> post<T>(
    String path, {
    Object? body,
    required T Function(Object? json) decode,
    CancelToken? cancelToken,
    bool requireAuth = true,
    bool isIdempotent = false,
  }) => _run(
    () => _dio.post<dynamic>(
      path,
      data: body,
      cancelToken: cancelToken,
      options: _opts(requireAuth, idempotent: isIdempotent),
    ),
    decode,
  );

  @override
  Future<ApiResult<T>> put<T>(
    String path, {
    Object? body,
    required T Function(Object? json) decode,
    CancelToken? cancelToken,
    bool requireAuth = true,
    bool isIdempotent = false,
  }) => _run(
    () => _dio.put<dynamic>(
      path,
      data: body,
      cancelToken: cancelToken,
      options: _opts(requireAuth, idempotent: isIdempotent),
    ),
    decode,
  );

  @override
  Future<ApiResult<T>> patch<T>(
    String path, {
    Object? body,
    required T Function(Object? json) decode,
    CancelToken? cancelToken,
    bool requireAuth = true,
    bool isIdempotent = false,
  }) => _run(
    () => _dio.patch<dynamic>(
      path,
      data: body,
      cancelToken: cancelToken,
      options: _opts(requireAuth, idempotent: isIdempotent),
    ),
    decode,
  );

  @override
  Future<ApiResult<T>> delete<T>(
    String path, {
    Object? body,
    required T Function(Object? json) decode,
    CancelToken? cancelToken,
    bool requireAuth = true,
    bool isIdempotent = true,
  }) => _run(
    () => _dio.delete<dynamic>(
      path,
      data: body,
      cancelToken: cancelToken,
      options: _opts(requireAuth, idempotent: isIdempotent),
    ),
    decode,
  );

  Options _opts(bool requireAuth, {bool? idempotent}) => Options(
    extra: {if (!requireAuth) '_skipAuth': true, '_idempotent': ?idempotent},
  );

  Future<ApiResult<T>> _run<T>(
    Future<Response<dynamic>> Function() call,
    T Function(Object? json) decode,
  ) async {
    try {
      final res = await call();
      return ApiSuccess(decode(res.data));
    } on DioException catch (e) {
      return ApiFailure(_errorMapper.map(e));
    } catch (e) {
      return ApiFailure(
        ApiError(
          kind: ApiErrorKind.parse,
          message: 'Failed to parse response: $e',
          cause: e,
        ),
      );
    }
  }
}
