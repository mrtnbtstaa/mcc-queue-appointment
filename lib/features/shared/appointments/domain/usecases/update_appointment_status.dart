import '../../../../../core/type_defs.dart';
import '../../../../../core/usecase/usecase.dart';
import '../entities/appointment.dart';
import '../repositories/appointment_repository.dart';

class SetAppointmentStatusParams {
  final String id;
  final String status;

  const SetAppointmentStatusParams({required this.id, required this.status});
}

class SetAppointmentStatus
    implements UseCase<Appointment, SetAppointmentStatusParams> {
  final AppointmentRepository repository;

  const SetAppointmentStatus(this.repository);

  @override
  ResultFuture<Appointment> call(SetAppointmentStatusParams params) {
    return repository.setAppointmentStatus(
      id: params.id,
      status: params.status,
    );
  }
}
