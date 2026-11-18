import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../../../core/di/injector.dart';
import '../../../../../../core/extensions/context_extension.dart';
import '../../../../../../core/extensions/double_extension.dart';
import '../../../../../../core/widgets/common_page_body.dart';
import '../../../../../../features/shared/dashboard/presentation/dashboard_cubit.dart';
import 'widgets/live_queue_control_card.dart';
import 'widgets/staff_header.dart';
import 'widgets/staff_quick_actions_grid.dart';
import 'widgets/staff_shift_snapshot_grid.dart';
import 'widgets/staff_todays_appointments_list.dart';

class StaffDashoardWrapper extends StatelessWidget {
  const StaffDashoardWrapper({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => getIt<DashboardCubit>()..load(),
    child: const StaffDashboardContent(),
  );
}

class StaffDashboardContent extends StatelessWidget {
  const StaffDashboardContent({super.key});

  @override
  Widget build(
    BuildContext context,
  ) => BlocBuilder<DashboardCubit, DashboardState>(
    builder: (context, state) {
      final summary = state.summary;
      final queue = LiveQueueControlCard(summary: summary);
      final appointments = StaffTodaysAppointmentsList(summary: summary);
      return CommonPageBody(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const StaffHeader(),
            if (state.error != null)
              TextButton.icon(
                onPressed: context.read<DashboardCubit>().load,
                icon: const Icon(Icons.refresh),
                label: Text(state.error!),
              ),
            16.0.height,
            StaffShiftSnapshotGrid(summary: summary),
            16.0.height,
            if (context.isDesktop)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(children: [queue, 16.0.height, appointments]),
                  ),
                  24.0.width,
                  const SizedBox(width: 340, child: StaffQuickActionsGrid()),
                ],
              )
            else
              Column(
                children: [
                  queue,
                  16.0.height,
                  const StaffQuickActionsGrid(),
                  16.0.height,
                  appointments,
                ],
              ),
            20.0.height,
          ],
        ),
      );
    },
  );
}
