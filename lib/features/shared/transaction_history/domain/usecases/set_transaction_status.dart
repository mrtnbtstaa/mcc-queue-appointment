import '../../../../../core/type_defs.dart';
import '../../../../../core/usecase/usecase.dart';
import '../entities/transaction_entity.dart';
import '../repositories/transaction_repository.dart';

class SetTransactionStatusParams {
  final String id;
  final String status;
  final String? remarks;

  const SetTransactionStatusParams({
    required this.id,
    required this.status,
    this.remarks,
  });
}

class SetTransactionStatus
    implements UseCase<TransactionEntity, SetTransactionStatusParams> {
  final TransactionRepository repository;

  const SetTransactionStatus(this.repository);

  @override
  ResultFuture<TransactionEntity> call(SetTransactionStatusParams params) {
    return repository.setTransactionStatus(
      id: params.id,
      status: params.status,
      remarks: params.remarks,
    );
  }
}
