sealed class Failure {
  const Failure();
}

final class ValidationFailure extends Failure {
  const ValidationFailure(this.fieldErrors);
  final Map<String, String> fieldErrors;
}

final class NetworkFailure extends Failure {
  const NetworkFailure();
}

final class ServerFailure extends Failure {
  const ServerFailure([this.message]);
  final String? message;
}

final class UnknownFailure extends Failure {
  const UnknownFailure([this.message]);
  final String? message;
}

String failureMessage(Failure failure) {
  return switch (failure) {
    ValidationFailure(:final fieldErrors) =>
      fieldErrors.values.isEmpty
          ? 'Validation failed.'
          : fieldErrors.values.join(', '),
    NetworkFailure() => 'Network error. Check your connection.',
    ServerFailure(:final message) => message ?? 'Server error.',
    UnknownFailure(:final message) => message ?? 'Something went wrong.',
  };
}
