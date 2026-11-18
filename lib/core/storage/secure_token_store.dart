import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../auth/auth_state.dart';
import 'token_store.dart';

final class SecureTokenStore implements TokenStore {
  SecureTokenStore(this._storage);
  final FlutterSecureStorage _storage;

  static const _kAccess = 'access_token';
  static const _kRefresh = 'refresh_token';
  static const _kRole = 'user_role';

  String? _cachedAccess;
  String? _cachedRefresh;
  UserRole? _cachedRole;
  bool _hydrated = false;

  Future<void> _hydrate() async {
    if (_hydrated) return;
    _cachedAccess = await _storage.read(key: _kAccess);
    _cachedRefresh = await _storage.read(key: _kRefresh);

    // 2. Read the role and map it back to the Enum
    final roleStr = await _storage.read(key: _kRole);
    _cachedRole = switch (roleStr) {
      'student' => UserRole.student,
      'staff' => UserRole.staff,
      _ => UserRole.none,
    };

    _hydrated = true;
  }

  @override
  Future<String?> readAccessToken() async {
    await _hydrate();
    return _cachedAccess;
  }

  @override
  Future<String?> readRefreshToken() async {
    await _hydrate();
    return _cachedRefresh;
  }

  @override
  Future<UserRole> readRole() async {
    await _hydrate();
    return _cachedRole ?? UserRole.none;
  }

  // Update the signature to require the role and save it
  @override
  Future<void> writeTokens({
    required String access,
    String? refresh,
    required UserRole role,
  }) async {
    _cachedAccess = access;
    if (refresh != null) _cachedRefresh = refresh;
    _cachedRole = role;
    _hydrated = true;

    await _storage.write(key: _kAccess, value: access);
    if (refresh != null) {
      await _storage.write(key: _kRefresh, value: refresh);
    }
    await _storage.write(key: _kRole, value: role.name); // "student" or "staff"
  }

  @override
  Future<void> clear() async {
    _cachedAccess = null;
    _cachedRefresh = null;
    _cachedRole = null;
    _hydrated = true;

    await _storage.delete(key: _kAccess);
    await _storage.delete(key: _kRefresh);
    await _storage.delete(key: _kRole);
  }
}
