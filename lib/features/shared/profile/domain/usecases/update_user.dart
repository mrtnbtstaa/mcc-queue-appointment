import '../../../../../core/type_defs.dart';
import '../../../../../core/usecase/usecase.dart';
import '../entities/profile_entity.dart';
import '../repositories/profile_repository.dart';

class UpdateUserParams {
  final String id;
  final String name;
  final String studentId;
  final String email;
  final String course;
  final String yearLevel;
  final bool isActive;

  const UpdateUserParams({
    required this.id,
    required this.name,
    required this.studentId,
    required this.email,
    required this.course,
    required this.yearLevel,
    required this.isActive,
  });
}

class UpdateUser implements UseCase<ProfileEntity, UpdateUserParams> {
  final ProfileRepository repository;

  const UpdateUser(this.repository);

  @override
  ResultFuture<ProfileEntity> call(UpdateUserParams params) =>
      repository.updateUser(
        id: params.id,
        name: params.name,
        studentId: params.studentId,
        email: params.email,
        course: params.course,
        yearLevel: params.yearLevel,
        isActive: params.isActive,
      );
}
