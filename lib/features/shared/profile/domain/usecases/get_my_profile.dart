import '../../../../../core/type_defs.dart';
import '../../../../../core/usecase/usecase.dart';
import '../entities/profile_entity.dart';
import '../repositories/profile_repository.dart';

class GetMyProfile implements UseCase<ProfileEntity, NoParams> {
  final ProfileRepository repository;

  const GetMyProfile(this.repository);

  @override
  ResultFuture<ProfileEntity> call(NoParams params) => repository.getMe();
}
