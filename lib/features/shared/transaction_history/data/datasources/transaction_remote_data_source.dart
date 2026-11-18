import 'package:dio/dio.dart';

import '../../../../../core/network/api_result.dart';
import '../../../../../core/network/paginated_data.dart';
import '../../domain/entities/transaction_entity.dart';

abstract interface class TransactionRemoteDataSource {
  Future<ApiResult<TransactionEntity>> getTransaction(String id);

  Future<ApiResult<TransactionEntity>> createTransaction({
    required String appointment,
    required String remarks,
  });

  Future<ApiResult<List<TransactionEntity>>> getTransactions({
    String? search,
    String? status,
    CancelToken? cancelToken,
  });
  Future<ApiResult<PaginatedData<TransactionEntity>>> getTransactionsPage({
    String? search,
    String? status,
    required int page,
    CancelToken? cancelToken,
  });

  Future<ApiResult<TransactionEntity>> setTransactionStatus({
    required String id,
    required String status,
    String? remarks,
  });
}
