import 'dart:math';

import 'package:dio/dio.dart';

// Retries transient failures with exponential backoff + full jitter.
// Never retries non-idempotent requests unless the caller opts in.
final class RetryInterceptor extends Interceptor {
  RetryInterceptor({
    required Dio dio,
    this.maxAttempts = 3,
    this.baseDelay = const Duration(milliseconds: 500),
    this.maxDelay = const Duration(seconds: 10),
  }) : _dio = dio;

  final Dio _dio;
  final int maxAttempts;
  final Duration baseDelay;
  final Duration maxDelay;

  static const _kAttempt = '_retryAttempt';
  static const _kIdempotent = '_idempotent';
  static const _kSkipRetry = '_skipRetry';

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final req = err.requestOptions;

    if (req.extra[_kSkipRetry] == true) return handler.next(err);
    if (!_isRetryable(err, req)) return handler.next(err);

    final attempt = (req.extra[_kAttempt] as int?) ?? 0;
    if (attempt >= maxAttempts) return handler.next(err);

    req.extra[_kAttempt] = attempt + 1;

    final capMs = min(
      maxDelay.inMilliseconds,
      baseDelay.inMilliseconds * pow(2, attempt).toInt(),
    );
    final delayMs = Random().nextInt(capMs + 1);
    await Future<void>.delayed(Duration(milliseconds: delayMs));

    try {
      final response = await _dio.fetch<dynamic>(req);
      return handler.resolve(response);
    } on DioException catch (e) {
      return handler.next(e);
    }
  }

  bool _isRetryable(DioException err, RequestOptions req) {
    if (err.type == DioExceptionType.cancel) return false;

    if (err.type == DioExceptionType.connectionError ||
        err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.sendTimeout) {
      return _methodMayRetry(req);
    }

    final status = err.response?.statusCode;
    if (status == null) return _methodMayRetry(req);

    if (status == 408 || status == 429) return _methodMayRetry(req);
    if (status >= 500 && status < 600) return _methodMayRetry(req);

    return false;
  }

  bool _methodMayRetry(RequestOptions req) {
    final m = req.method.toUpperCase();
    if (m == 'GET' || m == 'HEAD' || m == 'DELETE') return true;
    return req.extra[_kIdempotent] == true;
  }
}
