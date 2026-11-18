import 'package:fpdart/fpdart.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/network/api_error.dart';
import '../../../../../core/network/api_result.dart';
import '../../../../../core/network/paginated_data.dart';
import '../../../../../core/type_defs.dart';
import '../../domain/entities/transaction_entity.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../datasources/transaction_remote_data_source.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  TransactionRepositoryImpl(this._remoteDataSource);

  final TransactionRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<TransactionEntity> getTransaction(String id) async {
    final result = await _remoteDataSource.getTransaction(id);
    return switch (result) {
      ApiSuccess<TransactionEntity>(:final data) => Right(data),
      ApiFailure(:final error) => Left(ServerFailure(error.message)),
    };
  }

  @override
  ResultFuture<TransactionEntity> createTransaction({
    required String appointment,
    required String remarks,
  }) async {
    final result = await _remoteDataSource.createTransaction(
      appointment: appointment,
      remarks: remarks,
    );
    return switch (result) {
      ApiSuccess<TransactionEntity>(:final data) => Right(data),
      ApiFailure(:final error) => Left(ServerFailure(error.message)),
    };
  }

  @override
  ResultFuture<List<TransactionEntity>> getTransactions({
    String? search,
    String? status,
  }) async {
    final result = await _remoteDataSource.getTransactions(
      search: search,
      status: status,
    );

    return switch (result) {
      ApiSuccess<List<TransactionEntity>>(:final data) => Right(data),
      ApiFailure(:final error) => Left(ServerFailure(error.message)),
    };
  }

  @override
  ResultFuture<PaginatedData<TransactionEntity>> getTransactionsPage({
    String? search,
    String? status,
    required int page,
  }) async {
    final result = await _remoteDataSource.getTransactionsPage(
      search: search,
      status: status,
      page: page,
    );
    return switch (result) {
      ApiSuccess(:final data) => Right(data),
      ApiFailure(:final error) => Left(ServerFailure(error.message)),
    };
  }

  @override
  ResultFuture<TransactionEntity> setTransactionStatus({
    required String id,
    required String status,
    String? remarks,
  }) async {
    final result = await _remoteDataSource.setTransactionStatus(
      id: id,
      status: status,
      remarks: remarks,
    );

    return switch (result) {
      ApiSuccess<TransactionEntity>(:final data) => Right(data),
      ApiFailure(:final error) => Left(
        error.kind == ApiErrorKind.validation
            ? ValidationFailure(_validationErrors(error.details, error.message))
            : ServerFailure(error.message),
      ),
    };
  }

  Map<String, String> _validationErrors(
    Map<String, dynamic>? details,
    String message,
  ) {
    final errors = <String, String>{};
    for (final entry
        in details?.entries ?? const <MapEntry<String, dynamic>>[]) {
      final value = entry.value;
      final text = _validationText(value);
      if (text.isNotEmpty) errors[entry.key] = text;
    }
    return errors.isEmpty ? {'transaction_status': message} : errors;
  }

  String _validationText(Object? value) => switch (value) {
    List(:final isEmpty) when isEmpty => '',
    List(:final first) => _validationText(first),
    Map(:final entries) =>
      entries
          .map((entry) => '${entry.key}: ${_validationText(entry.value)}')
          .where((text) => !text.endsWith(': '))
          .join(', '),
    null => '',
    _ => value.toString(),
  };
}
