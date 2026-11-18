import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../../../core/extensions/context_extension.dart';
import '../../../../../../core/extensions/double_extension.dart';
import '../../../../../../core/widgets/common_page_body.dart';
import '../../../../../core/di/injector.dart';
import '../../../../shared/dashboard/presentation/dashboard_cubit.dart';
import 'widgets/notifications_section.dart';
import 'widgets/quick_actions_section.dart';
import 'widgets/recent_transactions_section.dart';
import 'widgets/stats_grid.dart';
import 'widgets/upcoming_appointment_card.dart';
import 'widgets/welcome_banner.dart';

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => getIt<DashboardCubit>()..load(),
    child: const _StudentDashboardView(),
  );
}

class _StudentDashboardView extends StatelessWidget {
  const _StudentDashboardView();

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
          final summary = state.summary;
          final main = Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const WelcomeBanner(),
              if (state.error != null)
                TextButton.icon(
                  onPressed: context.read<DashboardCubit>().load,
                  icon: const Icon(Icons.refresh),
                  label: Text(state.error!),
                ),
              16.0.height,
              StatsGrid(summary: summary),
              20.0.height,
              UpcomingAppointmentCard(total: summary?.upcomingAppointments),
              20.0.height,
              RecentTransactionsSection(total: summary?.recentRecords),
            ],
          );
          final rail = Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const QuickActionsSection(),
              20.0.height,
              const NotificationsSection(),
            ],
          );
          return CommonPageBody(
            child: context.isDesktop
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: main),
                      24.0.width,
                      SizedBox(width: 340, child: rail),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [main, 20.0.height, rail],
                  ),
          );
        },
      );
}
