import '../../../../../core/network/paginated_data.dart';
import '../../../../../core/type_defs.dart';
import '../../../../../core/usecase/usecase.dart';
import '../entities/profile_entity.dart';
import '../repositories/profile_repository.dart';

class GetUsers implements UseCase<List<ProfileEntity>, GetUsersParams> {
  final ProfileRepository repository;

  const GetUsers(this.repository);

  @override
  ResultFuture<List<ProfileEntity>> call(GetUsersParams params) =>
      repository.getUsers(search: params.search, course: params.course);

  ResultFuture<PaginatedData<ProfileEntity>> callPage(GetUsersParams params) =>
      repository.getUsersPage(
        search: params.search,
        course: params.course,
        page: params.page,
      );
}

class GetUsersParams {
  final String? search;
  final String? course;
  final int page;

  const GetUsersParams({this.search, this.course, this.page = 1});
}
