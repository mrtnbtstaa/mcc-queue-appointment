import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../../../core/router/app_routes.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/common_text.dart';
import '../../../../../../features/shared/dashboard/domain/dashboard_summary.dart';

class StaffTodaysAppointmentsList extends StatelessWidget {
  final DashboardSummary? summary;
  const StaffTodaysAppointmentsList({super.key, required this.summary});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: TAppColors.surface,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: TAppColors.border),
    ),
    child: Row(
      children: [
        const Icon(Icons.calendar_today, color: TAppColors.primary),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText(
                text: "Today's Appointments",
                fontColor: TAppColors.textPrimary,
                fontSize: 13.5,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 4),
              CommonText(
                text: summary == null
                    ? 'Loading...'
                    : '${summary!.todayAppointments} total • ${summary!.confirmedAppointments} confirmed',
                fontColor: TAppColors.textSecondary,
                fontSize: 11,
              ),
            ],
          ),
        ),
        TextButton(
          onPressed: () => context.go(AppRoutes.staffAppointmentsPath),
          child: const Text('View All'),
        ),
      ],
    ),
  );
}
