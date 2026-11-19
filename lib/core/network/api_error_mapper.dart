import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';

import 'api_error.dart';

final class ApiErrorMapper {
  const ApiErrorMapper();

  ApiError map(DioException e) {
    switch (e.type) {
      case DioExceptionType.cancel:
        return ApiError(
          kind: ApiErrorKind.cancelled,
          message: 'Request cancelled',
          cause: e,
        );
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return ApiError(
          kind: ApiErrorKind.timeout,
          message: 'Request timed out',
          cause: e,
        );
      case DioExceptionType.transformTimeout:
        return ApiError(
          kind: ApiErrorKind.timeout,
          message: 'Response transformation timed out',
          cause: e,
        );
      case DioExceptionType.connectionError:
        return ApiError(
          kind: ApiErrorKind.network,
          message: 'Network error',
          cause: e,
        );
      case DioExceptionType.badCertificate:
        return ApiError(
          kind: ApiErrorKind.network,
          message: 'Bad certificate',
          cause: e,
        );
      case DioExceptionType.badResponse:
        break; // handled below by status
      case DioExceptionType.unknown:
        if (e.response == null) {
          return ApiError(
            kind: ApiErrorKind.unknown,
            message: e.message ?? 'Unexpected error.',
            cause: e,
          );
        }
        break;
    }

    final status = e.response?.statusCode;
    return ApiError(
      kind: _kindForStatus(status),
      message: _messageFrom(e),
      statusCode: status,
      cause: e,
      details: _detailsFrom(e),
      retryAfter: _retryAfterFrom(e),
      code: _codeFrom(e),
    );
  }

  ApiErrorKind _kindForStatus(int? s) {
    if (s == null) return ApiErrorKind.unknown;
    return switch (s) {
      401 => ApiErrorKind.unauthorized,
      403 => ApiErrorKind.forbidden,
      404 => ApiErrorKind.notFound,
      409 => ApiErrorKind.conflict,
      400 => ApiErrorKind.validation,
      422 => ApiErrorKind.validation,
      429 => ApiErrorKind.rateLimited,
      >= 400 && < 500 => ApiErrorKind.badRequest,
      >= 500 && < 600 => ApiErrorKind.server,
      _ => ApiErrorKind.unknown,
    };
  }

  /// Extracts a human-readable message from the backend envelope.
  String _messageFrom(DioException e) {
    final data = _jsonData(e.response?.data);
    if (e.response?.statusCode == 400 || e.response?.statusCode == 422) {
      final details = data is Map
          ? _formatErrors(data['errors'] ?? data['data'])
          : '';
      if (details.isNotEmpty) return details;
    }
    final message = _findMessage(data);
    if (message != null) return message;
    if (data is String && data.trim().isNotEmpty) return data.trim();
    if (data is Map) {
      final details = _formatErrors(data['errors'] ?? data['data']);
      if (details.isNotEmpty) return details;
    }
    final codeMessage = switch (_codeFrom(e)) {
      'BAD_REQUEST' => 'Bad request.',
      'VALIDATION_ERROR' => 'Validation failed.',
      'NOT_FOUND' => 'Resource not found.',
      'CONFLICT' => 'Conflict detected.',
      'FORBIDDEN' || 'PERMISSION_DENIED' =>
        'You do not have permission to perform this action.',
      'UNAUTHORIZED' => 'Authentication credentials were not provided.',
      'TOO_MANY_REQUESTS' => 'Too many requests.',
      'INTERNAL_SERVER_ERROR' => 'Internal server error.',
      'UNEXPECTED_ERROR' || 'UNKNOWN_ERROR' => 'Unexpected error.',
      'BUSINESS_VIOLATED' => 'Business rule violated.',
      'INVALID_CREDENTIALS' => 'Invalid email or password.',
      'AUTHENTICATION_FAILED' ||
      'INVALID_TOKEN' => 'Authentication credentials were not valid.',
      'TOKEN_EXPIRED' || 'REFRESH_TOKEN_EXPIRED' || 'AUTHENTICATION_EXPIRED' =>
        'Your session has expired. Please log in again.',
      _ => null,
    };
    if (codeMessage != null) return codeMessage;
    final status = e.response?.statusCode;
    return switch (status) {
      400 => 'Bad request.',
      401 => 'Authentication credentials were not provided.',
      403 => 'You do not have permission to perform this action.',
      404 => 'Resource not found.',
      409 => 'Conflict detected.',
      422 => 'Validation failed.',
      429 => 'Too many requests.',
      int value when value >= 500 => 'Internal server error.',
      int value when value >= 400 => 'Bad request.',
      _ => e.message ?? 'Unexpected error.',
    };
  }

  String _formatErrors(Object? value) {
    if (value is String) return value.trim();
    if (value is List) {
      return value
          .map(_formatErrors)
          .where((text) => text.isNotEmpty)
          .join(', ');
    }
    if (value is Map) {
      return value.entries
          .map((entry) {
            final message = _formatErrors(entry.value);
            return message.isEmpty ? '' : '${entry.key}: $message';
          })
          .where((text) => text.isNotEmpty)
          .join(', ');
    }
    return '';
  }

  String? _findMessage(Object? value) {
    if (value is Map) {
      for (final key in ['message', 'detail', 'error']) {
        final item = value[key];
        if (item is String && item.trim().isNotEmpty) return item.trim();
        final nested = _findMessage(item);
        if (nested != null) return nested;
      }
    }
    return null;
  }

  String? _codeFrom(DioException e) {
    final data = _jsonData(e.response?.data);
    if (data is! Map) return null;
    for (final value in [data['error_code'], data['code']]) {
      if (value is String && value.isNotEmpty) return value;
    }
    final error = data['error'];
    if (error is Map) {
      final code = error['code'] ?? error['error_code'];
      if (code is String && code.isNotEmpty) return code;
    }
    return null;
  }

  Map<String, dynamic>? _detailsFrom(DioException e) {
    if (e.response?.statusCode != 400 && e.response?.statusCode != 422) {
      return null;
    }
    final data = _jsonData(e.response?.data);
    if (data is Map<String, dynamic>) {
      final errors = data['errors'];
      if (errors is Map<String, dynamic>) return errors;
      final nestedData = data['data'];
      if (nestedData is Map<String, dynamic>) return nestedData;
      final fields = Map<String, dynamic>.from(data)
        ..remove('success')
        ..remove('message')
        ..remove('error')
        ..remove('meta');
      if (fields.isNotEmpty) return fields;
    }
    return null;
  }

  Object? _jsonData(Object? value) {
    try {
      if (value is Uint8List) return jsonDecode(utf8.decode(value));
      if (value is List<int>) return jsonDecode(utf8.decode(value));
      if (value is String) return jsonDecode(value);
    } catch (_) {
      return value;
    }
    return value;
  }

  Duration? _retryAfterFrom(DioException e) {
    final raw = e.response?.headers.value('retry-after');
    if (raw == null) return null;
    final seconds = int.tryParse(raw);
    if (seconds != null) return Duration(seconds: seconds);
    try {
      final date = DateTime.parse(raw);
      final diff = date.difference(DateTime.now());
      return diff.isNegative ? Duration.zero : diff;
    } catch (_) {
      return null;
    }
  }
}
