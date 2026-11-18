import '../../../../../core/type_defs.dart';
import '../../../../../core/usecase/usecase.dart';
import '../entities/appointment.dart';
import '../repositories/appointment_repository.dart';

class UpdateAppointmentParams {
  final String id;
  final String service;
  final String slot;

  const UpdateAppointmentParams({
    required this.id,
    required this.service,
    required this.slot,
  });
}

class UpdateAppointment
    implements UseCase<Appointment, UpdateAppointmentParams> {
  final AppointmentRepository repository;

  const UpdateAppointment(this.repository);

  @override
  ResultFuture<Appointment> call(UpdateAppointmentParams params) {
    return repository.updateAppointment(
      id: params.id,
      service: params.service,
      slot: params.slot,
    );
  }
}
