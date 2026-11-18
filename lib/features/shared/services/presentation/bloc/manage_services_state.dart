import 'package:equatable/equatable.dart';

import '../../domain/entities/service_entity.dart';

enum ServiceStatusFilter { all, activeOnly, inactive }

enum ServicesStatus { initial, loading, success, failure }

enum MutationStatus { initial, loading, success, failure }

enum DetailStatus { initial, loading, success, failure }

class ManageServicesState extends Equatable {
  final List<ServiceEntity> allServices;

  final String selectedCategory;
  final ServiceStatusFilter statusFilter;
  final String searchQuery;

  final ServicesStatus status;
  final MutationStatus mutationStatus;
  final DetailStatus detailStatus;

  final ServiceEntity? selectedService;

  final String? errorMessage;
  final int page;
  final int totalPages;

  const ManageServicesState({
    this.allServices = const [],
    this.selectedCategory = 'All',
    this.statusFilter = ServiceStatusFilter.all,
    this.searchQuery = '',
    this.status = ServicesStatus.initial,
    this.mutationStatus = MutationStatus.initial,
    this.detailStatus = DetailStatus.initial,
    this.selectedService,
    this.errorMessage,
    this.page = 1,
    this.totalPages = 1,
  });

  // --------------------------------------------------
  // FILTERED SERVICES
  // --------------------------------------------------

  List<ServiceEntity> get filteredServices {
    final query = searchQuery.trim().toLowerCase();

    return allServices.where((service) {
      final matchesCategory =
          selectedCategory == 'All' || service.category == selectedCategory;

      final matchesStatus = switch (statusFilter) {
        ServiceStatusFilter.all => true,
        ServiceStatusFilter.activeOnly => service.isActive,
        ServiceStatusFilter.inactive => !service.isActive,
      };

      final matchesQuery =
          query.isEmpty ||
          service.name.toLowerCase().contains(query) ||
          service.category.toLowerCase().contains(query);

      return matchesCategory && matchesStatus && matchesQuery;
    }).toList();
  }

  // --------------------------------------------------
  // COPY WITH
  // --------------------------------------------------

  ManageServicesState copyWith({
    List<ServiceEntity>? allServices,
    String? selectedCategory,
    ServiceStatusFilter? statusFilter,
    String? searchQuery,
    ServicesStatus? status,
    MutationStatus? mutationStatus,
    DetailStatus? detailStatus,
    ServiceEntity? selectedService,
    String? errorMessage,
    bool clearError = false,
    bool clearSelectedService = false,
    int? page,
    int? totalPages,
  }) {
    return ManageServicesState(
      allServices: allServices ?? this.allServices,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      statusFilter: statusFilter ?? this.statusFilter,
      searchQuery: searchQuery ?? this.searchQuery,
      status: status ?? this.status,
      mutationStatus: mutationStatus ?? this.mutationStatus,
      detailStatus: detailStatus ?? this.detailStatus,
      selectedService: clearSelectedService
          ? null
          : selectedService ?? this.selectedService,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      page: page ?? this.page,
      totalPages: totalPages ?? this.totalPages,
    );
  }

  @override
  List<Object?> get props => [
    allServices,
    selectedCategory,
    statusFilter,
    searchQuery,
    status,
    mutationStatus,
    detailStatus,
    selectedService,
    errorMessage,
    page,
    totalPages,
  ];
}
