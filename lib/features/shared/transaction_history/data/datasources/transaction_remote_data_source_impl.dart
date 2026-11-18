import 'package:dio/dio.dart';

import '../../../../../core/network/api_client.dart';
import '../../../../../core/network/api_result.dart';
import '../../../../../core/network/paginated_data.dart';
import '../../domain/entities/transaction_entity.dart';
import 'transaction_remote_data_source.dart';

class TransactionRemoteDataSourceImpl implements TransactionRemoteDataSource {
  final ApiClient apiClient;

  const TransactionRemoteDataSourceImpl(this.apiClient);

  static const String endpoint = 'v1/transactions/';

  @override
  Future<ApiResult<TransactionEntity>> getTransaction(String id) =>
      apiClient.get<TransactionEntity>(
        '$endpoint$id/',
        decode: (json) => TransactionEntity.fromJson(
          (json as Map<String, dynamic>)['data'] as Map<String, dynamic>,
        ),
      );

  @override
  Future<ApiResult<TransactionEntity>> createTransaction({
    required String appointment,
    required String remarks,
  }) => apiClient.post<TransactionEntity>(
    endpoint,
    body: {'appointment': appointment, 'remarks': remarks},
    decode: (json) => TransactionEntity.fromJson(
      (json as Map<String, dynamic>)['data'] as Map<String, dynamic>,
    ),
  );

  @override
  Future<ApiResult<List<TransactionEntity>>> getTransactions({
    String? search,
    String? status,
    CancelToken? cancelToken,
  }) {
    final trimmedSearch = search?.trim();
    final trimmedStatus = status?.trim();

    return apiClient.get<List<TransactionEntity>>(
      endpoint,
      query: {
        'page_size': 100,
        if (trimmedSearch != null && trimmedSearch.isNotEmpty)
          'search': trimmedSearch,
        if (trimmedStatus != null && trimmedStatus.isNotEmpty)
          'transaction_status': trimmedStatus,
      },
      cancelToken: cancelToken,
      decode: (json) {
        final body = json as Map<String, dynamic>;
        final results = body['data'] as List<dynamic>;

        return results
            .map(
              (item) =>
                  TransactionEntity.fromJson(item as Map<String, dynamic>),
            )
            .toList();
      },
    );
  }

  @override
  Future<ApiResult<PaginatedData<TransactionEntity>>> getTransactionsPage({
    String? search,
    String? status,
    required int page,
    CancelToken? cancelToken,
  }) {
    final trimmedSearch = search?.trim();
    final trimmedStatus = status?.trim();
    return apiClient.get<PaginatedData<TransactionEntity>>(
      endpoint,
      query: {
        'page': page,
        'page_size': 10,
        if (trimmedSearch != null && trimmedSearch.isNotEmpty)
          'search': trimmedSearch,
        if (trimmedStatus != null && trimmedStatus.isNotEmpty)
          'transaction_status': trimmedStatus,
      },
      cancelToken: cancelToken,
      decode: (json) {
        final body = json as Map<String, dynamic>;
        final pagination =
            (body['meta'] as Map<String, dynamic>)['pagination']
                as Map<String, dynamic>;
        return PaginatedData(
          items: (body['data'] as List<dynamic>)
              .map(
                (item) =>
                    TransactionEntity.fromJson(item as Map<String, dynamic>),
              )
              .toList(),
          page: (pagination['page'] as num).toInt(),
          totalPages: (pagination['total_pages'] as num).toInt(),
        );
      },
    );
  }

  @override
  Future<ApiResult<TransactionEntity>> setTransactionStatus({
    required String id,
    required String status,
    String? remarks,
  }) {
    return apiClient.patch<TransactionEntity>(
      '$endpoint$id/status/',
      body: {'transaction_status': status, 'remarks': remarks},
      decode: (json) {
        final body = json as Map<String, dynamic>;
        return TransactionEntity.fromJson(body['data'] as Map<String, dynamic>);
      },
    );
  }
}
