import 'package:dio/dio.dart';

import '../../../../../core/network/api_client.dart';
import '../../../../../core/network/api_result.dart';
import '../../../../../core/network/paginated_data.dart';
import '../../domain/entities/queue_entity.dart';
import 'queue_remote_data_source.dart';

class QueueRemoteDataSourceImpl implements QueueRemoteDataSource {
  final ApiClient apiClient;

  const QueueRemoteDataSourceImpl(this.apiClient);

  static const String endpoint = 'v1/queues/';

  @override
  Future<ApiResult<QueueItemModel>> getQueue(
    String id, {
    CancelToken? cancelToken,
  }) {
    return apiClient.get<QueueItemModel>(
      '$endpoint$id/',
      cancelToken: cancelToken,
      decode: (json) {
        final body = json as Map<String, dynamic>;
        return QueueItemModel.fromJson(body['data'] as Map<String, dynamic>);
      },
    );
  }

  @override
  Future<ApiResult<List<QueueItemModel>>> getQueues({
    String? search,
    String? status,
    CancelToken? cancelToken,
  }) {
    final trimmedSearch = search?.trim();
    final trimmedStatus = status?.trim();

    return apiClient.get<List<QueueItemModel>>(
      endpoint,
      query: {
        'page_size': 100,
        if (trimmedSearch != null && trimmedSearch.isNotEmpty)
          'search': trimmedSearch,
        if (trimmedStatus != null && trimmedStatus.isNotEmpty)
          'status': trimmedStatus,
      },
      cancelToken: cancelToken,
      decode: (json) {
        final body = json as Map<String, dynamic>;
        final results = body['data'] as List<dynamic>;

        return results
            .map(
              (item) => QueueItemModel.fromJson(item as Map<String, dynamic>),
            )
            .toList();
      },
    );
  }

  @override
  Future<ApiResult<PaginatedData<QueueItemModel>>> getQueuesPage({
    String? search,
    String? status,
    required int page,
    CancelToken? cancelToken,
  }) {
    return apiClient.get<PaginatedData<QueueItemModel>>(
      endpoint,
      query: {
        'page': page,
        'page_size': 10,
        if (search != null && search.trim().isNotEmpty) 'search': search.trim(),
        if (status != null && status.trim().isNotEmpty) 'status': status.trim(),
      },
      cancelToken: cancelToken,
      decode: (json) {
        final body = json as Map<String, dynamic>;
        final pagination =
            (body['meta'] as Map<String, dynamic>)['pagination']
                as Map<String, dynamic>;
        return PaginatedData(
          items: (body['data'] as List<dynamic>)
              .map(
                (item) => QueueItemModel.fromJson(item as Map<String, dynamic>),
              )
              .toList(),
          page: (pagination['page'] as num).toInt(),
          totalPages: (pagination['total_pages'] as num).toInt(),
        );
      },
    );
  }

  @override
  Future<ApiResult<QueueItemModel>> createQueue({required String appointment}) {
    return apiClient.post<QueueItemModel>(
      endpoint,
      body: {'appointment': appointment},
      decode: (json) {
        final body = json as Map<String, dynamic>;
        return QueueItemModel.fromJson(body['data'] as Map<String, dynamic>);
      },
      isIdempotent: true,
    );
  }

  @override
  Future<ApiResult<QueueItemModel>> setQueueStatus({
    required String id,
    required String status,
  }) {
    return apiClient.patch<QueueItemModel>(
      '$endpoint$id/status/',
      body: {'status': status},
      decode: (json) {
        final body = json as Map<String, dynamic>;
        return QueueItemModel.fromJson(body['data'] as Map<String, dynamic>);
      },
    );
  }
}
