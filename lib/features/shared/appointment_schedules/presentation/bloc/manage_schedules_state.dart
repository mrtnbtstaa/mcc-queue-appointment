import 'package:equatable/equatable.dart';

import '../../../services/domain/entities/service_entity.dart';
import '../../domain/entities/appointment_schedule.dart';

enum ManageSchedulesStatus { initial, loading, success, failure }

class ManageSchedulesState extends Equatable {
  final ManageSchedulesStatus status;

  final String selectedServiceScope;

  final List<ServiceEntity> services;

  final DateTime selectedDate;

  final DateTime focusedDate;

  final String currentMonthYear;

  final List<AppointmentSchedule> schedules;

  final String? errorMessage;

  const ManageSchedulesState({
    this.status = ManageSchedulesStatus.initial,
    this.selectedServiceScope = 'Enrollment (Window 2)',
    this.services = const [],
    required this.selectedDate,
    required this.focusedDate,
    this.currentMonthYear = 'October 2026',
    this.schedules = const [],
    this.errorMessage,
  });

  ManageSchedulesState copyWith({
    ManageSchedulesStatus? status,
    String? selectedServiceScope,
    List<ServiceEntity>? services,
    DateTime? selectedDate,
    DateTime? focusedDate,
    String? currentMonthYear,
    List<AppointmentSchedule>? schedules,
    String? errorMessage,
  }) {
    return ManageSchedulesState(
      status: status ?? this.status,
      selectedServiceScope: selectedServiceScope ?? this.selectedServiceScope,
      services: services ?? this.services,
      selectedDate: selectedDate ?? this.selectedDate,
      focusedDate: focusedDate ?? this.focusedDate,
      currentMonthYear: currentMonthYear ?? this.currentMonthYear,
      schedules: schedules ?? this.schedules,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    selectedServiceScope,
    services,
    selectedDate,
    focusedDate,
    currentMonthYear,
    schedules,
    errorMessage,
  ];
}
