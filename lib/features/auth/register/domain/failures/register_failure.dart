/// Domain-level failures for registration. No HTTP types, no Dio, no
/// ApiErrorKind here — those are mapped at the repository boundary.
sealed class RegisterFailure {
  const RegisterFailure();
}

final class EmailAlreadyRegistered extends RegisterFailure {
  const EmailAlreadyRegistered([this.message]);
  final String? message;
}

final class WeakPassword extends RegisterFailure {
  const WeakPassword([this.message]);
  final String? message;
}

final class ValidationFailure extends RegisterFailure {
  const ValidationFailure(this.fieldErrors, [this.message]);
  final Map<String, String> fieldErrors; // field -> first message
  final String? message;
}

final class NetworkFailure extends RegisterFailure {
  const NetworkFailure();
}

final class ServerFailure extends RegisterFailure {
  const ServerFailure([this.message]);
  final String? message;
}

final class UnknownFailure extends RegisterFailure {
  const UnknownFailure([this.message]);
  final String? message;
}

final class PasswordsDoNotMatch extends RegisterFailure {
  const PasswordsDoNotMatch();
}
