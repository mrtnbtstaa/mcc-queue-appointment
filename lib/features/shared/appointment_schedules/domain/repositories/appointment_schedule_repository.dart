import '../../../../../../core/type_defs.dart';
import '../entities/appointment_schedule.dart';

abstract interface class AppointmentScheduleRepository {
  ResultFuture<List<AppointmentSchedule>> getSchedules({String? search});

  ResultFuture<AppointmentSchedule> getSchedule(String id);

  ResultFuture<AppointmentSchedule> createSchedule(
    AppointmentSchedule schedule,
  );

  ResultFuture<AppointmentSchedule> updateSchedule(
    String id,
    AppointmentSchedule schedule,
  );

  ResultVoid setStatus(String id, String status);
}
