import 'package:fpdart/fpdart.dart';

import '../entities/session_entity.dart';
import '../failures/login_failure.dart';

abstract interface class LoginRepository {
  Future<Either<LoginFailure, SessionEntity>> login({
    required String email,
    required String password,
  });
}
