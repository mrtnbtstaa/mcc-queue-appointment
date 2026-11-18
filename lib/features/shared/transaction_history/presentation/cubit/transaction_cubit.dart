import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failure.dart';
import '../../domain/entities/transaction_entity.dart';
import '../../domain/usecases/get_transactions.dart';
import '../../domain/usecases/set_transaction_status.dart';
import 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  final GetTransactions getTransactions;
  final SetTransactionStatus setTransactionStatus;

  TransactionCubit({
    required this.getTransactions,
    required this.setTransactionStatus,
  }) : super(const TransactionState());

  Future<void> loadTransactions() async {
    emit(state.copyWith(isLoading: true, clearError: true));

    final result = await getTransactions.callPage(page: 1);
    if (isClosed) return;

    result.fold(
      (failure) => emit(
        state.copyWith(isLoading: false, error: failureMessage(failure)),
      ),
      (page) => emit(
        state.copyWith(
          isLoading: false,
          clearError: true,
          transactions: page.items,
          page: page.page,
          totalPages: page.totalPages,
        ),
      ),
    );
  }

  Future<void> loadMore() async {
    if (state.isLoading || state.page >= state.totalPages) return;
    emit(state.copyWith(isLoading: true, clearError: true));
    final result = await getTransactions.callPage(page: state.page + 1);
    if (isClosed) return;
    result.fold(
      (failure) => emit(
        state.copyWith(isLoading: false, error: failureMessage(failure)),
      ),
      (next) => emit(
        state.copyWith(
          isLoading: false,
          clearError: true,
          transactions: [...state.transactions, ...next.items],
          page: next.page,
          totalPages: next.totalPages,
        ),
      ),
    );
  }

  Future<void> refresh() => loadTransactions();

  void setSearchQuery(String query) {
    emit(state.copyWith(searchQuery: query));
  }

  void setTab(TransactionTab tab) {
    emit(
      state.copyWith(
        selectedTab: tab,
        selectedFilterIndex: switch (tab) {
          TransactionTab.allRecords => 0,
          TransactionTab.completed => 1,
          TransactionTab.inProgress => 2,
        },
      ),
    );
  }

  void changeFilter(int index) {
    setTab(switch (index) {
      1 => TransactionTab.completed,
      2 => TransactionTab.inProgress,
      _ => TransactionTab.allRecords,
    });
  }

  void setDateWindow(String window) {
    emit(state.copyWith(dateWindow: window));
  }

  void setServiceType(String service) {
    emit(state.copyWith(serviceType: service));
  }

  Future<void> setStatus(String id, String status) async {
    emit(state.copyWith(isUpdating: true, clearError: true));

    final result = await setTransactionStatus(
      SetTransactionStatusParams(id: id, status: status),
    );
    if (isClosed) return;

    result.fold(
      (failure) => emit(
        state.copyWith(isUpdating: false, error: failureMessage(failure)),
      ),
      (updated) => emit(
        state.copyWith(
          isUpdating: false,
          clearError: true,
          transactions: [
            for (final transaction in state.transactions)
              if (transaction.id == updated.id) updated else transaction,
          ],
        ),
      ),
    );
  }
}
