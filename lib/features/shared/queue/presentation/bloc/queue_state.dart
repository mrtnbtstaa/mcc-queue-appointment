import 'package:equatable/equatable.dart';

import '../../domain/entities/queue_entity.dart';

class QueueState extends Equatable {
  final bool isLoading;
  final bool isUpdating;
  final String? error;
  final List<QueueItemModel> queues;
  final String selectedStatus;
  final int page;
  final int totalPages;
  final bool isLoadingMore;

  const QueueState({
    this.isLoading = false,
    this.isUpdating = false,
    this.error,
    this.queues = const [],
    this.selectedStatus = 'WAITING',
    this.page = 1,
    this.totalPages = 1,
    this.isLoadingMore = false,
  });

  List<QueueItemModel> get filteredQueue {
    return queues
        .where((item) => item.status.apiValue == selectedStatus)
        .toList();
  }

  QueueItemModel? get currentlyServing {
    for (final item in queues) {
      if (item.status == QueueStatus.serving) return item;
    }
    return null;
  }

  QueueItemModel? get myQueue {
    for (final item in queues) {
      if (item.isMine) return item;
    }
    return null;
  }

  QueueItemModel? get nextWaiting {
    for (final item in queues) {
      if (item.status == QueueStatus.waiting) return item;
    }
    return null;
  }

  int countFor(String status) {
    return queues
        .where((item) => item.status.apiValue == status)
        .length;
  }

  int get activeCount => queues
      .where(
        (item) =>
            item.status == QueueStatus.waiting ||
            item.status == QueueStatus.serving,
      )
      .length;

  QueueState copyWith({
    bool? isLoading,
    bool? isUpdating,
    String? error,
    bool clearError = false,
    List<QueueItemModel>? queues,
    String? selectedStatus,
    int? page,
    int? totalPages,
    bool? isLoadingMore,
  }) {
    return QueueState(
      isLoading: isLoading ?? this.isLoading,
      isUpdating: isUpdating ?? this.isUpdating,
      error: clearError ? null : (error ?? this.error),
      queues: queues ?? this.queues,
      selectedStatus: selectedStatus ?? this.selectedStatus,
      page: page ?? this.page,
      totalPages: totalPages ?? this.totalPages,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    isUpdating,
    error,
    queues,
    selectedStatus,
    page,
    totalPages,
    isLoadingMore,
  ];
}
