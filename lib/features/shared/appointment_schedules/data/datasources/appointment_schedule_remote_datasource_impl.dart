import '../../../../../../core/network/api_client.dart';
import '../../../../../../core/network/api_result.dart';
import '../models/appointment_schedule_model.dart';
import 'appointment_schedule_remote_datasource.dart';

class AppointmentScheduleRemoteDataSourceImpl
    implements AppointmentScheduleRemoteDataSource {
  AppointmentScheduleRemoteDataSourceImpl(this._client);

  final ApiClient _client;

  @override
  Future<ApiResult<List<AppointmentScheduleModel>>> getSchedules({
    String? search,
  }) async {
    return _client.get<List<AppointmentScheduleModel>>(
      'v1/appointment-slots/',
      query: {
        if (search != null && search.trim().isNotEmpty) 'search': search.trim(),
      },
      requireAuth: true,
      decode: (json) {
        final body = json as Map<String, dynamic>;
        final list = body['data'] as List<dynamic>;

        return list
            .map(
              (e) =>
                  AppointmentScheduleModel.fromJson(e as Map<String, dynamic>),
            )
            .toList();
      },
    );
  }

  @override
  Future<ApiResult<AppointmentScheduleModel>> getSchedule(String id) async {
    return _client.get<AppointmentScheduleModel>(
      'v1/appointment-slots/$id/',
      requireAuth: true,
      decode: (json) {
        final body = json as Map<String, dynamic>;
        return AppointmentScheduleModel.fromJson(
          body['data'] as Map<String, dynamic>,
        );
      },
    );
  }

  @override
  Future<ApiResult<AppointmentScheduleModel>> createSchedule(
    AppointmentScheduleModel model,
  ) async {
    return _client.post<AppointmentScheduleModel>(
      'v1/appointment-slots/',
      body: model.toJson(),
      requireAuth: true,
      isIdempotent: false,
      decode: (json) {
        final body = json as Map<String, dynamic>;
        return AppointmentScheduleModel.fromJson(
          body['data'] as Map<String, dynamic>,
        );
      },
    );
  }

  @override
  Future<ApiResult<AppointmentScheduleModel>> updateSchedule(
    String id,
    AppointmentScheduleModel model,
  ) async {
    return _client.patch<AppointmentScheduleModel>(
      'v1/appointment-slots/$id/',
      body: model.toJson(),
      requireAuth: true,
      isIdempotent: true,
      decode: (json) {
        final body = json as Map<String, dynamic>;
        return AppointmentScheduleModel.fromJson(
          body['data'] as Map<String, dynamic>,
        );
      },
    );
  }

  @override
  Future<ApiResult<void>> setStatus(String id, String status) async {
    return _client.patch<void>(
      'v1/appointment-slots/$id/status/',
      body: {'status': status},
      requireAuth: true,
      isIdempotent: true,
      decode: (_) {},
    );
  }
}
