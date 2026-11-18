import '../../../../../../core/type_defs.dart';
import '../../../../../../core/usecase/usecase.dart';
import '../entities/appointment_schedule.dart';
import '../repositories/appointment_schedule_repository.dart';

class GetAppointmentSchedule implements UseCase<AppointmentSchedule, String> {
  const GetAppointmentSchedule(this._repository);

  final AppointmentScheduleRepository _repository;

  @override
  ResultFuture<AppointmentSchedule> call(String id) {
    return _repository.getSchedule(id);
  }
}
