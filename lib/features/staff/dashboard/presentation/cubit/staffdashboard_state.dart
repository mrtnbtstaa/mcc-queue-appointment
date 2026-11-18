import 'package:equatable/equatable.dart';

class StaffDashboardState extends Equatable {
  final String currentServingQueue;
  final String nextQueue;
  final bool isShiftOnline;
  final int completedCount;

  const StaffDashboardState({
    this.currentServingQueue = 'Q012',
    this.nextQueue = 'Q013',
    this.isShiftOnline = true,
    this.completedCount = 31,
  });

  StaffDashboardState copyWith({
    String? currentServingQueue,
    String? nextQueue,
    bool? isShiftOnline,
    int? completedCount,
  }) {
    return StaffDashboardState(
      currentServingQueue: currentServingQueue ?? this.currentServingQueue,
      nextQueue: nextQueue ?? this.nextQueue,
      isShiftOnline: isShiftOnline ?? this.isShiftOnline,
      completedCount: completedCount ?? this.completedCount,
    );
  }

  @override
  List<Object?> get props => [
    currentServingQueue,
    nextQueue,
    isShiftOnline,
    completedCount,
  ];
}
