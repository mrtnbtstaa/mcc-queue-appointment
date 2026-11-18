import '../../domain/failures/login_failure.dart';

sealed class LoginState {
  const LoginState();
}

final class LoginIdle extends LoginState {
  const LoginIdle();
}

final class LoginSubmitting extends LoginState {
  const LoginSubmitting();
}

final class LoginError extends LoginState {
  const LoginError(this.failure);
  final LoginFailure failure;
}

final class LoginSuccess extends LoginState {}
