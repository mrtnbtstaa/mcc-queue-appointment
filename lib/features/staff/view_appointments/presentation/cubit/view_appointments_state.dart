import 'package:equatable/equatable.dart';

import '../../../../shared/appointments/domain/entities/appointment.dart';

enum ViewAppointmentsStatus { initial, loading, success, failure }

class ViewAppointmentsState extends Equatable {
  final String? selectedStatus;
  final String searchQuery;
  final List<Appointment> appointments;
  final ViewAppointmentsStatus status;
  final String? errorMessage;
  final String? updatingId;
  final int page;
  final int totalPages;

  const ViewAppointmentsState({
    this.selectedStatus,
    this.searchQuery = '',
    this.appointments = const [],
    this.status = ViewAppointmentsStatus.initial,
    this.errorMessage,
    this.updatingId,
    this.page = 1,
    this.totalPages = 1,
  });

  ViewAppointmentsState copyWith({
    String? selectedStatus,
    bool clearStatus = false,
    String? searchQuery,
    List<Appointment>? appointments,
    ViewAppointmentsStatus? status,
    String? errorMessage,
    String? updatingId,
    bool clearError = false,
    bool clearUpdatingId = false,
    int? page,
    int? totalPages,
  }) {
    return ViewAppointmentsState(
      selectedStatus: clearStatus
          ? null
          : selectedStatus ?? this.selectedStatus,
      searchQuery: searchQuery ?? this.searchQuery,
      appointments: appointments ?? this.appointments,
      status: status ?? this.status,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      updatingId: clearUpdatingId ? null : (updatingId ?? this.updatingId),
      page: page ?? this.page,
      totalPages: totalPages ?? this.totalPages,
    );
  }

  @override
  List<Object?> get props => [
    selectedStatus,
    searchQuery,
    appointments,
    status,
    errorMessage,
    updatingId,
    page,
    totalPages,
  ];
}
