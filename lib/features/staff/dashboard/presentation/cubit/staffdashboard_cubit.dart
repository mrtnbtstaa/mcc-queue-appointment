import 'package:flutter_bloc/flutter_bloc.dart';

import 'staffdashboard_state.dart';

class StaffDashboardCubit extends Cubit<StaffDashboardState> {
  StaffDashboardCubit() : super(const StaffDashboardState());

  void toggleShiftStatus(bool online) {
    emit(state.copyWith(isShiftOnline: online));
  }

  void callNextStudent() {
    // Advance queue logic
    emit(
      state.copyWith(
        currentServingQueue: state.nextQueue,
        nextQueue: 'Q014',
        completedCount: state.completedCount + 1,
      ),
    );
  }

  void recallStudent() {
    // Logic for recalling current ticket
  }

  void completeTicket() {
    // Logic for finishing current serving ticket
  }
}
