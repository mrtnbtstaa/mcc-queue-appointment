import 'package:equatable/equatable.dart';

import '../../domain/entities/queue_entity.dart';

class QueueState extends Equatable {
  final bool isLoading;
  final bool isUpdating;
  final String? error;
  final List<QueueItemModel> queues;
  final QueueTab selectedTab;
  final int page;
  final int totalPages;
  final bool isLoadingMore;

  const QueueState({
    this.isLoading = false,
    this.isUpdating = false,
    this.error,
    this.queues = const [],
    this.selectedTab = QueueTab.waiting,
    this.page = 1,
    this.totalPages = 1,
    this.isLoadingMore = false,
  });

  List<QueueItemModel> get filteredQueue {
    return queues.where((item) {
      return switch (selectedTab) {
        QueueTab.waiting => item.status == QueueStatus.waiting,
        QueueTab.serving => item.status == QueueStatus.serving,
        QueueTab.done => item.status == QueueStatus.done,
        QueueTab.skipped => item.status == QueueStatus.skipped,
      };
    }).toList();
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

  int countFor(QueueTab tab) {
    return queues.where((item) {
      return switch (tab) {
        QueueTab.waiting => item.status == QueueStatus.waiting,
        QueueTab.serving => item.status == QueueStatus.serving,
        QueueTab.done => item.status == QueueStatus.done,
        QueueTab.skipped => item.status == QueueStatus.skipped,
      };
    }).length;
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
    QueueTab? selectedTab,
    int? page,
    int? totalPages,
    bool? isLoadingMore,
  }) {
    return QueueState(
      isLoading: isLoading ?? this.isLoading,
      isUpdating: isUpdating ?? this.isUpdating,
      error: clearError ? null : (error ?? this.error),
      queues: queues ?? this.queues,
      selectedTab: selectedTab ?? this.selectedTab,
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
    selectedTab,
    page,
    totalPages,
    isLoadingMore,
  ];
}
