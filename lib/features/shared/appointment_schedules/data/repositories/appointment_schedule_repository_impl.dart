import 'package:fpdart/fpdart.dart';

import '../../../../../../core/errors/failure.dart';
import '../../../../../../core/network/api_result.dart';
import '../../../../../../core/type_defs.dart';
import '../../domain/entities/appointment_schedule.dart';
import '../../domain/repositories/appointment_schedule_repository.dart';
import '../datasources/appointment_schedule_remote_datasource.dart';
import '../models/appointment_schedule_model.dart';

class AppointmentScheduleRepositoryImpl
    implements AppointmentScheduleRepository {
  AppointmentScheduleRepositoryImpl(this._remoteDataSource);

  final AppointmentScheduleRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<List<AppointmentSchedule>> getSchedules({String? search}) async {
    final result = await _remoteDataSource.getSchedules(search: search);

    return switch (result) {
      ApiSuccess<List<AppointmentScheduleModel>>(:final data) => Right(data),
      ApiFailure(:final error) => Left(ServerFailure(error.message)),
    };
  }

  @override
  ResultFuture<AppointmentSchedule> getSchedule(String id) async {
    final result = await _remoteDataSource.getSchedule(id);

    return switch (result) {
      ApiSuccess<AppointmentScheduleModel>(:final data) => Right(data),
      ApiFailure(:final error) => Left(ServerFailure(error.message)),
    };
  }

  @override
  ResultFuture<AppointmentSchedule> createSchedule(
    AppointmentSchedule schedule,
  ) async {
    final result = await _remoteDataSource.createSchedule(
      AppointmentScheduleModel(
        id: schedule.id,
        status: schedule.status,
        startTime: schedule.startTime,
        endTime: schedule.endTime,
        date: schedule.date,
        capacity: schedule.capacity,
        service: schedule.service,
        serviceName: schedule.serviceName,
      ),
    );

    return switch (result) {
      ApiSuccess<AppointmentScheduleModel>(:final data) => Right(data),
      ApiFailure(:final error) => Left(ServerFailure(error.message)),
    };
  }

  @override
  ResultFuture<AppointmentSchedule> updateSchedule(
    String id,
    AppointmentSchedule schedule,
  ) async {
    final result = await _remoteDataSource.updateSchedule(
      id,
      AppointmentScheduleModel(
        id: schedule.id,
        status: schedule.status,
        startTime: schedule.startTime,
        endTime: schedule.endTime,
        date: schedule.date,
        capacity: schedule.capacity,
        service: schedule.service,
        serviceName: schedule.serviceName,
      ),
    );

    return switch (result) {
      ApiSuccess<AppointmentScheduleModel>(:final data) => Right(data),
      ApiFailure(:final error) => Left(ServerFailure(error.message)),
    };
  }

  @override
  ResultVoid setStatus(String id, String status) async {
    final result = await _remoteDataSource.setStatus(id, status);

    return switch (result) {
      ApiSuccess<void>() => Right(unit),
      ApiFailure(:final error) => Left(ServerFailure(error.message)),
    };
  }
}
