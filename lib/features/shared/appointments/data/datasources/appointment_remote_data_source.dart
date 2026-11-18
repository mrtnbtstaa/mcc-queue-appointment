import 'package:dio/dio.dart';

import '../../../../../core/network/api_result.dart';
import '../../../../../core/network/paginated_data.dart';
import '../models/appointment_model.dart';

abstract interface class AppointmentRemoteDataSource {
  Future<ApiResult<List<AppointmentModel>>> getAppointments({
    String? search,
    String? status,
    CancelToken? cancelToken,
  });
  Future<ApiResult<PaginatedData<AppointmentModel>>> getAppointmentsPage({
    String? search,
    String? status,
    required int page,
    CancelToken? cancelToken,
  });

  Future<ApiResult<AppointmentModel>> getAppointment(
    String id, {
    CancelToken? cancelToken,
  });

  Future<ApiResult<AppointmentModel>> createAppointment({
    required String service,
    required String slot,
    required String status,
  });

  Future<ApiResult<AppointmentModel>> updateAppointment({
    required String id,
    required String service,
    required String slot,
  });

  Future<ApiResult<AppointmentModel>> setAppointmentStatus({
    required String id,
    required String status,
  });
}
