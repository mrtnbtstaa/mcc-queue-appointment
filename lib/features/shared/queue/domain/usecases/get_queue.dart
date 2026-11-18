import '../../../../../core/type_defs.dart';
import '../../../../../core/usecase/usecase.dart';
import '../entities/queue_entity.dart';
import '../repositories/queue_repository.dart';

class GetQueue implements UseCase<QueueItemModel, String> {
  final QueueRepository repository;

  const GetQueue(this.repository);

  @override
  ResultFuture<QueueItemModel> call(String id) => repository.getQueue(id);
}
