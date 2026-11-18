import '../../../../../core/network/paginated_data.dart';
import '../../../../../core/type_defs.dart';
import '../../../../../core/usecase/usecase.dart';
import '../entities/transaction_entity.dart';
import '../repositories/transaction_repository.dart';

class GetTransactionsParams {
  const GetTransactionsParams({this.search, this.status});

  final String? search;
  final String? status;
}

class GetTransactions
    implements UseCase<List<TransactionEntity>, GetTransactionsParams> {
  final TransactionRepository repository;

  const GetTransactions(this.repository);

  @override
  ResultFuture<List<TransactionEntity>> call(GetTransactionsParams params) {
    return repository.getTransactions(
      search: params.search,
      status: params.status,
    );
  }

  ResultFuture<PaginatedData<TransactionEntity>> callPage({
    String? search,
    String? status,
    required int page,
  }) => repository.getTransactionsPage(
    search: search,
    status: status,
    page: page,
  );
}
