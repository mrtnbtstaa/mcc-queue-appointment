import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../data/filter_options_remote_data_source.dart';
import '../domain/filter_options.dart';

class FilterOptionsState {
  final FilterOptions options;
  final bool isLoading;

  const FilterOptionsState({
    this.options = const FilterOptions(),
    this.isLoading = false,
  });
}

class FilterOptionsCubit extends Cubit<FilterOptionsState> {
  final FilterOptionsRemoteDataSource remote;

  FilterOptionsCubit(this.remote)
    : super(const FilterOptionsState(isLoading: true));

  Future<void> load() async {
    final result = await remote.getFilterOptions();
    if (isClosed) return;

    switch (result) {
      case ApiSuccess<FilterOptions>(:final data):
        emit(FilterOptionsState(options: data));
      case ApiFailure():
        emit(FilterOptionsState(options: state.options));
    }
  }
}
