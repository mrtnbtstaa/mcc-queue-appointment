import 'package:fpdart/fpdart.dart';

import '../../../../../core/network/api_result.dart';
import '../../domain/repositories/logout_repository.dart';
import '../datasources/logout_remote_data_source.dart';

class LogoutRepositoryImpl implements LogoutRepository {
  LogoutRepositoryImpl(this._remote);
  final LogoutRemoteDataSource _remote;

  @override
  Future<Either<String, Unit>> logout(String refreshToken) async {
    final result = await _remote.logout(refreshToken);

    return switch (result) {
      ApiSuccess() => const Right(unit),
      ApiFailure(:final error) => Left(error.message),
    };
  }
}
