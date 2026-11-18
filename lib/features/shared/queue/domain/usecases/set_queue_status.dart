import '../../../../../core/type_defs.dart';
import '../../../../../core/usecase/usecase.dart';
import '../entities/queue_entity.dart';
import '../repositories/queue_repository.dart';

class SetQueueStatusParams {
  final String id;
  final String status;

  const SetQueueStatusParams({required this.id, required this.status});
}

class SetQueueStatus implements UseCase<QueueItemModel, SetQueueStatusParams> {
  final QueueRepository repository;

  const SetQueueStatus(this.repository);

  @override
  ResultFuture<QueueItemModel> call(SetQueueStatusParams params) {
    return repository.setQueueStatus(id: params.id, status: params.status);
  }
}
