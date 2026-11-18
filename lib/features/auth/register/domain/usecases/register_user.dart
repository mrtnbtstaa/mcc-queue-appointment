import 'package:fpdart/fpdart.dart';

import '../entities/registration_entity.dart';
import '../failures/register_failure.dart';
import '../repositories/register_repository.dart';

class RegisterUser {
  const RegisterUser(this._repository);
  final RegisterRepository _repository;

  Future<Either<RegisterFailure, Unit>> call(RegistrationEntity draft) async {
    return await _repository.register(draft);
  }
}
