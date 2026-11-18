import 'package:fpdart/fpdart.dart';

abstract interface class LogoutRepository {
  Future<Either<String, Unit>> logout(String refreshToken);
}
