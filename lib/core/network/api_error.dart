/// Transport-level error categories. These describe *HTTP semantics*, not
/// business rules — a `code` like "SUBSCRIPTION_EXPIRED" belongs in
/// `details`, mapped by a repository, not here.
enum ApiErrorKind {
  network,
  timeout,
  unauthorized, // 401
  forbidden, // 403
  notFound, // 404
  conflict, // 409
  rateLimited, // 429
  validation, // 422 
  badRequest, // generic 4xx
  server, // 5xx
  cancelled,
  parse,
  unknown,
}

final class ApiError {
  const ApiError({
    required this.kind,
    required this.message,
    this.statusCode,
    this.cause,
    this.details,
    this.retryAfter,
    this.code, // ← new: backend error_code, if present
  });

  final ApiErrorKind kind;
  final String message;
  final int? statusCode;
  final Object? cause;
  final Map<String, dynamic>? details;
  final Duration? retryAfter;

  final String? code;

  @override
  String toString() =>
      'ApiError(kind: $kind, status: $statusCode, code: $code, message: $message)';
}
