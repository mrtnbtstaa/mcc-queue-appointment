import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/auth/auth_state.dart';
import '../../../../../core/storage/token_store.dart';
import '../../domain/usecases/logout_user.dart';
import 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit(this._logoutUser, this._tokenStore, this._authState)
    : super(LogoutIdle());

  final LogoutUser _logoutUser;
  final TokenStore _tokenStore;
  final AuthState _authState;

  Future<void> submit() async {
    emit(LogoutLoading());

    // Tell backend (optional, we ignore the result)
    await _logoutUser();

    // Clear local storage NO MATTER WHAT
    await _tokenStore.clear();

    // Update AuthState.
    // GoRouter will instantly kick the user to /login.
    _authState.setSignedOut();
  }
}
