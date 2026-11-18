import '../../../../../../core/type_defs.dart';
import '../../../../../../core/usecase/usecase.dart';
import '../entities/appointment_schedule.dart';
import '../repositories/appointment_schedule_repository.dart';

class UpdateAppointmentScheduleParams {
  const UpdateAppointmentScheduleParams({
    required this.id,
    required this.schedule,
  });

  final String id;
  final AppointmentSchedule schedule;
}

class UpdateAppointmentSchedule
    implements UseCase<AppointmentSchedule, UpdateAppointmentScheduleParams> {
  const UpdateAppointmentSchedule(this._repository);

  final AppointmentScheduleRepository _repository;

  @override
  ResultFuture<AppointmentSchedule> call(
    UpdateAppointmentScheduleParams params,
  ) {
    return _repository.updateSchedule(params.id, params.schedule);
  }
}
