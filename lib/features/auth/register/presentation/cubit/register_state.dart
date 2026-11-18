import '../../domain/failures/register_failure.dart';

/// Async submission state only. Form fields (visibility, strength, selected
/// course, terms checkbox) are widget state — they belong in the page.
sealed class RegisterState {
  const RegisterState();
}

final class RegisterIdle extends RegisterState {
  const RegisterIdle();
}

final class RegisterSubmitting extends RegisterState {
  const RegisterSubmitting();
}

final class RegisterSuccess extends RegisterState {
  const RegisterSuccess();
}

final class RegisterError extends RegisterState {
  const RegisterError(this.failure);
  final RegisterFailure failure;
}
