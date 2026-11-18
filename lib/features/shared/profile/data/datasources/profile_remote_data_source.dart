import '../../../../../core/network/api_result.dart';
import '../../../../../core/network/paginated_data.dart';
import '../../domain/entities/profile_entity.dart';

abstract interface class ProfileRemoteDataSource {
  Future<ApiResult<ProfileEntity>> getMe();

  Future<ApiResult<List<ProfileEntity>>> getUsers({
    String? search,
    String? course,
  });
  Future<ApiResult<PaginatedData<ProfileEntity>>> getUsersPage({
    String? search,
    String? course,
    required int page,
  });

  Future<ApiResult<ProfileEntity>> getUser(String id);

  Future<ApiResult<ProfileEntity>> updateMe({
    required String email,
    required String course,
    required String yearLevel,
    required bool isActive,
  });

  Future<ApiResult<void>> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  });
}
