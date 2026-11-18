import 'package:equatable/equatable.dart';

import '../../../../shared/appointments/domain/entities/appointment.dart';
import '../../domain/model.dart';

enum ViewAppointmentsStatus { initial, loading, success, failure }

class ViewAppointmentsState extends Equatable {
  final AppointmentTab selectedTab;
  final String searchQuery;
  final List<Appointment> appointments;
  final ViewAppointmentsStatus status;
  final String? errorMessage;
  final String? updatingId;
  final int page;
  final int totalPages;

  const ViewAppointmentsState({
    this.selectedTab = AppointmentTab.all,
    this.searchQuery = '',
    this.appointments = const [],
    this.status = ViewAppointmentsStatus.initial,
    this.errorMessage,
    this.updatingId,
    this.page = 1,
    this.totalPages = 1,
  });

  ViewAppointmentsState copyWith({
    AppointmentTab? selectedTab,
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
      selectedTab: selectedTab ?? this.selectedTab,
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
    selectedTab,
    searchQuery,
    appointments,
    status,
    errorMessage,
    updatingId,
    page,
    totalPages,
  ];
}
