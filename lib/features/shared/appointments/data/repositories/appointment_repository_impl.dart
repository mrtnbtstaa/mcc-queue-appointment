import 'package:fpdart/fpdart.dart';

import '../../../../../../core/errors/failure.dart';
import '../../../../../../core/network/api_result.dart';
import '../../../../../../core/network/paginated_data.dart';
import '../../../../../../core/type_defs.dart';
import '../../domain/entities/appointment.dart';
import '../../domain/repositories/appointment_repository.dart';
import '../datasources/appointment_remote_data_source.dart';
import '../models/appointment_model.dart';

class AppointmentRepositoryImpl implements AppointmentRepository {
  AppointmentRepositoryImpl(this._remoteDataSource);

  final AppointmentRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<List<Appointment>> getAppointments({
    String? search,
    String? status,
  }) async {
    final result = await _remoteDataSource.getAppointments(
      search: search,
      status: status,
    );

    return switch (result) {
      ApiSuccess<List<AppointmentModel>>(:final data) => Right(data),
      ApiFailure(:final error) => Left(ServerFailure(error.message)),
    };
  }

  @override
  ResultFuture<PaginatedData<Appointment>> getAppointmentsPage({
    String? search,
    String? status,
    required int page,
  }) async {
    final result = await _remoteDataSource.getAppointmentsPage(
      search: search,
      status: status,
      page: page,
    );
    return switch (result) {
      ApiSuccess(:final data) => Right(data),
      ApiFailure(:final error) => Left(ServerFailure(error.message)),
    };
  }

  @override
  ResultFuture<Appointment> getAppointment(String id) async {
    final result = await _remoteDataSource.getAppointment(id);

    return switch (result) {
      ApiSuccess<AppointmentModel>(:final data) => Right(data),
      ApiFailure(:final error) => Left(ServerFailure(error.message)),
    };
  }

  @override
  ResultFuture<Appointment> createAppointment({
    required String service,
    required String slot,
    required String status,
  }) async {
    final result = await _remoteDataSource.createAppointment(
      service: service,
      slot: slot,
      status: status,
    );

    return switch (result) {
      ApiSuccess<AppointmentModel>(:final data) => Right(data),
      ApiFailure(:final error) => Left(ServerFailure(error.message)),
    };
  }

  @override
  ResultFuture<Appointment> updateAppointment({
    required String id,
    required String service,
    required String slot,
  }) async {
    final result = await _remoteDataSource.updateAppointment(
      id: id,
      service: service,
      slot: slot,
    );

    return switch (result) {
      ApiSuccess<AppointmentModel>(:final data) => Right(data),
      ApiFailure(:final error) => Left(ServerFailure(error.message)),
    };
  }

  @override
  ResultFuture<Appointment> setAppointmentStatus({
    required String id,
    required String status,
  }) async {
    final result = await _remoteDataSource.setAppointmentStatus(
      id: id,
      status: status,
    );

    return switch (result) {
      ApiSuccess<AppointmentModel>(:final data) => Right(data),
      ApiFailure(:final error) => Left(ServerFailure(error.message)),
    };
  }
}
