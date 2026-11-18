import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../../../core/router/app_routes.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/common_adaptive_grid.dart';
import '../../../../../../features/shared/dashboard/domain/dashboard_summary.dart';

class StatsGrid extends StatelessWidget {
  final DashboardSummary? summary;
  const StatsGrid({super.key, this.summary});

  @override
  Widget build(BuildContext context) {
    return CommonAdaptiveGrid(
      minItemWidth: 170,
      maxColumns: 4,
      children: [
        _buildStatCard(
          context,
          icon: Icons.calendar_month,
          iconColor: TAppColors.errorIcon,
          title: 'Upcoming',
          value: summary == null ? '-' : '${summary!.upcomingAppointments}',
          subtitle: 'Appointments',
          actionText: 'View Schedule',
          route: AppRoutes.appointmentsPath,
        ),
        _buildStatCard(
          context,
          icon: Icons.confirmation_number,
          iconColor: TAppColors.queueIcon,
          title: 'Queue',
          value: summary?.queueNumber ?? '-',
          subtitle: summary == null
              ? '-'
              : summary!.queueStatusDisplay == null
              ? 'Queue Status'
              : summary!.queuePosition > 0
              ? '${summary!.queueStatusDisplay} - Position ${summary!.queuePosition}'
              : summary!.queueStatusDisplay!,
          actionText: 'View Queue',
          route: AppRoutes.queuePath,
        ),
        _buildStatCard(
          context,
          icon: Icons.description,
          iconColor: TAppColors.success,
          title: 'Recent',
          value: summary == null ? '-' : '${summary!.recentRecords}',
          subtitle: 'Total Records',
          actionText: 'View History',
          route: AppRoutes.historyPath,
        ),
        _buildStatCard(
          context,
          icon: Icons.grid_view,
          iconColor: TAppColors.primary,
          title: 'Catalog',
          value: summary == null ? '-' : '${summary!.activeOptions}',
          subtitle: 'Active Options',
          actionText: 'View Services',
          route: AppRoutes.servicesPath,
        ),
      ],
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String title,
    required String value,
    required String subtitle,
    required String actionText,
    required String route,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: TAppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, size: 18, color: iconColor),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 11,
                  color: TAppColors.textMuted,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Flexible(
                child: Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: TAppColors.textPrimary,
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 10.5,
                    color: TAppColors.textMuted,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () => context.go(route),
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    actionText,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: TAppColors.primary,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.arrow_forward,
                  size: 11,
                  color: TAppColors.primary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
