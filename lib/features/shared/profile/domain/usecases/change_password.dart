import '../../../../../core/type_defs.dart';
import '../../../../../core/usecase/usecase.dart';
import '../repositories/profile_repository.dart';

class ChangePasswordParams {
  final String currentPassword;
  final String newPassword;
  final String confirmPassword;

  const ChangePasswordParams({
    required this.currentPassword,
    required this.newPassword,
    required this.confirmPassword,
  });
}

class ChangePassword implements UseCase<void, ChangePasswordParams> {
  final ProfileRepository repository;

  const ChangePassword(this.repository);

  @override
  ResultFuture<void> call(ChangePasswordParams params) =>
      repository.changePassword(
        currentPassword: params.currentPassword,
        newPassword: params.newPassword,
        confirmPassword: params.confirmPassword,
      );
}
