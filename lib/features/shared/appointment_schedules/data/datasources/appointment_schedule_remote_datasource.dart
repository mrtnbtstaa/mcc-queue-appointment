import '../../../../../../core/network/api_result.dart';
import '../models/appointment_schedule_model.dart';

abstract interface class AppointmentScheduleRemoteDataSource {
  Future<ApiResult<List<AppointmentScheduleModel>>> getSchedules({
    String? search,
  });

  Future<ApiResult<AppointmentScheduleModel>> getSchedule(String id);

  Future<ApiResult<AppointmentScheduleModel>> createSchedule(
    AppointmentScheduleModel model,
  );

  Future<ApiResult<AppointmentScheduleModel>> updateSchedule(
    String id,
    AppointmentScheduleModel model,
  );

  Future<ApiResult<void>> setStatus(String id, String status);
}
