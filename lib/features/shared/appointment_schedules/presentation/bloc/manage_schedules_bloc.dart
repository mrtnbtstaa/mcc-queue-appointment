import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../../../core/errors/failure.dart';
import '../../../services/domain/usecases/get_services.dart';
import '../../domain/usecases/create_appointment_schedule.dart';
import '../../domain/usecases/get_appointment_schedule.dart';
import '../../domain/usecases/get_appointment_schedules.dart';
import '../../domain/usecases/set_appointment_schedule_status.dart';
import '../../domain/usecases/update_appointment_schedule.dart';
import 'manage_schedules_event.dart';
import 'manage_schedules_state.dart';

class ManageSchedulesBloc
    extends Bloc<ManageSchedulesEvent, ManageSchedulesState> {
  static final DateTime _initialDate = DateTime.now();

  final GetAppointmentSchedules _getAppointmentSchedules;
  final CreateAppointmentSchedule _createAppointmentSchedule;
  final SetAppointmentScheduleStatus _setAppointmentScheduleStatus;
  final GetAppointmentSchedule _getAppointmentSchedule;
  final UpdateAppointmentSchedule _updateAppointmentSchedule;
  final GetServicesUseCase _getServices;

  ManageSchedulesBloc({
    required GetAppointmentSchedules getAppointmentSchedules,
    required GetAppointmentSchedule getAppointmentSchedule,
    required CreateAppointmentSchedule createAppointmentSchedule,
    required UpdateAppointmentSchedule updateAppointmentSchedule,
    required SetAppointmentScheduleStatus setAppointmentScheduleStatus,
    required GetServicesUseCase getServices,
  }) : _getAppointmentSchedules = getAppointmentSchedules,
       _getAppointmentSchedule = getAppointmentSchedule,
       _createAppointmentSchedule = createAppointmentSchedule,
       _updateAppointmentSchedule = updateAppointmentSchedule,
       _setAppointmentScheduleStatus = setAppointmentScheduleStatus,
       _getServices = getServices,
       super(
         ManageSchedulesState(
           selectedDate: _initialDate,
           focusedDate: _initialDate,
         ),
       ) {
    on<LoadSchedules>(_onLoadSchedules);

    on<SelectDate>(_onSelectDate);

    on<ChangeFocusedDate>(_onChangeFocusedDate);

    on<GoToToday>(_onGoToToday);

    on<UpdateServiceScope>(_onUpdateServiceScope);

    on<CreateSchedule>(_onCreateSchedule);

    on<ToggleScheduleStatus>(_onToggleScheduleStatus);

    on<LoadSchedule>(_onLoadSchedule);

    on<UpdateSchedule>(_onUpdateSchedule);

    on<LoadServices>(_onLoadServices);
  }

  Future<void> _onLoadSchedules(
    LoadSchedules event,
    Emitter<ManageSchedulesState> emit,
  ) async {
    emit(state.copyWith(status: ManageSchedulesStatus.loading));

    final result = await _getAppointmentSchedules(
      GetAppointmentSchedulesParams(search: event.search),
    );

    result.fold(
      (failure) {
        debugPrint('LOAD SCHEDULES ERROR: ${failureMessage(failure)}');

        emit(
          state.copyWith(
            status: ManageSchedulesStatus.failure,
            errorMessage: failureMessage(failure),
          ),
        );
      },
      (schedules) {
        debugPrint('API SCHEDULE COUNT: ${schedules.length}');

        for (final schedule in schedules) {
          debugPrint('Schedule: ${schedule.service} | ${schedule.date}');
        }

        emit(
          state.copyWith(
            status: ManageSchedulesStatus.success,
            schedules: schedules,
          ),
        );
      },
    );
  }

  void _onSelectDate(SelectDate event, Emitter<ManageSchedulesState> emit) {
    emit(state.copyWith(selectedDate: event.date, focusedDate: event.date));
  }

  void _onChangeFocusedDate(
    ChangeFocusedDate event,
    Emitter<ManageSchedulesState> emit,
  ) {
    emit(state.copyWith(focusedDate: event.date));
  }

  void _onGoToToday(GoToToday event, Emitter<ManageSchedulesState> emit) {
    final today = DateTime.now();

    emit(state.copyWith(selectedDate: today, focusedDate: today));
  }

  void _onUpdateServiceScope(
    UpdateServiceScope event,
    Emitter<ManageSchedulesState> emit,
  ) {
    emit(state.copyWith(selectedServiceScope: event.scope));
  }

  Future<void> _onCreateSchedule(
    CreateSchedule event,
    Emitter<ManageSchedulesState> emit,
  ) async {
    final result = await _createAppointmentSchedule(event.schedule);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: ManageSchedulesStatus.failure,
            errorMessage: failureMessage(failure),
          ),
        );
      },
      (_) {
        add(const LoadSchedules());
      },
    );
  }

  Future<void> _onToggleScheduleStatus(
    ToggleScheduleStatus event,
    Emitter<ManageSchedulesState> emit,
  ) async {
    final result = await _setAppointmentScheduleStatus(
      SetAppointmentScheduleStatusParams(id: event.id, status: event.status),
    );

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: ManageSchedulesStatus.failure,
            errorMessage: failureMessage(failure),
          ),
        );
      },
      (_) {
        add(const LoadSchedules());
      },
    );
  }

  Future<void> _onLoadSchedule(
    LoadSchedule event,
    Emitter<ManageSchedulesState> emit,
  ) async {
    emit(state.copyWith(status: ManageSchedulesStatus.loading));

    final result = await _getAppointmentSchedule(event.id);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: ManageSchedulesStatus.failure,
            errorMessage: failureMessage(failure),
          ),
        );
      },
      (schedule) {
        emit(state.copyWith(status: ManageSchedulesStatus.success));
      },
    );
  }

  Future<void> _onUpdateSchedule(
    UpdateSchedule event,
    Emitter<ManageSchedulesState> emit,
  ) async {
    final result = await _updateAppointmentSchedule(
      UpdateAppointmentScheduleParams(id: event.id, schedule: event.schedule),
    );

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: ManageSchedulesStatus.failure,
            errorMessage: failureMessage(failure),
          ),
        );
      },
      (_) {
        add(const LoadSchedules());
      },
    );
  }

  Future<void> _onLoadServices(
    LoadServices event,
    Emitter<ManageSchedulesState> emit,
  ) async {
    final result = await _getServices();

    result.fold(
      (failure) {
        emit(state.copyWith(errorMessage: failureMessage(failure)));
      },
      (services) {
        emit(state.copyWith(services: services));
      },
    );
  }
}
