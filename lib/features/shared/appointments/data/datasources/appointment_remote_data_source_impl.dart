import 'package:dio/dio.dart';

import '../../../../../core/network/api_client.dart';
import '../../../../../core/network/api_result.dart';
import '../../../../../core/network/paginated_data.dart';
import '../models/appointment_model.dart';
import 'appointment_remote_data_source.dart';

class AppointmentRemoteDataSourceImpl implements AppointmentRemoteDataSource {
  final ApiClient apiClient;

  const AppointmentRemoteDataSourceImpl(this.apiClient);

  static const String endpoint = 'v1/appointments/';

  @override
  Future<ApiResult<AppointmentModel>> createAppointment({
    required String service,
    required String slot,
    required String status,
  }) {
    return apiClient.post<AppointmentModel>(
      endpoint,
      body: {'service': service, 'slot': slot, 'status': status},
      decode: (json) {
        final body = json as Map<String, dynamic>;
        return AppointmentModel.fromJson(body['data'] as Map<String, dynamic>);
      },
      isIdempotent: true,
    );
  }

  @override
  Future<ApiResult<List<AppointmentModel>>> getAppointments({
    String? search,
    String? status,
    CancelToken? cancelToken,
  }) {
    final trimmedSearch = search?.trim();
    final trimmedStatus = status?.trim();

    return apiClient.get<List<AppointmentModel>>(
      endpoint,
      query: {
        'page_size': 100,
        if (trimmedSearch != null && trimmedSearch.isNotEmpty)
          'search': trimmedSearch,
        if (trimmedStatus != null && trimmedStatus.isNotEmpty)
          'status': trimmedStatus,
      },
      cancelToken: cancelToken,
      decode: (json) {
        final body = json as Map<String, dynamic>;
        final results = body['data'] as List<dynamic>;

        return results
            .map(
              (item) => AppointmentModel.fromJson(item as Map<String, dynamic>),
            )
            .toList();
      },
    );
  }

  @override
  Future<ApiResult<PaginatedData<AppointmentModel>>> getAppointmentsPage({
    String? search,
    String? status,
    required int page,
    CancelToken? cancelToken,
  }) {
    final trimmedSearch = search?.trim();
    final trimmedStatus = status?.trim();
    return apiClient.get<PaginatedData<AppointmentModel>>(
      endpoint,
      query: {
        'page': page,
        'page_size': 10,
        if (trimmedSearch != null && trimmedSearch.isNotEmpty)
          'search': trimmedSearch,
        if (trimmedStatus != null && trimmedStatus.isNotEmpty)
          'status': trimmedStatus,
      },
      cancelToken: cancelToken,
      decode: (json) {
        final body = json as Map<String, dynamic>;
        final pagination =
            (body['meta'] as Map<String, dynamic>)['pagination']
                as Map<String, dynamic>;
        return PaginatedData(
          items: (body['data'] as List<dynamic>)
              .map(
                (item) =>
                    AppointmentModel.fromJson(item as Map<String, dynamic>),
              )
              .toList(),
          page: (pagination['page'] as num).toInt(),
          totalPages: (pagination['total_pages'] as num).toInt(),
        );
      },
    );
  }

  @override
  Future<ApiResult<AppointmentModel>> getAppointment(
    String id, {
    CancelToken? cancelToken,
  }) {
    return apiClient.get<AppointmentModel>(
      '$endpoint$id/',
      cancelToken: cancelToken,
      decode: (json) {
        final body = json as Map<String, dynamic>;
        return AppointmentModel.fromJson(body['data'] as Map<String, dynamic>);
      },
    );
  }

  @override
  Future<ApiResult<AppointmentModel>> updateAppointment({
    required String id,
    required String service,
    required String slot,
  }) {
    return apiClient.put<AppointmentModel>(
      '$endpoint$id/',
      body: {'service': service, 'slot': slot},
      decode: (json) {
        final body = json as Map<String, dynamic>;
        return AppointmentModel.fromJson(body['data'] as Map<String, dynamic>);
      },
    );
  }

  @override
  Future<ApiResult<AppointmentModel>> setAppointmentStatus({
    required String id,
    required String status,
  }) {
    return apiClient.patch<AppointmentModel>(
      '$endpoint$id/status/',
      body: {'status': status},
      decode: (json) {
        final body = json as Map<String, dynamic>;
        return AppointmentModel.fromJson(body['data'] as Map<String, dynamic>);
      },
    );
  }
}
