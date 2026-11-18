import '../../../../../../core/type_defs.dart';
import '../../../../../../core/usecase/usecase.dart';
import '../entities/appointment_schedule.dart';
import '../repositories/appointment_schedule_repository.dart';

class GetAppointmentSchedulesParams {
  const GetAppointmentSchedulesParams({this.search});

  final String? search;
}

class GetAppointmentSchedules
    implements
        UseCase<List<AppointmentSchedule>, GetAppointmentSchedulesParams> {
  const GetAppointmentSchedules(this._repository);

  final AppointmentScheduleRepository _repository;

  @override
  ResultFuture<List<AppointmentSchedule>> call(
    GetAppointmentSchedulesParams params,
  ) {
    return _repository.getSchedules(search: params.search);
  }
}
