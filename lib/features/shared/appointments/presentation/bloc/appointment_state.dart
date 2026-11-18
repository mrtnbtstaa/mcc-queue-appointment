import 'package:equatable/equatable.dart';

import '../../domain/entities/appointment.dart';

sealed class AppointmentState extends Equatable {
  const AppointmentState();

  @override
  List<Object?> get props => [];
}

final class AppointmentInitial extends AppointmentState {
  const AppointmentInitial();
}

final class AppointmentLoading extends AppointmentState {
  const AppointmentLoading();
}

final class AppointmentsLoaded extends AppointmentState {
  final List<Appointment> appointments;

  const AppointmentsLoaded(this.appointments);

  @override
  List<Object?> get props => [appointments];
}

final class AppointmentDetailsLoaded extends AppointmentState {
  final Appointment appointment;

  const AppointmentDetailsLoaded(this.appointment);

  @override
  List<Object?> get props => [appointment];
}

final class AppointmentCreated extends AppointmentState {
  final Appointment appointment;

  const AppointmentCreated(this.appointment);

  @override
  List<Object?> get props => [appointment];
}

final class AppointmentStatusUpdated extends AppointmentState {
  final Appointment appointment;

  const AppointmentStatusUpdated(this.appointment);

  @override
  List<Object?> get props => [appointment];
}

final class AppointmentError extends AppointmentState {
  final String message;

  const AppointmentError(this.message);

  @override
  List<Object?> get props => [message];
}
