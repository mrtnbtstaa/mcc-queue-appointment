import 'package:material_ui/material_ui.dart';

import '../../../../../../core/extensions/double_extension.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/common_adaptive_grid.dart';
import '../../../../../../core/widgets/common_text.dart';
import '../../../../../../features/shared/dashboard/domain/dashboard_summary.dart';

class StaffShiftSnapshotGrid extends StatelessWidget {
  const StaffShiftSnapshotGrid({super.key, required this.summary});

  final DashboardSummary? summary;

  @override
  Widget build(BuildContext context) {
    final change = summary?.changeVsYesterday ?? 0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 8,
          runSpacing: 4,
          children: [
            CommonText(
              text: 'Shift Snapshot',
              fontColor: TAppColors.textPrimary,
              fontSize: 13.5,
              fontWeight: FontWeight.bold,
            ),
            CommonText(
              text: 'Current snapshot',
              fontColor: TAppColors.textMuted,
              fontSize: 11,
            ),
          ],
        ),
        12.0.height,
        CommonAdaptiveGrid(
          minItemWidth: 170,
          maxColumns: 4,
          spacing: 12,
          children: [
            _statCard(
              icon: Icons.calendar_today,
              iconColor: TAppColors.primary,
              badge: change == 0
                  ? ''
                  : '${change > 0 ? '+' : ''}$change vs ystd',
              badgeColor: TAppColors.statusOpenText,
              badgeBg: TAppColors.statusOpenBg,
              value: summary == null ? '-' : '${summary!.todayAppointments}',
              label: "Today's Appointments",
              detail: summary == null
                  ? '-'
                  : '${summary!.confirmedAppointments} Confirmed',
              detailColor: TAppColors.statusOpenText,
            ),
            _statCard(
              icon: Icons.people_outline,
              iconColor: TAppColors.queueIcon,
              badge: '',
              badgeColor: TAppColors.textMuted,
              badgeBg: Colors.transparent,
              value: summary == null
                  ? '-'
                  : '${summary!.waitingStudents} Students',
              label: 'Currently Waiting',
              detail: summary == null
                  ? '-'
                  : 'Avg. ${summary!.averageWaitMinutes} min wait',
              detailColor: TAppColors.textSecondary,
            ),
            _statCard(
              icon: Icons.desktop_windows,
              iconColor: TAppColors.primary,
              badge: summary?.nowServing == null ? '' : 'ACTIVE',
              badgeColor: TAppColors.statusOpenText,
              badgeBg: Colors.transparent,
              value: summary?.nowServing?['queue_number']?.toString() ?? 'None',
              label: 'Now Serving',
              detail:
                  summary?.nowServing?['service_name']?.toString() ??
                  'No one is being served',
              detailColor: TAppColors.primary,
            ),
            _statCard(
              icon: Icons.check_circle_outlined,
              iconColor: TAppColors.statusOpenText,
              badge: '${summary?.completionRate ?? 0}%',
              badgeColor: TAppColors.textSecondary,
              badgeBg: Colors.transparent,
              value: summary == null
                  ? '-'
                  : '${summary!.completedTransactions}',
              label: 'Completed Today',
              detail: 'Transactions finished',
              detailColor: TAppColors.textSecondary,
            ),
          ],
        ),
      ],
    );
  }

  Widget _statCard({
    required IconData icon,
    required Color iconColor,
    required String badge,
    required Color badgeColor,
    required Color badgeBg,
    required String value,
    required String label,
    required String detail,
    required Color detailColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: TAppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: TAppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, size: 16, color: iconColor),
              if (badge.isNotEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: badgeBg,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: CommonText(
                    text: badge,
                    fontColor: badgeColor,
                    fontSize: 9.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
          10.0.height,
          CommonText(
            text: value,
            fontColor: TAppColors.textPrimary,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            maxLine: 1,
            textOverFlow: TextOverflow.ellipsis,
          ),
          2.0.height,
          CommonText(
            text: label,
            fontColor: TAppColors.textMuted,
            fontSize: 11,
          ),
          4.0.height,
          CommonText(
            text: detail,
            fontColor: detailColor,
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }
}
