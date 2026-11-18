import 'package:equatable/equatable.dart';

sealed class QueueEvent extends Equatable {
  const QueueEvent();

  @override
  List<Object?> get props => [];
}

final class QueueStarted extends QueueEvent {
  const QueueStarted();
}

final class QueueRefreshed extends QueueEvent {
  const QueueRefreshed();
}

final class QueueLoadMoreRequested extends QueueEvent {
  const QueueLoadMoreRequested();
}

final class QueueStopped extends QueueEvent {
  const QueueStopped();
}

final class QueueStatusChanged extends QueueEvent {
  final String status;

  const QueueStatusChanged(this.status);

  @override
  List<Object?> get props => [status];
}

final class QueueCallRequested extends QueueEvent {
  final String id;

  const QueueCallRequested(this.id);

  @override
  List<Object?> get props => [id];
}

final class QueueCallNextRequested extends QueueEvent {
  const QueueCallNextRequested();
}

final class QueueCompleteRequested extends QueueEvent {
  const QueueCompleteRequested();
}

final class QueueSkipRequested extends QueueEvent {
  const QueueSkipRequested();
}
