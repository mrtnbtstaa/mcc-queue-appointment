import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/registration_entity.dart';
import '../../domain/failures/register_failure.dart';
import '../../domain/usecases/register_user.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this._registerUser) : super(const RegisterIdle());

  final RegisterUser _registerUser;

  Future<void> submit({
    required String studentId,
    required String fullName,
    required String course,
    required String email,
    required String password,
    required String confirmPassword,
    required String yearLevel,
  }) async {
    if (state is RegisterSubmitting) return;

    if (password != confirmPassword) {
      emit(const RegisterError(PasswordsDoNotMatch()));
      return;
    }

    emit(const RegisterSubmitting());

    final result = await _registerUser(
      RegistrationEntity(
        studentNumber: studentId.trim(),
        fullName: fullName.trim(),
        course: course.trim(),
        email: email.trim(),
        password: password,
        yearLevel: yearLevel,
      ),
    );

    result.fold(
      (failure) => emit(RegisterError(failure)),
      (_) => emit(const RegisterSuccess()),
    );
  }
}
