sealed class LoginFailure {
  const LoginFailure();
}

final class InvalidCredentials extends LoginFailure {
  const InvalidCredentials([this.message]);
  final String? message;
}

final class AccountNotVerified extends LoginFailure {
  const AccountNotVerified([this.message]);
  final String? message;
}

final class NetworkFailure extends LoginFailure {
  const NetworkFailure();
}

final class ServerFailure extends LoginFailure {
  const ServerFailure([this.message]);
  final String? message;
}

final class UnknownFailure extends LoginFailure {
  const UnknownFailure([this.message]);
  final String? message;
}
