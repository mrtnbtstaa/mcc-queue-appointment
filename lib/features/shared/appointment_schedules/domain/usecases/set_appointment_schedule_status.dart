import '../../../../../../core/type_defs.dart';
import '../../../../../../core/usecase/usecase.dart';
import '../repositories/appointment_schedule_repository.dart';

class SetAppointmentScheduleStatusParams {
  const SetAppointmentScheduleStatusParams({
    required this.id,
    required this.status,
  });

  final String id;
  final String status;
}

class SetAppointmentScheduleStatus
    implements UseCase<void, SetAppointmentScheduleStatusParams> {
  const SetAppointmentScheduleStatus(this._repository);

  final AppointmentScheduleRepository _repository;

  @override
  ResultVoid call(SetAppointmentScheduleStatusParams params) {
    return _repository.setStatus(params.id, params.status);
  }
}
