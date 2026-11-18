import 'package:equatable/equatable.dart';

import '../../domain/entities/queue_entity.dart';

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

final class QueueTabChanged extends QueueEvent {
  final QueueTab tab;

  const QueueTabChanged(this.tab);

  @override
  List<Object?> get props => [tab];
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
