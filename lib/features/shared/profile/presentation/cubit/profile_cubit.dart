import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/usecase/usecase.dart';
import '../../domain/usecases/change_password.dart';
import '../../domain/usecases/get_my_profile.dart';
import '../../domain/usecases/update_my_profile.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetMyProfile getMyProfile;
  final UpdateMyProfile updateMyProfile;
  final ChangePassword changePasswordUseCase;

  final emailController = TextEditingController();
  final courseController = TextEditingController();
  final yearLevelController = TextEditingController();

  ProfileCubit({
    required this.getMyProfile,
    required this.updateMyProfile,
    required this.changePasswordUseCase,
  }) : super(const ProfileState());

  void changeTab(ProfileTab tab) => emit(state.copyWith(activeTab: tab));

  void dismissSuccessBanner() => emit(state.copyWith(clearSuccess: true));

  Future<void> loadProfile() async {
    emit(state.copyWith(isLoading: true, clearError: true, clearSuccess: true));
    final result = await getMyProfile(const NoParams());
    if (isClosed) return;
    result.fold(
      (failure) => emit(
        state.copyWith(isLoading: false, error: failureMessage(failure)),
      ),
      (profile) {
        emailController.text = profile.email;
        courseController.text = profile.course;
        yearLevelController.text = profile.yearLevel;
        emit(
          state.copyWith(isLoading: false, profile: profile, clearError: true),
        );
      },
    );
  }

  Future<void> saveChanges() async {
    final profile = state.profile;
    if (profile == null) return;
    emit(state.copyWith(isSaving: true, clearError: true, clearSuccess: true));
    final result = await updateMyProfile(
      UpdateMyProfileParams(
        email: emailController.text.trim(),
        course: courseController.text.trim(),
        yearLevel: yearLevelController.text.trim(),
        isActive: profile.isActive,
      ),
    );
    if (isClosed) return;
    result.fold(
      (failure) =>
          emit(state.copyWith(isSaving: false, error: failureMessage(failure))),
      (updated) {
        emailController.text = updated.email;
        courseController.text = updated.course;
        yearLevelController.text = updated.yearLevel;
        emit(
          state.copyWith(
            isSaving: false,
            profile: updated,
            successMessage: 'Profile updated successfully.',
            clearError: true,
          ),
        );
      },
    );
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    if (currentPassword.isEmpty ||
        newPassword.isEmpty ||
        confirmPassword.isEmpty) {
      emit(
        state.copyWith(
          error: 'Complete all password fields.',
          clearSuccess: true,
        ),
      );
      return;
    }
    if (newPassword != confirmPassword) {
      emit(
        state.copyWith(
          error: 'New password and confirmation do not match.',
          clearSuccess: true,
        ),
      );
      return;
    }
    emit(
      state.copyWith(
        isChangingPassword: true,
        clearError: true,
        clearSuccess: true,
      ),
    );
    final result = await changePasswordUseCase(
      ChangePasswordParams(
        currentPassword: currentPassword,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      ),
    );
    if (isClosed) return;
    result.fold(
      (failure) => emit(
        state.copyWith(
          isChangingPassword: false,
          error: failureMessage(failure),
        ),
      ),
      (_) => emit(
        state.copyWith(
          isChangingPassword: false,
          successMessage: 'Password changed successfully.',
          clearError: true,
        ),
      ),
    );
  }

  @override
  Future<void> close() {
    emailController.dispose();
    courseController.dispose();
    yearLevelController.dispose();
    return super.close();
  }
}
