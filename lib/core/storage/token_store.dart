import '../auth/auth_state.dart';


abstract interface class TokenStore {
  Future<String?> readAccessToken();
  Future<String?> readRefreshToken();
  Future<UserRole> readRole();
  Future<void> writeTokens({
    required String access,
    String? refresh,
    required UserRole role,
  });
  Future<void> clear();
}
