import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_result.dart';
import '../domain/dashboard_summary.dart';

class DashboardRemoteDataSource {
  final ApiClient apiClient;

  const DashboardRemoteDataSource(this.apiClient);

  Future<ApiResult<DashboardSummary>> getSummary() =>
      apiClient.get<DashboardSummary>(
        'v1/dashboard/',
        decode: (json) => DashboardSummary.fromJson(
          (json as Map<String, dynamic>)['data'] as Map<String, dynamic>,
        ),
      );
}
