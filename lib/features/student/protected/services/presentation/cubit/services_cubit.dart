import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/errors/failure.dart';
import '../../../../../shared/services/domain/usecases/get_services.dart';
import 'services_state.dart';

class ServicesCubit extends Cubit<ServicesState> {
  ServicesCubit(this._getServices) : super(const ServicesState());

  final GetServicesUseCase _getServices;
  Timer? _searchDebounce;
  int _requestId = 0;

  Future<void> loadServices() => _fetch();

  void changeFilter(int index) {
    if (state.selectedFilterIndex == index) return;
    _searchDebounce?.cancel();
    emit(state.copyWith(selectedFilterIndex: index));
    _fetch();
  }

  void searchServices(String query) {
    emit(state.copyWith(searchQuery: query));
    _searchDebounce?.cancel();
    _requestId++;
    _searchDebounce = Timer(const Duration(milliseconds: 400), () => _fetch());
  }

  Future<void> _fetch() async {
    final requestId = ++_requestId;
    emit(state.copyWith(isLoading: true, clearError: true));

    try {
      final query = state.searchQuery.trim();

      final result = await _getServices.callPage(
        search: query.isEmpty ? null : query,
        category: _categoryFor(state.selectedFilterIndex),
        isActive: true,
        page: 1,
      );

      if (isClosed || requestId != _requestId) return;

      result.fold(
        (failure) => emit(
          state.copyWith(
            isLoading: false,
            errorMessage: failureMessage(failure),
          ),
        ),
        (page) => emit(
          state.copyWith(
            isLoading: false,
            services: page.items,
            page: page.page,
            totalPages: page.totalPages,
            clearError: true,
          ),
        ),
      );
    } catch (_) {
      if (isClosed || requestId != _requestId) return;
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Unable to load services.',
        ),
      );
    }
  }

  Future<void> loadMore() async {
    if (state.isLoading || state.page >= state.totalPages) return;
    final requestId = _requestId;
    emit(state.copyWith(isLoading: true, clearError: true));
    final query = state.searchQuery.trim();
    final result = await _getServices.callPage(
      search: query.isEmpty ? null : query,
      category: _categoryFor(state.selectedFilterIndex),
      isActive: true,
      page: state.page + 1,
    );
    if (isClosed || requestId != _requestId) return;
    result.fold(
      (failure) => emit(
        state.copyWith(isLoading: false, errorMessage: failureMessage(failure)),
      ),
      (next) => emit(
        state.copyWith(
          isLoading: false,
          services: [...state.services, ...next.items],
          page: next.page,
          totalPages: next.totalPages,
        ),
      ),
    );
  }

  String? _categoryFor(int index) => switch (index) {
    1 => 'Enrollment',
    2 => 'Certificates',
    3 => 'Records',
    _ => null,
  };

  @override
  Future<void> close() {
    _searchDebounce?.cancel();
    return super.close();
  }
}
