import '../../../../../core/network/paginated_data.dart';
import '../../../../../core/type_defs.dart';
import '../../../../../core/usecase/usecase.dart';
import '../entities/appointment.dart';
import '../repositories/appointment_repository.dart';

class GetAppointmentsParams {
  const GetAppointmentsParams({this.search, this.status});

  final String? search;
  final String? status;
}

class GetAppointments
    implements UseCase<List<Appointment>, GetAppointmentsParams> {
  final AppointmentRepository repository;

  const GetAppointments(this.repository);

  @override
  ResultFuture<List<Appointment>> call(GetAppointmentsParams params) {
    return repository.getAppointments(
      search: params.search,
      status: params.status,
    );
  }

  ResultFuture<PaginatedData<Appointment>> callPage({
    String? search,
    String? status,
    required int page,
  }) => repository.getAppointmentsPage(
    search: search,
    status: status,
    page: page,
  );
}
