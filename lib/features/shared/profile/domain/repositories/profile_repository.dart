import '../../../../../core/network/paginated_data.dart';
import '../../../../../core/type_defs.dart';
import '../entities/profile_entity.dart';

abstract interface class ProfileRepository {
  ResultFuture<ProfileEntity> getMe();

  ResultFuture<List<ProfileEntity>> getUsers({String? search, String? course});
  ResultFuture<PaginatedData<ProfileEntity>> getUsersPage({
    String? search,
    String? course,
    required int page,
  });

  ResultFuture<ProfileEntity> getUser(String id);

  ResultFuture<ProfileEntity> updateMe({
    required String email,
    required String course,
    required String yearLevel,
    required bool isActive,
  });

  ResultFuture<ProfileEntity> updateUser({
    required String id,
    required String name,
    required String studentId,
    required String email,
    required String course,
    required String yearLevel,
    required bool isActive,
  });

  ResultFuture<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  });
}
