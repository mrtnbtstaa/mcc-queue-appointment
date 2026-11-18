import '../../../../../core/network/paginated_data.dart';
import '../../../../../core/type_defs.dart';
import '../entities/appointment.dart';

abstract interface class AppointmentRepository {
  ResultFuture<List<Appointment>> getAppointments({
    String? search,
    String? status,
  });
  ResultFuture<PaginatedData<Appointment>> getAppointmentsPage({
    String? search,
    String? status,
    required int page,
  });

  ResultFuture<Appointment> getAppointment(String id);

  ResultFuture<Appointment> createAppointment({
    required String service,
    required String slot,
    required String status,
  });

  ResultFuture<Appointment> updateAppointment({
    required String id,
    required String service,
    required String slot,
  });

  ResultFuture<Appointment> setAppointmentStatus({
    required String id,
    required String status,
  });
}
