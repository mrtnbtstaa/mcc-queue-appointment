import 'api_error.dart';

/// The result of an API call. A sealed union so callers can switch
/// exhaustively over success and failure.
sealed class ApiResult<T> {
  const ApiResult();
}

final class ApiSuccess<T> extends ApiResult<T> {
  const ApiSuccess(this.data);
  final T data;
}

final class ApiFailure<T> extends ApiResult<T> {
  const ApiFailure(this.error);
  final ApiError error;
}
