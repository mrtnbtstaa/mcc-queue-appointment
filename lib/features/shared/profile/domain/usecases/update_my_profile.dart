import '../../../../../core/type_defs.dart';
import '../../../../../core/usecase/usecase.dart';
import '../entities/profile_entity.dart';
import '../repositories/profile_repository.dart';

class UpdateMyProfileParams {
  final String email;
  final String course;
  final String yearLevel;
  final bool isActive;

  const UpdateMyProfileParams({
    required this.email,
    required this.course,
    required this.yearLevel,
    required this.isActive,
  });
}

class UpdateMyProfile implements UseCase<ProfileEntity, UpdateMyProfileParams> {
  final ProfileRepository repository;

  const UpdateMyProfile(this.repository);

  @override
  ResultFuture<ProfileEntity> call(UpdateMyProfileParams params) =>
      repository.updateMe(
        email: params.email,
        course: params.course,
        yearLevel: params.yearLevel,
        isActive: params.isActive,
      );
}
