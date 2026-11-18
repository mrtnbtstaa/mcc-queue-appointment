import 'package:fpdart/fpdart.dart';

import '../entities/session_entity.dart';
import '../failures/login_failure.dart';
import '../repositories/login_repository.dart';

class LoginUser {
  const LoginUser(this._repository);
  final LoginRepository _repository;

  Future<Either<LoginFailure, SessionEntity>> call({
    required String email,
    required String password,
  }) async {
    return await _repository.login(email: email, password: password);
  }
}
