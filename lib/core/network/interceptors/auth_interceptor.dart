import 'dart:async';

import 'package:dio/dio.dart';

import '../../auth/user_role_mapper.dart';
import '../../storage/token_store.dart';

/// Attaches the bearer token and performs single-flight refresh on 401.
///
/// Uses [QueuedInterceptor] so concurrent 401s are handled serially —
/// combined with the per-request `_authRetried` flag, this guarantees
/// exactly one refresh and one replay per request.
final class AuthInterceptor extends QueuedInterceptor {
  final Dio _dio;
  final Dio _refreshDio;
  final TokenStore _tokenStore;
  final Future<void> Function() _onRefreshFailed;

  AuthInterceptor({
    required Dio dio,
    required Dio refreshDio,
    required TokenStore tokenStore,
    required Future<void> Function() onRefreshFailed,
  }) : _dio = dio,
       _refreshDio = refreshDio,
       _tokenStore = tokenStore,
       _onRefreshFailed = onRefreshFailed;

  Future<void>? _refreshInFlight;

  static const _kRetried = '_authRetried';
  static const _kSkipAuth = '_skipAuth';
  static const _kSkipRetry = '_skipRetry';

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.extra[_kSkipAuth] == true) {
      return handler.next(options);
    }

    final token = await _tokenStore.readAccessToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    return handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final status = err.response?.statusCode;
    final req = err.requestOptions;

    if (status != 401 ||
        req.extra[_kRetried] == true ||
        req.extra[_kSkipAuth] == true) {
      return handler.next(err);
    }

    req.extra[_kRetried] = true;

    try {
      _refreshInFlight ??= _refresh().whenComplete(
        () => _refreshInFlight = null,
      );
      await _refreshInFlight;
    } catch (_) {
      await _safeNotifyRefreshFailed();
      return handler.next(err);
    }

    try {
      final token = await _tokenStore.readAccessToken();
      if (token == null || token.isEmpty) {
        await _safeNotifyRefreshFailed();
        return handler.next(err);
      }
      req.headers['Authorization'] = 'Bearer $token';
      final response = await _dio.fetch<dynamic>(req);
      return handler.resolve(response);
    } on DioException catch (e) {
      return handler.next(e);
    }
  }

  Future<void> _safeNotifyRefreshFailed() async {
    try {
      await _onRefreshFailed();
    } catch (_) {
      // Never mask the original 401 with a storage/plugin error from logout.
    }
  }

  Future<void> _refresh() async {
    final refreshToken = await _tokenStore.readRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) {
      throw StateError('No refresh token available');
    }

    final res = await _refreshDio.post<Map<String, dynamic>>(
      'v1/auth/refresh/',
      data: {'refresh': refreshToken},
      options: Options(extra: {_kSkipAuth: true, _kSkipRetry: true}),
    );

    final body = res.data?['data'] is Map<String, dynamic>
        ? res.data!['data'] as Map<String, dynamic>
        : res.data ?? const <String, dynamic>{};
    final access = (body['access_token'] ?? body['access']) as String?;
    final newRefresh = (body['refresh_token'] ?? body['refresh']) as String?;
    final role = body['role'] as String?;
    // ───────────────────────────────────────────────

    if (access == null || access.isEmpty) {
      throw StateError('Refresh response missing access_token');
    }
    await _tokenStore.writeTokens(
      access: access,
      refresh: newRefresh,
      role: role == null ? await _tokenStore.readRole() : mapRole(role),
    );
  }
}
