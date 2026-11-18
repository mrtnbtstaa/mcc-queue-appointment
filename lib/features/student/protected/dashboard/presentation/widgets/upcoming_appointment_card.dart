import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../../../core/router/app_routes.dart';
import '../../../../../../core/theme/app_colors.dart';

class UpcomingAppointmentCard extends StatelessWidget {
  final int? total;
  const UpcomingAppointmentCard({super.key, this.total});

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Upcoming Appointments',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: TAppColors.textPrimary,
            ),
          ),
          TextButton(
            onPressed: () => context.go(AppRoutes.appointmentsPath),
            child: const Text('View All'),
          ),
        ],
      ),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
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
        child: Row(
          children: [
            const Icon(
              Icons.calendar_month,
              color: TAppColors.primary,
              size: 24,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                total == null
                    ? 'Loading appointment summary...'
                    : '$total upcoming appointments',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: TAppColors.textPrimary,
                ),
              ),
            ),
            const Icon(Icons.chevron_right, color: TAppColors.textMuted),
          ],
        ),
      ),
    ],
  );
}
