import '../../../../../../core/type_defs.dart';
import '../../../../../../core/usecase/usecase.dart';
import '../entities/appointment_schedule.dart';
import '../repositories/appointment_schedule_repository.dart';

class CreateAppointmentSchedule
    implements UseCase<AppointmentSchedule, AppointmentSchedule> {
  const CreateAppointmentSchedule(this._repository);

  final AppointmentScheduleRepository _repository;

  @override
  ResultFuture<AppointmentSchedule> call(AppointmentSchedule params) {
    return _repository.createSchedule(params);
  }
}
