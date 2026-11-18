import '../../../../../core/type_defs.dart';
import '../../../../../core/usecase/usecase.dart';
import '../entities/queue_entity.dart';
import '../repositories/queue_repository.dart';

class CreateQueueParams {
  final String appointment;

  const CreateQueueParams({required this.appointment});
}

class CreateQueue implements UseCase<QueueItemModel, CreateQueueParams> {
  final QueueRepository repository;

  const CreateQueue(this.repository);

  @override
  ResultFuture<QueueItemModel> call(CreateQueueParams params) =>
      repository.createQueue(appointment: params.appointment);
}
