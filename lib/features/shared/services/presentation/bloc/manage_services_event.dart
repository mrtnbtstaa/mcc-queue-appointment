import 'package:equatable/equatable.dart';

import '../../domain/entities/service_entity.dart';
import 'manage_services_state.dart';

sealed class ManageServicesEvent extends Equatable {
  const ManageServicesEvent();

  @override
  List<Object?> get props => [];
}

// --------------------------------------------------
// SERVICE QUERIES
// --------------------------------------------------

final class LoadServices extends ManageServicesEvent {
  const LoadServices();
}

final class LoadMoreServices extends ManageServicesEvent {
  const LoadMoreServices();
}

final class SearchServices extends ManageServicesEvent {
  final String query;

  const SearchServices(this.query);

  @override
  List<Object?> get props => [query];
}

final class GetServiceDetails extends ManageServicesEvent {
  final String id;

  const GetServiceDetails(this.id);

  @override
  List<Object?> get props => [id];
}

// --------------------------------------------------
// LOCAL FILTERS
// --------------------------------------------------

final class SelectServiceCategory extends ManageServicesEvent {
  final String category;

  const SelectServiceCategory(this.category);

  @override
  List<Object?> get props => [category];
}

final class SelectServiceStatusFilter extends ManageServicesEvent {
  final ServiceStatusFilter filter;

  const SelectServiceStatusFilter(this.filter);

  @override
  List<Object?> get props => [filter];
}

// --------------------------------------------------
// SERVICE MUTATIONS
// --------------------------------------------------

sealed class ServiceMutationEvent extends ManageServicesEvent {
  const ServiceMutationEvent();
}

final class CreateService extends ServiceMutationEvent {
  final ServiceEntity service;

  const CreateService(this.service);

  @override
  List<Object?> get props => [service];
}

final class UpdateService extends ServiceMutationEvent {
  final String id;
  final ServiceEntity service;

  const UpdateService({required this.id, required this.service});

  @override
  List<Object?> get props => [id, service];
}

final class ToggleServiceStatus extends ServiceMutationEvent {
  final String id;
  final bool isActive;

  const ToggleServiceStatus({required this.id, required this.isActive});

  @override
  List<Object?> get props => [id, isActive];
}
