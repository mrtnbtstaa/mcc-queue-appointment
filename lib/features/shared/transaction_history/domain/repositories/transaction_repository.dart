import '../../../../../core/network/paginated_data.dart';
import '../../../../../core/type_defs.dart';
import '../entities/transaction_entity.dart';

abstract interface class TransactionRepository {
  ResultFuture<TransactionEntity> getTransaction(String id);

  ResultFuture<TransactionEntity> createTransaction({
    required String appointment,
    required String remarks,
  });

  ResultFuture<List<TransactionEntity>> getTransactions({
    String? search,
    String? status,
  });
  ResultFuture<PaginatedData<TransactionEntity>> getTransactionsPage({
    String? search,
    String? status,
    required int page,
  });

  ResultFuture<TransactionEntity> setTransactionStatus({
    required String id,
    required String status,
    String? remarks,
  });
}
