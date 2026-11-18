import 'package:equatable/equatable.dart';

sealed class AppointmentEvent extends Equatable {
  const AppointmentEvent();

  @override
  List<Object?> get props => [];
}

final class GetAppointmentsEvent extends AppointmentEvent {
  const GetAppointmentsEvent();
}

final class GetAppointmentEvent extends AppointmentEvent {
  final String id;

  const GetAppointmentEvent(this.id);

  @override
  List<Object?> get props => [id];
}

final class CreateAppointmentEvent extends AppointmentEvent {
  final String service;
  final String slot;

  const CreateAppointmentEvent({required this.service, required this.slot});

  @override
  List<Object?> get props => [service, slot];
}

final class UpdateAppointmentEvent extends AppointmentEvent {
  final String id;
  final String service;
  final String slot;

  const UpdateAppointmentEvent({
    required this.id,
    required this.service,
    required this.slot,
  });

  @override
  List<Object?> get props => [id, service, slot];
}

final class SetAppointmentStatusEvent extends AppointmentEvent {
  final String id;
  final String status;

  const SetAppointmentStatusEvent({required this.id, required this.status});

  @override
  List<Object?> get props => [id, status];
}
