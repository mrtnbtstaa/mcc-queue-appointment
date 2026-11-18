import 'package:flutter/foundation.dart';

enum UserRole { student, staff, none }

/// Single source of truth for authentication state.
///
/// Owned by the DI container as a lazy singleton. Consumed by:
/// - [AuthInterceptor]'s `onRefreshFailed` (calls [setSignedOut])
/// - go_router's `refreshListenable` (reacts to [notifyListeners])
/// - login/register flows (call [setSignedIn])
///
/// It must never import Dio, GoRouter, or any feature code.
class AuthState extends ChangeNotifier {
  String? _accessToken;
  UserRole _role = UserRole.none;

  bool get isSignedIn => _accessToken != null && _role != UserRole.none;
  UserRole get role => _role;

  void setSignedIn({required String accessToken, required UserRole role}) {
    _accessToken = accessToken;
    _role = role;
    notifyListeners();
  }

  void setSignedOut() {
    if (_accessToken == null && _role == UserRole.none) return; // idempotent
    _accessToken = null;
    _role = UserRole.none;
    notifyListeners();
  }
}
