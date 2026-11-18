import '../../../../../core/type_defs.dart';
import '../../../../../core/usecase/usecase.dart';
import '../entities/appointment.dart';
import '../repositories/appointment_repository.dart';

class GetAppointmentParams {
  final String id;

  const GetAppointmentParams({required this.id});
}

class GetAppointment implements UseCase<Appointment, GetAppointmentParams> {
  final AppointmentRepository repository;

  const GetAppointment(this.repository);

  @override
  ResultFuture<Appointment> call(GetAppointmentParams params) {
    return repository.getAppointment(params.id);
  }
}
