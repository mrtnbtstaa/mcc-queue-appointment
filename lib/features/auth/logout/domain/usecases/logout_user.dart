import 'package:fpdart/fpdart.dart';

import '../../../../../core/storage/token_store.dart';
import '../repositories/logout_repository.dart';

class LogoutUser {
  const LogoutUser(this._repository, this._tokenStore);
  final LogoutRepository _repository;
  final TokenStore _tokenStore;

  Future<Either<String, Unit>> call() async {
    // Retrieve the refresh token from storage
    final refreshToken = await _tokenStore.readRefreshToken();

    // If it doesn't exist, fail early (or ignore and just clear locally)
    if (refreshToken == null || refreshToken.isEmpty) {
      return const Left('No refresh token found');
    }

    //  Send to backend
    return _repository.logout(refreshToken);
  }
}
