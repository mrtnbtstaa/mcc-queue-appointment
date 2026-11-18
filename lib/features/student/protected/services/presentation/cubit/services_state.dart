import 'package:equatable/equatable.dart';

import '../../../../../shared/services/domain/entities/service_entity.dart';

class ServicesState extends Equatable {
  final String? selectedCategory;
  final String searchQuery;
  final List<ServiceEntity> services;
  final bool isLoading;
  final String? errorMessage;
  final int page;
  final int totalPages;

  const ServicesState({
    this.selectedCategory,
    this.searchQuery = '',
    this.services = const [],
    this.isLoading = false,
    this.errorMessage,
    this.page = 1,
    this.totalPages = 1,
  });

  ServicesState copyWith({
    String? selectedCategory,
    bool clearCategory = false,
    String? searchQuery,
    List<ServiceEntity>? services,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
    int? page,
    int? totalPages,
  }) {
    return ServicesState(
      selectedCategory: clearCategory
          ? null
          : selectedCategory ?? this.selectedCategory,
      searchQuery: searchQuery ?? this.searchQuery,
      services: services ?? this.services,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      page: page ?? this.page,
      totalPages: totalPages ?? this.totalPages,
    );
  }

  @override
  List<Object?> get props => [
    selectedCategory,
    searchQuery,
    services,
    isLoading,
    errorMessage,
    page,
    totalPages,
  ];
}
