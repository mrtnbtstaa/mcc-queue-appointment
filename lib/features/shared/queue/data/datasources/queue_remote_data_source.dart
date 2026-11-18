import 'package:dio/dio.dart';

import '../../../../../core/network/api_result.dart';
import '../../../../../core/network/paginated_data.dart';
import '../../domain/entities/queue_entity.dart';

abstract interface class QueueRemoteDataSource {
  Future<ApiResult<QueueItemModel>> getQueue(
    String id, {
    CancelToken? cancelToken,
  });

  Future<ApiResult<List<QueueItemModel>>> getQueues({
    String? search,
    String? status,
    CancelToken? cancelToken,
  });
  Future<ApiResult<PaginatedData<QueueItemModel>>> getQueuesPage({
    String? search,
    String? status,
    required int page,
    CancelToken? cancelToken,
  });

  Future<ApiResult<QueueItemModel>> createQueue({required String appointment});

  Future<ApiResult<QueueItemModel>> setQueueStatus({
    required String id,
    required String status,
  });
}
