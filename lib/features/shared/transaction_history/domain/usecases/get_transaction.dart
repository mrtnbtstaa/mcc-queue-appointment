import '../../../../../core/type_defs.dart';
import '../../../../../core/usecase/usecase.dart';
import '../entities/transaction_entity.dart';
import '../repositories/transaction_repository.dart';

class GetTransaction implements UseCase<TransactionEntity, String> {
  final TransactionRepository repository;

  const GetTransaction(this.repository);

  @override
  ResultFuture<TransactionEntity> call(String id) =>
      repository.getTransaction(id);
}
