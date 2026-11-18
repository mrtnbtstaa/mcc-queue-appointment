import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../shared/appointments/domain/usecases/get_appointments.dart';
import '../../../../shared/appointments/domain/usecases/update_appointment_status.dart';
import 'view_appointments_state.dart';

class ViewAppointmentsCubit extends Cubit<ViewAppointmentsState> {
  ViewAppointmentsCubit({
    required this.getAppointments,
    required this.setAppointmentStatus,
  }) : super(const ViewAppointmentsState());

  final GetAppointments getAppointments;
  final SetAppointmentStatus setAppointmentStatus;

  Timer? _searchDebounce;
  int _requestId = 0;

  Future<void> load() => _load();

  void setSearchQuery(String query) {
    if (query == state.searchQuery) return;

    emit(state.copyWith(searchQuery: query));
    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 400), _load);
  }

  void setFilterTab(String? status) {
    if (status == state.selectedStatus) return;

    _searchDebounce?.cancel();
    emit(
      state.copyWith(
        selectedStatus: status,
        clearStatus: status == null,
        clearError: true,
      ),
    );
    _load();
  }

  Future<void> confirm(String id) => _setStatus(id, 'CONFIRMED');

  Future<void> decline(String id) => _setStatus(id, 'CANCELLED');

  Future<void> _load() async {
    final requestId = ++_requestId;
    final query = state.searchQuery.trim();

    emit(
      state.copyWith(status: ViewAppointmentsStatus.loading, clearError: true),
    );

    final result = await getAppointments.callPage(
      search: query.isEmpty ? null : query,
      status: state.selectedStatus,
      page: 1,
    );

    if (isClosed || requestId != _requestId) return;

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: ViewAppointmentsStatus.failure,
          errorMessage: failureMessage(failure),
        ),
      ),
      (appointments) => emit(
        state.copyWith(
          status: ViewAppointmentsStatus.success,
          appointments: List.unmodifiable(appointments.items),
          page: appointments.page,
          totalPages: appointments.totalPages,
          clearError: true,
        ),
      ),
    );
  }

  Future<void> loadMore() async {
    if (state.status == ViewAppointmentsStatus.loading ||
        state.page >= state.totalPages) {
      return;
    }
    final requestId = _requestId;
    emit(
      state.copyWith(status: ViewAppointmentsStatus.loading, clearError: true),
    );
    final query = state.searchQuery.trim();
    final result = await getAppointments.callPage(
      search: query.isEmpty ? null : query,
      status: state.selectedStatus,
      page: state.page + 1,
    );
    if (isClosed || requestId != _requestId) return;
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: ViewAppointmentsStatus.success,
          errorMessage: failureMessage(failure),
        ),
      ),
      (next) => emit(
        state.copyWith(
          status: ViewAppointmentsStatus.success,
          appointments: List.unmodifiable([
            ...state.appointments,
            ...next.items,
          ]),
          page: next.page,
          totalPages: next.totalPages,
        ),
      ),
    );
  }

  Future<void> _setStatus(String id, String status) async {
    if (state.updatingId != null) return;

    emit(state.copyWith(updatingId: id, clearError: true));

    final result = await setAppointmentStatus(
      SetAppointmentStatusParams(id: id, status: status),
    );

    if (isClosed) return;

    result.fold(
      (failure) => emit(
        state.copyWith(
          clearUpdatingId: true,
          errorMessage: failureMessage(failure),
        ),
      ),
      (_) {
        // Keep the card locked until the refreshed list arrives.
        _load().whenComplete(() {
          if (!isClosed) emit(state.copyWith(clearUpdatingId: true));
        });
      },
    );
  }

  @override
  Future<void> close() {
    _searchDebounce?.cancel();
    return super.close();
  }
}
