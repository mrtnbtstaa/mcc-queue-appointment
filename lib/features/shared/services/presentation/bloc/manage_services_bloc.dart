import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../../../core/bloc/debounce.dart';
import '../../../../../../core/errors/failure.dart';
import '../../domain/usecases/create_service.dart';
import '../../domain/usecases/get_service.dart';
import '../../domain/usecases/get_services.dart';
import '../../domain/usecases/update_service.dart';
import '../../domain/usecases/update_service_status.dart';
import 'manage_services_event.dart';
import 'manage_services_state.dart';

class ManageServicesBloc
    extends Bloc<ManageServicesEvent, ManageServicesState> {
  final CreateServiceUseCase _createService;
  final GetServiceUseCase _getService;
  final GetServicesUseCase _getServices;
  final SetServiceStatusUseCase _setServiceStatus;
  final UpdateServiceUseCase _updateService;

  ManageServicesBloc({
    required CreateServiceUseCase createService,
    required GetServiceUseCase getService,
    required GetServicesUseCase getServices,
    required SetServiceStatusUseCase setServiceStatus,
    required UpdateServiceUseCase updateService,
  }) : _createService = createService,
       _getService = getService,
       _getServices = getServices,
       _setServiceStatus = setServiceStatus,
       _updateService = updateService,
       super(const ManageServicesState()) {
    // SERVICE QUERIES

    on<LoadServices>(_onLoadServices, transformer: restartable());
    on<LoadMoreServices>(_onLoadMoreServices, transformer: sequential());

    on<SearchServices>(
      _onSearchServices,
      transformer: debounce(const Duration(milliseconds: 500)),
    );

    on<GetServiceDetails>(_onGetServiceDetails, transformer: restartable());

    // LOCAL FILTERS

    on<SelectServiceCategory>(_onSelectCategory);

    on<SelectServiceStatusFilter>(_onSelectStatusFilter);

    // ALL MUTATIONS SHARE ONE SEQUENTIAL QUEUE

    on<ServiceMutationEvent>(_onServiceMutation, transformer: sequential());
  }

  // ==========================================================
  // LOAD SERVICES
  // ==========================================================

  Future<void> _onLoadServices(
    LoadServices event,
    Emitter<ManageServicesState> emit,
  ) async {
    emit(state.copyWith(status: ServicesStatus.loading, clearError: true));

    await _fetchServices(emit, search: state.searchQuery);
  }

  // ==========================================================
  // SEARCH SERVICES
  // ==========================================================

  Future<void> _onSearchServices(
    SearchServices event,
    Emitter<ManageServicesState> emit,
  ) async {
    emit(
      state.copyWith(
        searchQuery: event.query,
        status: ServicesStatus.loading,
        clearError: true,
      ),
    );

    await _fetchServices(emit, search: event.query);
  }

  // ==========================================================
  // FETCH SERVICES
  // ==========================================================

  Future<void> _fetchServices(
    Emitter<ManageServicesState> emit, {
    String? search,
  }) async {
    try {
      final query = search?.trim();

      final result = await _getServices.callPage(
        search: query == null || query.isEmpty ? null : query,
        page: 1,
      );

      if (emit.isDone) return;

      result.fold(
        (failure) {
          debugPrint('FETCH FAILURE: $failure => ${ServicesStatus.failure}');
          emit(
            state.copyWith(
              status: ServicesStatus.failure,
              errorMessage: failureMessage(failure),
            ),
          );
        },
        (services) {
          debugPrint('FETCH OK: ${services.items.length} services');
          emit(
            state.copyWith(
              allServices: List.unmodifiable(services.items),
              page: services.page,
              totalPages: services.totalPages,
              status: ServicesStatus.success,
              clearError: true,
            ),
          );
        },
      );
    } catch (error, stackTrace) {
      debugPrint('FETCH EXCEPTION: $error\n$stackTrace');
      addError(error, stackTrace);

      if (emit.isDone) return;

      emit(
        state.copyWith(
          status: ServicesStatus.failure,
          errorMessage: 'Unable to load services. Please try again.',
        ),
      );
    }
  }

  Future<void> _onLoadMoreServices(
    LoadMoreServices event,
    Emitter<ManageServicesState> emit,
  ) async {
    if (state.status == ServicesStatus.loading ||
        state.page >= state.totalPages) {
      return;
    }
    emit(state.copyWith(status: ServicesStatus.loading, clearError: true));
    final query = state.searchQuery.trim();
    final result = await _getServices.callPage(
      search: query.isEmpty ? null : query,
      page: state.page + 1,
    );
    if (emit.isDone) return;
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: ServicesStatus.success,
          errorMessage: failureMessage(failure),
        ),
      ),
      (next) => emit(
        state.copyWith(
          allServices: List.unmodifiable([...state.allServices, ...next.items]),
          page: next.page,
          totalPages: next.totalPages,
          status: ServicesStatus.success,
        ),
      ),
    );
  }

  // ==========================================================
  // GET SERVICE DETAILS
  // ==========================================================

  Future<void> _onGetServiceDetails(
    GetServiceDetails event,
    Emitter<ManageServicesState> emit,
  ) async {
    emit(
      state.copyWith(
        detailStatus: DetailStatus.loading,
        clearError: true,
        clearSelectedService: true,
      ),
    );

    try {
      final result = await _getService(event.id);

      if (emit.isDone) return;

      result.fold(
        (failure) {
          emit(
            state.copyWith(
              detailStatus: DetailStatus.failure,
              errorMessage: failureMessage(failure),
            ),
          );
        },
        (service) {
          emit(
            state.copyWith(
              selectedService: service,
              detailStatus: DetailStatus.success,
              clearError: true,
            ),
          );
        },
      );
    } catch (error, stackTrace) {
      addError(error, stackTrace);

      if (emit.isDone) return;

      emit(
        state.copyWith(
          detailStatus: DetailStatus.failure,
          errorMessage: 'Unable to retrieve service details.',
        ),
      );
    }
  }

  // ==========================================================
  // SELECT CATEGORY
  // ==========================================================

  void _onSelectCategory(
    SelectServiceCategory event,
    Emitter<ManageServicesState> emit,
  ) {
    if (state.selectedCategory == event.category) return;

    emit(state.copyWith(selectedCategory: event.category));
  }

  // ==========================================================
  // SELECT STATUS FILTER
  // ==========================================================

  void _onSelectStatusFilter(
    SelectServiceStatusFilter event,
    Emitter<ManageServicesState> emit,
  ) {
    if (state.statusFilter == event.filter) return;

    emit(state.copyWith(statusFilter: event.filter));
  }

  // ==========================================================
  // SERVICE MUTATIONS
  // ==========================================================

  Future<void> _onServiceMutation(
    ServiceMutationEvent event,
    Emitter<ManageServicesState> emit,
  ) async {
    if (event is CreateService) {
      await _executeMutation(() => _createService(event.service), emit);
      return;
    }

    if (event is UpdateService) {
      await _executeMutation(
        () => _updateService(event.id, event.service),
        emit,
      );
      return;
    }

    if (event is ToggleServiceStatus) {
      await _executeMutation(
        () => _setServiceStatus(event.id, event.isActive),
        emit,
      );
    }
  }

  // ==========================================================
  // EXECUTE MUTATION
  // ==========================================================

  Future<void> _executeMutation<T>(
    Future<Either<Failure, T>> Function() action,
    Emitter<ManageServicesState> emit,
  ) async {
    emit(
      state.copyWith(mutationStatus: MutationStatus.loading, clearError: true),
    );

    try {
      final result = await action();

      if (emit.isDone) return;

      var succeeded = false;

      result.fold(
        (failure) {
          emit(
            state.copyWith(
              mutationStatus: MutationStatus.failure,
              errorMessage: failureMessage(failure),
            ),
          );
        },
        (_) {
          succeeded = true;

          emit(
            state.copyWith(
              mutationStatus: MutationStatus.success,
              clearError: true,
            ),
          );
        },
      );

      if (succeeded && !emit.isDone) {
        await _refreshServices(emit);
      }
    } catch (error, stackTrace) {
      addError(error, stackTrace);

      if (emit.isDone) return;

      emit(
        state.copyWith(
          mutationStatus: MutationStatus.failure,
          errorMessage: 'Something went wrong. Please try again.',
        ),
      );
    }
  }

  // ==========================================================
  // REFRESH SERVICES AFTER MUTATION
  // ==========================================================

  Future<void> _refreshServices(Emitter<ManageServicesState> emit) async {
    await _fetchServices(emit, search: state.searchQuery);
  }

  // ==========================================================
  // FAILURE HANDLING
  // ==========================================================
}
