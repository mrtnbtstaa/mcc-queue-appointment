import '../../../../../core/type_defs.dart';
import '../../../../../core/usecase/usecase.dart';
import '../entities/profile_entity.dart';
import '../repositories/profile_repository.dart';

class GetUser implements UseCase<ProfileEntity, GetUserParams> {
  final ProfileRepository repository;

  const GetUser(this.repository);

  @override
  ResultFuture<ProfileEntity> call(GetUserParams params) =>
      repository.getUser(params.id);
}

class GetUserParams {
  final String id;

  const GetUserParams(this.id);
}
