import 'package:equatable/equatable.dart';

import '../../domain/entities/transaction_entity.dart';

class TransactionState extends Equatable {
  final bool isLoading;
  final bool isUpdating;
  final String? error;
  final List<TransactionEntity> transactions;
  final int selectedFilterIndex;
  final TransactionTab selectedTab;
  final String searchQuery;
  final String dateWindow;
  final String serviceType;
  final int page;
  final int totalPages;

  const TransactionState({
    this.isLoading = false,
    this.isUpdating = false,
    this.error,
    this.transactions = const [],
    this.selectedFilterIndex = 0,
    this.selectedTab = TransactionTab.allRecords,
    this.searchQuery = '',
    this.dateWindow = 'All dates',
    this.serviceType = 'All Services',
    this.page = 1,
    this.totalPages = 1,
  });

  List<TransactionEntity> get filteredTransactions {
    final query = searchQuery.trim().toLowerCase();

    return transactions.where((transaction) {
      final matchesTab = switch (selectedTab) {
        TransactionTab.allRecords => true,
        TransactionTab.completed => transaction.isCompleted,
        TransactionTab.inProgress => transaction.isInProgress,
      };

      if (!matchesTab) return false;
      if (query.isEmpty) return true;

      return transaction.studentName.toLowerCase().contains(query) ||
          transaction.studentId.toLowerCase().contains(query) ||
          transaction.refNo.toLowerCase().contains(query) ||
          transaction.serviceName.toLowerCase().contains(query) ||
          transaction.statusText.toLowerCase().contains(query);
    }).toList();
  }

  int get completedCount =>
      transactions.where((transaction) => transaction.isCompleted).length;

  int get inProgressCount =>
      transactions.where((transaction) => transaction.isInProgress).length;

  TransactionState copyWith({
    bool? isLoading,
    bool? isUpdating,
    String? error,
    bool clearError = false,
    List<TransactionEntity>? transactions,
    int? selectedFilterIndex,
    TransactionTab? selectedTab,
    String? searchQuery,
    String? dateWindow,
    String? serviceType,
    int? page,
    int? totalPages,
  }) {
    return TransactionState(
      isLoading: isLoading ?? this.isLoading,
      isUpdating: isUpdating ?? this.isUpdating,
      error: clearError ? null : (error ?? this.error),
      transactions: transactions ?? this.transactions,
      selectedFilterIndex: selectedFilterIndex ?? this.selectedFilterIndex,
      selectedTab: selectedTab ?? this.selectedTab,
      searchQuery: searchQuery ?? this.searchQuery,
      dateWindow: dateWindow ?? this.dateWindow,
      serviceType: serviceType ?? this.serviceType,
      page: page ?? this.page,
      totalPages: totalPages ?? this.totalPages,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    isUpdating,
    error,
    transactions,
    selectedFilterIndex,
    selectedTab,
    searchQuery,
    dateWindow,
    serviceType,
    page,
    totalPages,
  ];
}
