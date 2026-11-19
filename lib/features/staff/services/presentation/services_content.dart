import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../../../core/extensions/double_extension.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/common_adaptive_grid.dart';
import '../../../../../../core/widgets/common_page_body.dart';
import '../../../../../../core/widgets/common_text.dart';
import '../../../../../../core/widgets/common_empty_state.dart';
import '../../../../core/di/injector.dart';
import '../../../shared/services/presentation/bloc/manage_services_bloc.dart';
import '../../../shared/services/presentation/bloc/manage_services_event.dart';
import '../../../shared/services/presentation/bloc/manage_services_state.dart';
import 'widgets/add_service_bottom_sheet.dart';
import 'widgets/manage_services_header.dart';
import 'widgets/registrar_service_card.dart';
import 'widgets/services_filter_bar.dart';

class StaffServicesWrapper extends StatelessWidget {
  const StaffServicesWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ManageServicesBloc>()..add(LoadServices()),
      child: const ManageServicesContent(),
    );
  }
}

class ManageServicesContent extends StatelessWidget {
  const ManageServicesContent({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ManageServicesBloc>();

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification.metrics.extentAfter < 300) {
          bloc.add(const LoadMoreServices());
        }
        return false;
      },
      child: CommonPageBody(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ManageServicesHeader(
              onAddService: () =>
                  AddRegistrarServiceBottomSheet.showAddServiceModal(context),
            ),
            16.0.height,
            ServicesFilterBar(bloc: bloc),
            16.0.height,
            BlocBuilder<ManageServicesBloc, ManageServicesState>(
              builder: (context, state) {
                final isInitialLoading =
                    state.allServices.isEmpty &&
                    (state.status == ServicesStatus.initial ||
                        state.status == ServicesStatus.loading);

                // Loading indicator while the data is being fetched
                if (isInitialLoading) {
                  return _StatusBox(
                    child: const SizedBox(
                      height: 32,
                      width: 32,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        color: TAppColors.primary,
                      ),
                    ),
                  );
                }

                // Error state with retry
                if (state.status == ServicesStatus.failure &&
                    state.allServices.isEmpty) {
                  return _StatusBox(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CommonText(
                          text:
                              state.errorMessage ?? 'Unable to load services.',
                          fontColor: TAppColors.textMuted,
                          fontSize: 13,
                        ),
                        12.0.height,
                        TextButton.icon(
                          onPressed: () => bloc.add(const LoadServices()),
                          icon: const Icon(Icons.refresh, size: 18),
                          label: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                final services = state.filteredServices;

                if (services.isEmpty) {
                  return const CommonEmptyState(
                    title: 'No services found',
                    message: 'Try changing your search or service filters.',
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Thin progress bar when refreshing or searching with
                    // data already on screen
                    if (state.status == ServicesStatus.loading) ...[
                      const LinearProgressIndicator(
                        minHeight: 3,
                        color: TAppColors.primary,
                      ),
                      8.0.height,
                    ],
                    CommonAdaptiveGrid(
                      minItemWidth: 520,
                      maxColumns: 2,
                      children: [
                        for (final service in services)
                          RegistrarServiceCard(
                            service: service,
                            onToggleStatus: () => bloc.add(
                              ToggleServiceStatus(
                                id: service.id.toString(),
                                isActive: !service.isActive,
                              ),
                            ),
                            onEditDetails: () {
                              // Trigger edit details event or navigation here if needed
                            },
                          ),
                      ],
                    ),
                    if (state.status == ServicesStatus.loading &&
                        state.allServices.isNotEmpty)
                      const Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    if (state.status == ServicesStatus.success &&
                        state.errorMessage != null)
                      TextButton(
                        onPressed: () => bloc.add(const LoadMoreServices()),
                        child: Text(state.errorMessage!),
                      ),
                  ],
                );
              },
            ),
            20.0.height,
          ],
        ),
      ),
    );
  }
}

class _StatusBox extends StatelessWidget {
  const _StatusBox({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: TAppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: TAppColors.border),
      ),
      child: Center(child: child),
    );
  }
}
