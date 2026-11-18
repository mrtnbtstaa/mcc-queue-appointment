import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_result.dart';
import '../domain/filter_options.dart';

class FilterOptionsRemoteDataSource {
  final ApiClient apiClient;

  const FilterOptionsRemoteDataSource(this.apiClient);

  Future<ApiResult<FilterOptions>> getFilterOptions() =>
      apiClient.get<FilterOptions>(
        'v1/filters/',
        requireAuth: false,
        decode: (json) => FilterOptions.fromJson(
          (json as Map<String, dynamic>)['data'] as Map<String, dynamic>,
        ),
      );
}
