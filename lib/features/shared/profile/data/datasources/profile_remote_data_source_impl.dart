import '../../../../../core/network/api_client.dart';
import '../../../../../core/network/api_result.dart';
import '../../../../../core/network/paginated_data.dart';
import '../../domain/entities/profile_entity.dart';
import 'profile_remote_data_source.dart';

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ApiClient apiClient;

  const ProfileRemoteDataSourceImpl(this.apiClient);

  static const String endpoint = 'v1/auth/me/';

  @override
  Future<ApiResult<List<ProfileEntity>>> getUsers({
    String? search,
    String? course,
  }) => apiClient.get<List<ProfileEntity>>(
    'v1/users/',
    query: {
      if (search != null && search.isNotEmpty) 'search': search,
      if (course != null && course.isNotEmpty) 'course': course,
    },
    decode: (json) {
      final data = (json as Map<String, dynamic>)['data'] as List<dynamic>;
      return data
          .map((item) => ProfileEntity.fromJson(item as Map<String, dynamic>))
          .toList();
    },
  );

  @override
  Future<ApiResult<PaginatedData<ProfileEntity>>> getUsersPage({
    String? search,
    String? course,
    required int page,
  }) => apiClient.get<PaginatedData<ProfileEntity>>(
    'v1/users/',
    query: {
      'page': page,
      'page_size': 10,
      if (search != null && search.isNotEmpty) 'search': search,
      if (course != null && course.isNotEmpty) 'course': course,
    },
    decode: (json) {
      final body = json as Map<String, dynamic>;
      final pagination =
          (body['meta'] as Map<String, dynamic>)['pagination']
              as Map<String, dynamic>;
      return PaginatedData(
        items: (body['data'] as List<dynamic>)
            .map((item) => ProfileEntity.fromJson(item as Map<String, dynamic>))
            .toList(),
        page: (pagination['page'] as num).toInt(),
        totalPages: (pagination['total_pages'] as num).toInt(),
      );
    },
  );

  @override
  Future<ApiResult<ProfileEntity>> getUser(String id) =>
      apiClient.get<ProfileEntity>(
        'v1/users/$id/',
        decode: (json) => ProfileEntity.fromJson(
          (json as Map<String, dynamic>)['data'] as Map<String, dynamic>,
        ),
      );

  @override
  Future<ApiResult<ProfileEntity>> getMe() => apiClient.get<ProfileEntity>(
    endpoint,
    decode: (json) => ProfileEntity.fromJson(
      (json as Map<String, dynamic>)['data'] as Map<String, dynamic>,
    ),
  );

  @override
  Future<ApiResult<ProfileEntity>> updateMe({
    required String email,
    required String course,
    required String yearLevel,
    required bool isActive,
  }) => apiClient.patch<ProfileEntity>(
    endpoint,
    body: {
      'email': email,
      'course': course,
      'year_level': yearLevel,
      'is_active': isActive,
    },
    decode: (json) => ProfileEntity.fromJson(
      (json as Map<String, dynamic>)['data'] as Map<String, dynamic>,
    ),
  );

  @override
  Future<ApiResult<ProfileEntity>> updateUser({
    required String id,
    required String name,
    required String studentId,
    required String email,
    required String course,
    required String yearLevel,
    required bool isActive,
  }) async {
    final result = await apiClient.patch<void>(
      'v1/users/$id/',
      body: {
        'name': name,
        'student_id': studentId,
        'email': email,
        'course': course,
        'year_level': yearLevel,
        'is_active': isActive,
      },
      decode: (_) {},
    );
    return switch (result) {
      ApiSuccess<void>() => getUser(id),
      ApiFailure<void>(:final error) => ApiFailure(error),
    };
  }

  @override
  Future<ApiResult<void>> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) => apiClient.patch<void>(
    'v1/auth/change-password/',
    body: {
      'current_password': currentPassword,
      'new_password': newPassword,
      'confirm_password': confirmPassword,
    },
    decode: (_) {},
  );
}
