import '../../../../../core/network/paginated_data.dart';
import '../../../../../core/type_defs.dart';
import '../entities/queue_entity.dart';

abstract interface class QueueRepository {
  ResultFuture<QueueItemModel> getQueue(String id);

  ResultFuture<List<QueueItemModel>> getQueues({
    String? search,
    String? status,
  });
  ResultFuture<PaginatedData<QueueItemModel>> getQueuesPage({
    String? search,
    String? status,
    required int page,
  });

  ResultFuture<QueueItemModel> createQueue({required String appointment});

  ResultFuture<QueueItemModel> setQueueStatus({
    required String id,
    required String status,
  });
}
