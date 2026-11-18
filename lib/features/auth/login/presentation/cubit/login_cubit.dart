import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../../core/auth/auth_state.dart';
import '../../../../../core/storage/token_store.dart';
import '../../domain/usecases/login_user.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._loginUser, this._tokenStore, this._authState)
    : super(const LoginIdle());

  final LoginUser _loginUser;
  final TokenStore _tokenStore;
  final AuthState _authState;

  Future<void> submit({required String email, required String password}) async {
    if (state is LoginSubmitting) return;

    emit(const LoginSubmitting());

    final result = await _loginUser(email: email, password: password);

    switch (result) {
      case Left(:final value):
        emit(LoginError(value));

      case Right(:final value):
        // Persist tokens
        await _tokenStore.writeTokens(
          access: value.accessToken,
          refresh: value.refreshToken,
          role: value.role,
        );

        // Update AuthState (Triggers GoRouter redirect in the background)
        _authState.setSignedIn(
          accessToken: value.accessToken,
          role: value.role,
        );

        // Emit success so the UI's BlocConsumer listener can navigate explicitly
        emit(LoginSuccess());
    }
  }

  void resetError() {
    if (state is LoginError) {
      emit(const LoginIdle());
    }
  }
}
