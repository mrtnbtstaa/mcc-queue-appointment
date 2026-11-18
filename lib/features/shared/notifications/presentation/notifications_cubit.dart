import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../data/notification_remote_data_source.dart';
import '../domain/notification_entity.dart';

class NotificationsState {
  final int unreadCount;
  final List<NotificationEntity> items;
  final String? error;

  const NotificationsState({
    this.unreadCount = 0,
    this.items = const [],
    this.error,
  });
}

class NotificationsCubit extends Cubit<NotificationsState> {
  final NotificationRemoteDataSource remote;
  Timer? _pollTimer;
  bool _isFetching = false;

  NotificationsCubit(this.remote) : super(const NotificationsState());

  void startPolling() {
    if (_pollTimer != null) return;
    refresh();
    _pollTimer = Timer.periodic(const Duration(seconds: 30), (_) => refresh());
  }

  Future<void> refresh() async {
    if (_isFetching || isClosed) return;
    _isFetching = true;
    try {
      final results = await Future.wait([
        remote.getUnreadCount(),
        remote.getUnread(),
      ]);
      if (isClosed) return;
      final countResult = results[0] as ApiResult<int>;
      final feedResult = results[1] as ApiResult<List<NotificationEntity>>;
      var count = state.unreadCount;
      var items = state.items;
      String? error;
      if (countResult case ApiSuccess<int>(:final data)) {
        count = data;
      } else if (countResult is ApiFailure<int>) {
        error = countResult.error.message;
      }
      if (feedResult case ApiSuccess<List<NotificationEntity>>(:final data)) {
        items = data;
      } else if (feedResult is ApiFailure<List<NotificationEntity>>) {
        error = feedResult.error.message;
      }
      emit(NotificationsState(unreadCount: count, items: items, error: error));
    } finally {
      _isFetching = false;
    }
  }

  Future<void> markRead(String id) async {
    final result = await remote.markRead(id);
    if (isClosed) return;
    switch (result) {
      case ApiSuccess<void>():
        emit(
          NotificationsState(
            unreadCount: state.unreadCount > 0 ? state.unreadCount - 1 : 0,
            items: state.items.where((item) => item.id != id).toList(),
          ),
        );
        refresh();
      case ApiFailure(:final error):
        emit(
          NotificationsState(
            unreadCount: state.unreadCount,
            items: state.items,
            error: error.message,
          ),
        );
    }
  }

  Future<void> markAllRead() async {
    final result = await remote.markAllRead();
    if (isClosed) return;
    switch (result) {
      case ApiSuccess<void>():
        emit(const NotificationsState());
        refresh();
      case ApiFailure(:final error):
        emit(
          NotificationsState(
            unreadCount: state.unreadCount,
            items: state.items,
            error: error.message,
          ),
        );
    }
  }

  @override
  Future<void> close() {
    _pollTimer?.cancel();
    return super.close();
  }
}
