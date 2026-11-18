import 'package:fpdart/fpdart.dart';

import '../entities/registration_entity.dart';
import '../failures/register_failure.dart';

/// Contract for the register operation.
///
/// Returns [Unit] on success (register returns nothing to the caller —
/// the UI navigates to login). If your backend auto-logs-in, change the
/// return type to `Either<RegisterFailure, Session>` — see the Cubit notes.
abstract interface class RegisterRepository {
  Future<Either<RegisterFailure, Unit>> register(RegistrationEntity draft);
}
