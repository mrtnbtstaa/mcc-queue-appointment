import 'package:flutter_bloc/flutter_bloc.dart';

import 'appointment_details_state.dart';

class AppointmentSlipCubit extends Cubit<AppointmentSlipState> {
  AppointmentSlipCubit() : super(const AppointmentSlipState());

  void downloadSlip() {
    emit(state.copyWith(isDownloaded: true));
  }

  void rescheduleAppointment() {
    // Handle reschedule flow
  }

  void cancelTicket() {
    // Handle ticket cancellation
  }

  void viewLiveQueue() {
    // Handle navigation to live queue
  }
}
