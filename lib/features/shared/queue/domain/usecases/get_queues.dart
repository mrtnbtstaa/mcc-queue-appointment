import '../../../../../core/network/paginated_data.dart';
import '../../../../../core/type_defs.dart';
import '../../../../../core/usecase/usecase.dart';
import '../entities/queue_entity.dart';
import '../repositories/queue_repository.dart';

class GetQueuesParams {
  const GetQueuesParams({this.search, this.status});

  final String? search;
  final String? status;
}

class GetQueues implements UseCase<List<QueueItemModel>, GetQueuesParams> {
  final QueueRepository repository;

  const GetQueues(this.repository);

  @override
  ResultFuture<List<QueueItemModel>> call(GetQueuesParams params) {
    return repository.getQueues(search: params.search, status: params.status);
  }

  ResultFuture<PaginatedData<QueueItemModel>> callPage({
    String? search,
    String? status,
    required int page,
  }) => repository.getQueuesPage(search: search, status: status, page: page);
}
