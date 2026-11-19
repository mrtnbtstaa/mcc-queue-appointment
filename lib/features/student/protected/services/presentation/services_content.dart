import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../../../core/extensions/double_extension.dart';
import '../../../../../../core/widgets/common_adaptive_grid.dart';
import '../../../../../../core/widgets/common_empty_state.dart';
import '../../../../../../core/widgets/common_page_body.dart';
import '../../../../../../core/widgets/common_responsive_modal.dart';
import '../../../../../core/di/injector.dart';
import '../../../../../core/router/app_routes.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../shared/services/domain/entities/service_entity.dart';
import '../../../../shared/services/domain/usecases/get_services.dart';
import 'cubit/services_cubit.dart';
import 'cubit/services_state.dart';
import 'widgets/portal_status_banner.dart';
import 'widgets/search_and_filter_bar.dart';
import 'widgets/service_card.dart';

class ServicesWrapper extends StatelessWidget {
  const ServicesWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ServicesCubit(getIt<GetServicesUseCase>())..loadServices(),
      child: const ServicesContent(),
    );
  }
}

class ServicesContent extends StatelessWidget {
  const ServicesContent({super.key});

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification.metrics.extentAfter < 300) {
          context.read<ServicesCubit>().loadMore();
        }
        return false;
      },
      child: CommonPageBody(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const PortalStatusBanner(),
            16.0.height,
            BlocBuilder<ServicesCubit, ServicesState>(
              builder: (context, state) {
                return SearchAndFilterBar(
                  selectedCategory: state.selectedCategory,
                  onFilterChanged: (category) =>
                      context.read<ServicesCubit>().changeFilter(category),
                  onSearchChanged: (query) =>
                      context.read<ServicesCubit>().searchServices(query),
                );
              },
            ),
            16.0.height,
            // const PriorityCounterNotice(),
            16.0.height,
            BlocBuilder<ServicesCubit, ServicesState>(
              builder: (context, state) {
                if (state.isLoading && state.services.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 32),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                if (state.errorMessage != null && state.services.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Column(
                      children: [
                        Text(
                          state.errorMessage!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 13,
                            color: TAppColors.textMuted,
                          ),
                        ),
                        8.0.height,
                        TextButton(
                          onPressed: () =>
                              context.read<ServicesCubit>().loadServices(),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                if (state.services.isEmpty) {
                  return const CommonEmptyState(
                    title: 'No services found',
                    message: 'Try changing your search or selected category.',
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (state.isLoading) ...[
                      const LinearProgressIndicator(minHeight: 2),
                      8.0.height,
                    ],
                    CommonAdaptiveGrid(
                      minItemWidth: 320,
                      maxColumns: 3,
                      children: [
                        for (final service in state.services)
                          ServiceCard(
                            service: service,
                            onViewChecklist: () =>
                                _showChecklist(context, service),
                            onBookAppointment: () =>
                                context.go(AppRoutes.appointmentsPath),
                          ),
                      ],
                    ),
                    if (state.errorMessage != null)
                      TextButton(
                        onPressed: context.read<ServicesCubit>().loadMore,
                        child: Text(state.errorMessage!),
                      ),
                  ],
                );
              },
            ),
            16.0.height,
          ],
        ),
      ),
    );
  }

  void _showChecklist(BuildContext context, ServiceEntity service) {
    CommonResponsiveModal.show<void>(
      context: context,
      isScrollControlled: false,
      showDragHandle: true,
      builder: (_) => SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                service.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: TAppColors.textPrimary,
                ),
              ),
              12.0.height,
              if (service.requiredDocuments.isEmpty)
                const Text(
                  'No documents required.',
                  style: TextStyle(fontSize: 13, color: TAppColors.textMuted),
                )
              else
                ...service.requiredDocuments.map(
                  (document) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.check_circle_outline,
                          size: 16,
                          color: TAppColors.primary,
                        ),
                        8.0.width,
                        Expanded(
                          child: Text(
                            document,
                            style: const TextStyle(fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
