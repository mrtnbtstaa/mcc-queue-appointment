import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../../../core/errors/failure.dart';
import '../../../transaction_history/domain/usecases/create_transaction.dart';
import '../../domain/entities/queue_entity.dart';
import '../../domain/usecases/get_queues.dart';
import '../../domain/usecases/set_queue_status.dart';
import 'queue_event.dart';
import 'queue_state.dart';

class QueueBloc extends Bloc<QueueEvent, QueueState> {
  final GetQueues getQueues;
  final SetQueueStatus setQueueStatus;
  final CreateTransaction createTransaction;

  Timer? _pollTimer;
  bool _isFetching = false;

  QueueBloc({
    required this.getQueues,
    required this.setQueueStatus,
    required this.createTransaction,
  }) : super(const QueueState()) {
    on<QueueStarted>(_onStarted);
    on<QueueRefreshed>(_onRefreshed);
    on<QueueLoadMoreRequested>(_onLoadMore);
    on<QueueStopped>(_onStopped);
    on<QueueStatusChanged>(_onStatusChanged);
    on<QueueCallRequested>(_onCallRequested);
    on<QueueCallNextRequested>(_onCallNextRequested);
    on<QueueCompleteRequested>(_onCompleteRequested);
    on<QueueSkipRequested>(_onSkipRequested);
  }

  Future<void> _onStarted(QueueStarted event, Emitter<QueueState> emit) async {
    _startPolling();
    await _fetch(emit, showLoading: true);
  }

  Future<void> _onRefreshed(
    QueueRefreshed event,
    Emitter<QueueState> emit,
  ) async {
    await _fetch(emit, showLoading: false);
  }

  Future<void> _onLoadMore(
    QueueLoadMoreRequested event,
    Emitter<QueueState> emit,
  ) async {
    if (_isFetching || state.isLoadingMore || state.page >= state.totalPages) {
      return;
    }
    _isFetching = true;
    emit(state.copyWith(isLoadingMore: true, clearError: true));
    try {
      final result = await getQueues.callPage(page: state.page + 1);
      if (isClosed) return;
      result.fold(
        (failure) => emit(
          state.copyWith(isLoadingMore: false, error: failureMessage(failure)),
        ),
        (next) => emit(
          state.copyWith(
            isLoadingMore: false,
            queues: [
              ...state.queues,
              ...next.items.where(
                (item) => !state.queues.any((old) => old.id == item.id),
              ),
            ],
            page: next.page,
            totalPages: next.totalPages,
          ),
        ),
      );
    } finally {
      _isFetching = false;
    }
  }

  void _onStopped(QueueStopped event, Emitter<QueueState> emit) {
    _pollTimer?.cancel();
    _pollTimer = null;
  }

  void _onStatusChanged(QueueStatusChanged event, Emitter<QueueState> emit) {
    emit(state.copyWith(selectedStatus: event.status));
  }

  Future<void> _onCallRequested(
    QueueCallRequested event,
    Emitter<QueueState> emit,
  ) async {
    final serving = state.currentlyServing;
    String? transactionError;

    if (serving != null && serving.id != event.id) {
      final completed = await _changeStatus(
        serving.id,
        QueueStatus.done.apiValue,
        emit,
      );
      if (!completed) return;
      transactionError = await _createTransaction(serving);
    }

    final called = await _changeStatus(
      event.id,
      QueueStatus.serving.apiValue,
      emit,
    );
    if (!called) {
      await _fetch(emit, showLoading: false);
      _reportTransactionError(transactionError, emit);
      return;
    }

    await _fetch(emit, showLoading: false);
    _reportTransactionError(transactionError, emit);
  }

  Future<void> _onCallNextRequested(
    QueueCallNextRequested event,
    Emitter<QueueState> emit,
  ) async {
    final serving = state.currentlyServing;
    String? transactionError;

    if (serving != null) {
      final completed = await _changeStatus(
        serving.id,
        QueueStatus.done.apiValue,
        emit,
      );
      if (!completed) return;
      transactionError = await _createTransaction(serving);
    }

    final next = state.nextWaiting;
    if (next == null) {
      await _fetch(emit, showLoading: false);
      _reportTransactionError(transactionError, emit);
      return;
    }

    final called = await _changeStatus(
      next.id,
      QueueStatus.serving.apiValue,
      emit,
    );
    if (!called) {
      await _fetch(emit, showLoading: false);
      _reportTransactionError(transactionError, emit);
      return;
    }

    await _fetch(emit, showLoading: false);
    _reportTransactionError(transactionError, emit);
  }

  Future<void> _onCompleteRequested(
    QueueCompleteRequested event,
    Emitter<QueueState> emit,
  ) async {
    final serving = state.currentlyServing;
    if (serving == null) return;

    final completed = await _changeStatus(
      serving.id,
      QueueStatus.done.apiValue,
      emit,
    );
    if (!completed) return;

    await _fetch(emit, showLoading: false);
    _reportTransactionError(await _createTransaction(serving), emit);
  }

  Future<void> _onSkipRequested(
    QueueSkipRequested event,
    Emitter<QueueState> emit,
  ) async {
    final serving = state.currentlyServing ?? state.nextWaiting;
    if (serving == null) return;

    final skipped = await _changeStatus(
      serving.id,
      QueueStatus.skipped.apiValue,
      emit,
    );
    if (!skipped) return;

    await _fetch(emit, showLoading: false);
  }

  Future<void> _fetch(
    Emitter<QueueState> emit, {
    required bool showLoading,
  }) async {
    if (_isFetching) return;
    _isFetching = true;
    if (showLoading) {
      emit(state.copyWith(isLoading: true, clearError: true));
    }

    try {
      final result = await getQueues.callPage(page: 1);
      if (isClosed) return;

      result.fold(
        (failure) => emit(
          state.copyWith(isLoading: false, error: failureMessage(failure)),
        ),
        (firstPage) => emit(
          state.copyWith(
            isLoading: false,
            clearError: true,
            queues: state.page > 1
                ? [
                    ...firstPage.items,
                    ...state.queues.where(
                      (old) =>
                          !firstPage.items.any((item) => item.id == old.id),
                    ),
                  ]
                : firstPage.items,
            totalPages: firstPage.totalPages,
          ),
        ),
      );
    } finally {
      _isFetching = false;
    }
  }

  Future<bool> _changeStatus(
    String id,
    String status,
    Emitter<QueueState> emit,
  ) async {
    emit(state.copyWith(isUpdating: true, clearError: true));

    final result = await setQueueStatus(
      SetQueueStatusParams(id: id, status: status),
    );
    if (isClosed) return false;

    return result.fold(
      (failure) {
        emit(state.copyWith(isUpdating: false, error: failureMessage(failure)));
        return false;
      },
      (_) {
        emit(state.copyWith(isUpdating: false));
        return true;
      },
    );
  }

  Future<String?> _createTransaction(QueueItemModel queue) async {
    final result = await createTransaction(
      CreateTransactionParams(
        appointment: queue.appointment,
        remarks: 'Queue completed.',
      ),
    );
    return result.fold((failure) => failureMessage(failure), (_) => null);
  }

  void _reportTransactionError(String? error, Emitter<QueueState> emit) {
    if (error != null && !isClosed) emit(state.copyWith(error: error));
  }

  void _startPolling() {
    _pollTimer?.cancel();
    // shortcut: 10-second polling; switch to websocket/SSE push when available.
    _pollTimer = Timer.periodic(
      const Duration(seconds: 10),
      (_) => add(const QueueRefreshed()),
    );
  }

  @override
  Future<void> close() {
    _pollTimer?.cancel();
    return super.close();
  }
}
