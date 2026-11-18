import '../../../../../core/type_defs.dart';
import '../../../../../core/usecase/usecase.dart';
import '../entities/appointment.dart';
import '../repositories/appointment_repository.dart';

class CreateAppointmentParams {
  final String service;
  final String slot;
  final String status;

  const CreateAppointmentParams({
    required this.service,
    required this.slot,
    this.status = 'PENDING',
  });
}

class CreateAppointment
    implements UseCase<Appointment, CreateAppointmentParams> {
  final AppointmentRepository repository;

  const CreateAppointment(this.repository);

  @override
  ResultFuture<Appointment> call(CreateAppointmentParams params) {
    return repository.createAppointment(
      service: params.service,
      slot: params.slot,
      status: params.status,
    );
  }
}
