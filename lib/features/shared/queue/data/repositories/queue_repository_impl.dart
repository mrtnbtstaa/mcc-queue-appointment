import 'package:fpdart/fpdart.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/network/api_result.dart';
import '../../../../../core/network/paginated_data.dart';
import '../../../../../core/type_defs.dart';
import '../../domain/entities/queue_entity.dart';
import '../../domain/repositories/queue_repository.dart';
import '../datasources/queue_remote_data_source.dart';

class QueueRepositoryImpl implements QueueRepository {
  QueueRepositoryImpl(this._remoteDataSource);

  final QueueRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<QueueItemModel> getQueue(String id) async {
    final result = await _remoteDataSource.getQueue(id);
    return switch (result) {
      ApiSuccess<QueueItemModel>(:final data) => Right(data),
      ApiFailure(:final error) => Left(ServerFailure(error.message)),
    };
  }

  @override
  ResultFuture<List<QueueItemModel>> getQueues({
    String? search,
    String? status,
  }) async {
    final result = await _remoteDataSource.getQueues(
      search: search,
      status: status,
    );

    return switch (result) {
      ApiSuccess<List<QueueItemModel>>(:final data) => Right(data),
      ApiFailure(:final error) => Left(ServerFailure(error.message)),
    };
  }

  @override
  ResultFuture<PaginatedData<QueueItemModel>> getQueuesPage({
    String? search,
    String? status,
    required int page,
  }) async {
    final result = await _remoteDataSource.getQueuesPage(
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
  ResultFuture<QueueItemModel> setQueueStatus({
    required String id,
    required String status,
  }) async {
    final result = await _remoteDataSource.setQueueStatus(
      id: id,
      status: status,
    );

    return switch (result) {
      ApiSuccess<QueueItemModel>(:final data) => Right(data),
      ApiFailure(:final error) => Left(ServerFailure(error.message)),
    };
  }

  @override
  ResultFuture<QueueItemModel> createQueue({
    required String appointment,
  }) async {
    final result = await _remoteDataSource.createQueue(
      appointment: appointment,
    );
    return switch (result) {
      ApiSuccess<QueueItemModel>(:final data) => Right(data),
      ApiFailure(:final error) => Left(ServerFailure(error.message)),
    };
  }
}
