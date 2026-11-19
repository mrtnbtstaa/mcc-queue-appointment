import 'package:fpdart/fpdart.dart';

import '../../../../../../core/errors/failure.dart';
import '../../../../../../core/network/api_error.dart';
import '../../../../../../core/network/api_result.dart';
import '../../../../../../core/network/paginated_data.dart';
import '../../domain/entities/service_entity.dart';
import '../../domain/repositories/service_repository.dart';
import '../datasources/service_remote_data_source.dart';
import '../models/service_dto.dart';

class ServiceRepositoryImpl implements ServiceRepository {
  ServiceRepositoryImpl(this._remote);
  final ServiceRemoteDataSource _remote;

  // ── list ───────────────────────────────────────────────────────────
  @override
  Future<Either<Failure, List<ServiceEntity>>> getServices({
    String? search,
    String? category,
    bool? isActive,
  }) async {
    final result = await _remote.getServices(
      search: search,
      category: category,
      isActive: isActive,
    );

    return switch (result) {
      ApiSuccess(:final data) => Right(
        data.map((dto) => dto.toDomain()).toList(),
      ),
      ApiFailure(:final error) => Left(_mapFailure(error)),
    };
  }

  @override
  Future<Either<Failure, PaginatedData<ServiceEntity>>> getServicesPage({
    String? search,
    String? category,
    bool? isActive,
    required int page,
  }) async {
    final result = await _remote.getServicesPage(
      search: search,
      category: category,
      isActive: isActive,
      page: page,
    );
    return switch (result) {
      ApiSuccess(:final data) => Right(
        PaginatedData(
          items: data.items.map((dto) => dto.toDomain()).toList(),
          page: data.page,
          totalPages: data.totalPages,
        ),
      ),
      ApiFailure(:final error) => Left(_mapFailure(error)),
    };
  }

  // ── retrieve ───────────────────────────────────────────────────────
  @override
  Future<Either<Failure, ServiceEntity>> getService(String id) async {
    final result = await _remote.getService(id);

    return switch (result) {
      ApiSuccess(:final data) => Right(data.toDomain()),
      ApiFailure(:final error) => Left(_mapFailure(error)),
    };
  }

  // ── create ─────────────────────────────────────────────────────────
  @override
  Future<Either<Failure, ServiceEntity>> createService(
    ServiceEntity entity,
  ) async {
    final dto = ServiceDto.fromDomain(entity);
    final result = await _remote.createService(dto);

    return switch (result) {
      ApiSuccess() => Right(entity),
      ApiFailure(:final error) => Left(_mapFailure(error)),
    };
  }

  // ── update / partial_update ────────────────────────────────────────
  @override
  Future<Either<Failure, ServiceEntity>> updateService(
    String id,
    ServiceEntity entity,
  ) async {
    final dto = ServiceDto.fromDomain(entity);
    final result = await _remote.updateService(id, dto);

    return switch (result) {
      ApiSuccess(:final data) => Right(data.toDomain()),
      ApiFailure(:final error) => Left(_mapFailure(error)),
    };
  }

  // ── set_status ─────────────────────────────────────────────────────
  @override
  Future<Either<Failure, Unit>> setServiceStatus(
    String id,
    bool isActive,
  ) async {
    final result = await _remote.setServiceStatus(id, isActive);

    return switch (result) {
      ApiSuccess() => const Right(unit),
      ApiFailure(:final error) => Left(_mapFailure(error)),
    };
  }

  // ── Error Mapping ──────────────────────────────────────────────────
  Failure _mapFailure(ApiError error) {
    return switch (error.kind) {
      ApiErrorKind.validation => ValidationFailure(
        _extractErrors(error.details),
      ),
      ApiErrorKind.network || ApiErrorKind.timeout => const NetworkFailure(),
      ApiErrorKind.server => ServerFailure(error.message),
      ApiErrorKind.notFound => ServerFailure(error.message),
      _ => UnknownFailure(error.message),
    };
  }

  Map<String, String> _extractErrors(Map<String, dynamic>? details) {
    if (details == null) return const {};
    final out = <String, String>{};
    for (final entry in details.entries) {
      final value = entry.value;
      if (value is List && value.isNotEmpty && value.first is String) {
        out[entry.key] = value.first as String;
      } else if (value is String && value.isNotEmpty) {
        out[entry.key] = value;
      }
    }
    return out;
  }
}
