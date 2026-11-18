import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failure.dart';
import '../../domain/usecases/create_appointment.dart';
import '../../domain/usecases/get_appointment.dart';
import '../../domain/usecases/get_appointments.dart';
import '../../domain/usecases/update_appointment.dart';
import '../../domain/usecases/update_appointment_status.dart';
import 'appointment_event.dart';
import 'appointment_state.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  final GetAppointments getAppointments;
  final GetAppointment getAppointment;
  final CreateAppointment createAppointment;
  final UpdateAppointment updateAppointment;
  final SetAppointmentStatus setAppointmentStatus;

  AppointmentBloc({
    required this.getAppointments,
    required this.getAppointment,
    required this.createAppointment,
    required this.updateAppointment,
    required this.setAppointmentStatus,
  }) : super(const AppointmentInitial()) {
    on<GetAppointmentsEvent>(_onGetAppointments);
    on<GetAppointmentEvent>(_onGetAppointment);
    on<CreateAppointmentEvent>(_onCreateAppointment);
    on<UpdateAppointmentEvent>(_onUpdateAppointment);
    on<SetAppointmentStatusEvent>(_onSetAppointmentStatus);
  }

  Future<void> _onGetAppointments(
    GetAppointmentsEvent event,
    Emitter<AppointmentState> emit,
  ) async {
    emit(const AppointmentLoading());

    final result = await getAppointments(const GetAppointmentsParams());

    result.fold(
      (failure) => emit(AppointmentError(failureMessage(failure))),
      (appointments) => emit(AppointmentsLoaded(appointments)),
    );
  }

  Future<void> _onGetAppointment(
    GetAppointmentEvent event,
    Emitter<AppointmentState> emit,
  ) async {
    emit(const AppointmentLoading());

    final result = await getAppointment(GetAppointmentParams(id: event.id));

    result.fold(
      (failure) => emit(AppointmentError(failureMessage(failure))),
      (appointment) => emit(AppointmentDetailsLoaded(appointment)),
    );
  }

  Future<void> _onCreateAppointment(
    CreateAppointmentEvent event,
    Emitter<AppointmentState> emit,
  ) async {
    emit(const AppointmentLoading());

    final result = await createAppointment(
      CreateAppointmentParams(service: event.service, slot: event.slot),
    );

    if (isClosed) return;

    result.fold(
      (failure) => emit(AppointmentError(failureMessage(failure))),
      (appointment) => emit(AppointmentCreated(appointment)),
    );
  }

  Future<void> _onUpdateAppointment(
    UpdateAppointmentEvent event,
    Emitter<AppointmentState> emit,
  ) async {
    emit(const AppointmentLoading());

    final result = await updateAppointment(
      UpdateAppointmentParams(
        id: event.id,
        service: event.service,
        slot: event.slot,
      ),
    );

    result.fold(
      (failure) => emit(AppointmentError(failureMessage(failure))),
      (appointment) => emit(AppointmentDetailsLoaded(appointment)),
    );
  }

  Future<void> _onSetAppointmentStatus(
    SetAppointmentStatusEvent event,
    Emitter<AppointmentState> emit,
  ) async {
    emit(const AppointmentLoading());

    final result = await setAppointmentStatus(
      SetAppointmentStatusParams(id: event.id, status: event.status),
    );

    result.fold(
      (failure) => emit(AppointmentError(failureMessage(failure))),
      (appointment) => emit(AppointmentStatusUpdated(appointment)),
    );
  }
}
