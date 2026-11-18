import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../core/di/injector.dart';
import '../../../../core/extensions/double_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/common_adaptive_grid.dart';
import '../../../../core/widgets/common_page_body.dart';
import '../../../../core/widgets/common_text.dart';
import 'cubit/view_appointments_cubit.dart';
import 'cubit/view_appointments_state.dart';
import 'widgets/appointment_card_item.dart';
import 'widgets/appointment_filter_row.dart';
import 'widgets/appointment_header_stats.dart';

class ViewAppointmentsWrapper extends StatelessWidget {
  const ViewAppointmentsWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ViewAppointmentsCubit>()..load(),
      child: const ViewAppointmentsContent(),
    );
  }
}

class ViewAppointmentsContent extends StatelessWidget {
  const ViewAppointmentsContent({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ViewAppointmentsCubit>();

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification.metrics.extentAfter < 300) cubit.loadMore();
        return false;
      },
      child: CommonPageBody(
        child: BlocListener<ViewAppointmentsCubit, ViewAppointmentsState>(
          listenWhen: (previous, current) =>
              current.errorMessage != null &&
              current.errorMessage != previous.errorMessage,
          listener: (context, state) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          },
          child: BlocBuilder<ViewAppointmentsCubit, ViewAppointmentsState>(
            builder: (context, state) {
              final isInitialLoading =
                  state.appointments.isEmpty &&
                  (state.status == ViewAppointmentsStatus.initial ||
                      state.status == ViewAppointmentsStatus.loading);

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppointmentHeaderStats(total: state.appointments.length),
                  16.0.height,
                  const AppointmentFilterRow(),
                  16.0.height,
                  if (isInitialLoading)
                    const _StatusBox(
                      child: SizedBox(
                        width: 32,
                        height: 32,
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          color: TAppColors.primary,
                        ),
                      ),
                    )
                  else if (state.status == ViewAppointmentsStatus.failure &&
                      state.appointments.isEmpty)
                    _StatusBox(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CommonText(
                            text:
                                state.errorMessage ??
                                'Unable to load appointments.',
                            fontColor: TAppColors.textMuted,
                            fontSize: 13,
                          ),
                          12.0.height,
                          TextButton.icon(
                            onPressed: cubit.load,
                            icon: const Icon(Icons.refresh, size: 18),
                            label: const Text('Retry'),
                          ),
                        ],
                      ),
                    )
                  else ...[
                    if (state.status == ViewAppointmentsStatus.loading) ...[
                      const LinearProgressIndicator(
                        minHeight: 3,
                        color: TAppColors.primary,
                      ),
                      8.0.height,
                    ],
                    if (state.appointments.isEmpty)
                      _StatusBox(
                        child: CommonText(
                          text: 'No appointments match your filter.',
                          fontColor: TAppColors.textMuted,
                          fontSize: 13,
                        ),
                      )
                    else
                      CommonAdaptiveGrid(
                        minItemWidth: 520,
                        maxColumns: 2,
                        children: [
                          for (final appointment in state.appointments)
                            AppointmentCardItem(
                              appointment: appointment,
                              isUpdating: state.updatingId == appointment.id,
                            ),
                        ],
                      ),
                    if (state.status == ViewAppointmentsStatus.loading &&
                        state.appointments.isNotEmpty)
                      const Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(child: CircularProgressIndicator()),
                      ),
                  ],
                  20.0.height,
                ],
              );
            },
          ),
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
