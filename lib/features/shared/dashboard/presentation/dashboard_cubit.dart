import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../data/dashboard_remote_data_source.dart';
import '../domain/dashboard_summary.dart';

class DashboardState {
  final DashboardSummary? summary;
  final bool isLoading;
  final String? error;

  const DashboardState({this.summary, this.isLoading = false, this.error});
}

class DashboardCubit extends Cubit<DashboardState> {
  final DashboardRemoteDataSource remote;

  DashboardCubit(this.remote) : super(const DashboardState(isLoading: true));

  Future<void> load() async {
    emit(DashboardState(summary: state.summary, isLoading: true));
    final result = await remote.getSummary();
    if (isClosed) return;
    switch (result) {
      case ApiSuccess<DashboardSummary>(:final data):
        emit(DashboardState(summary: data));
      case ApiFailure(:final error):
        emit(DashboardState(summary: state.summary, error: error.message));
    }
  }
}
