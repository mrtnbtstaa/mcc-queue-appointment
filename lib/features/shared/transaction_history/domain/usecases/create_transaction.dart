import '../../../../../core/type_defs.dart';
import '../../../../../core/usecase/usecase.dart';
import '../entities/transaction_entity.dart';
import '../repositories/transaction_repository.dart';

class CreateTransactionParams {
  final String appointment;
  final String remarks;

  const CreateTransactionParams({
    required this.appointment,
    required this.remarks,
  });
}

class CreateTransaction
    implements UseCase<TransactionEntity, CreateTransactionParams> {
  final TransactionRepository repository;

  const CreateTransaction(this.repository);

  @override
  ResultFuture<TransactionEntity> call(CreateTransactionParams params) =>
      repository.createTransaction(
        appointment: params.appointment,
        remarks: params.remarks,
      );
}
