import 'package:equatable/equatable.dart';

import '../../domain/entities/appointment_schedule.dart';

sealed class ManageSchedulesEvent extends Equatable {
  const ManageSchedulesEvent();

  @override
  List<Object?> get props => [];
}

class LoadSchedules extends ManageSchedulesEvent {
  const LoadSchedules({this.search});

  final String? search;

  @override
  List<Object?> get props => [search];
}

class LoadSchedule extends ManageSchedulesEvent {
  const LoadSchedule(this.id);

  final String id;

  @override
  List<Object?> get props => [id];
}

class SelectDate extends ManageSchedulesEvent {
  const SelectDate(this.date);

  final DateTime date;

  @override
  List<Object?> get props => [date];
}

class ChangeFocusedDate extends ManageSchedulesEvent {
  const ChangeFocusedDate(this.date);

  final DateTime date;

  @override
  List<Object?> get props => [date];
}

class GoToToday extends ManageSchedulesEvent {
  const GoToToday();
}

class UpdateServiceScope extends ManageSchedulesEvent {
  const UpdateServiceScope(this.scope);

  final String scope;

  @override
  List<Object?> get props => [scope];
}

class LoadServices extends ManageSchedulesEvent {
  const LoadServices();
}

class CreateSchedule extends ManageSchedulesEvent {
  const CreateSchedule(this.schedule);

  final AppointmentSchedule schedule;

  @override
  List<Object?> get props => [schedule];
}

class UpdateSchedule extends ManageSchedulesEvent {
  const UpdateSchedule({required this.id, required this.schedule});

  final String id;
  final AppointmentSchedule schedule;

  @override
  List<Object?> get props => [id, schedule];
}

class ToggleScheduleStatus extends ManageSchedulesEvent {
  const ToggleScheduleStatus({required this.id, required this.status});

  final String id;
  final String status;

  @override
  List<Object?> get props => [id, status];
}
