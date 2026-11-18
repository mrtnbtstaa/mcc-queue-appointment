import 'package:fpdart/fpdart.dart';

import '../../../../../core/network/api_error.dart';
import '../../../../../core/network/api_result.dart';
import '../../domain/entities/session_entity.dart';
import '../../domain/failures/login_failure.dart';
import '../../domain/repositories/login_repository.dart';
import '../datasources/login_remote_data_source.dart';
import '../models/login_request_dto.dart';

class LoginRepositoryImpl implements LoginRepository {
  LoginRepositoryImpl(this._remote);
  final LoginRemoteDataSource _remote;

  @override
  Future<Either<LoginFailure, SessionEntity>> login({
    required String email,
    required String password,
  }) async {
    final result = await _remote.login(
      LoginRequestDto(email: email, password: password),
    );

    return switch (result) {
      ApiSuccess(:final data) => Right(data.toDomain()),
      ApiFailure(:final error) => Left(_mapFailure(error)),
    };
  }

  LoginFailure _mapFailure(ApiError error) {
    // 1. Prefer backend error_code if it exists
    switch (error.code) {
      case 'INVALID_CREDENTIALS':
      case 'AUTHENTICATION_FAILED':
        return InvalidCredentials(error.message);
      case 'ACCOUNT_NOT_VERIFIED':
      case 'EMAIL_NOT_VERIFIED':
        return AccountNotVerified(error.message);
    }

    // Fallback to HTTP Status mapping
    return switch (error.kind) {
      // A 401 on a login endpoint means wrong password/email.
      // It does NOT mean expired session, because login is requireAuth: false.
      ApiErrorKind.unauthorized => InvalidCredentials(error.message),
      ApiErrorKind.forbidden => AccountNotVerified(error.message),
      ApiErrorKind.network || ApiErrorKind.timeout => const NetworkFailure(),
      ApiErrorKind.server => ServerFailure(error.message),
      _ => UnknownFailure(error.message),
    };
  }
}
