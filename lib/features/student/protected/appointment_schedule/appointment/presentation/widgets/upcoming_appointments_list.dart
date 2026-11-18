import 'package:material_ui/material_ui.dart';

import '../../../../../../../core/theme/app_colors.dart';

class UpcomingAppointmentsList extends StatelessWidget {
  const UpcomingAppointmentsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 8,
          runSpacing: 2,
          children: [
            Text(
              'Upcoming Appointments',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: TAppColors.textPrimary,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: TAppColors.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '1 Active',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: TAppColors.surface,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: TAppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: const Border(
              left: BorderSide(color: TAppColors.primary, width: 4),
            ),
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
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'CONFIRMED SCHEDULE',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: TAppColors.primary,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: TAppColors.successBg,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.check,
                          size: 10,
                          color: TAppColors.successText,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Confirmed',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: TAppColors.successText,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              const Text(
                'Enrollment Verification (Window 2)',
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.bold,
                  color: TAppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 2),
              const Text(
                'Reference #MCC-2026-8941',
                style: TextStyle(fontSize: 11, color: TAppColors.textMuted),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Divider(height: 1, color: TAppColors.background),
              ),
              Wrap(
                spacing: 16,
                runSpacing: 4,
                children: const [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 12,
                        color: TAppColors.textMuted,
                      ),
                      SizedBox(width: 6),
                      Text(
                        'Saturday, Oct 3, 2026',
                        style: TextStyle(
                          fontSize: 11,
                          color: TAppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 12,
                        color: TAppColors.textMuted,
                      ),
                      SizedBox(width: 6),
                      Text(
                        '09:00 AM – 10:00 AM',
                        style: TextStyle(
                          fontSize: 11,
                          color: TAppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Wrap(
                spacing: 24,
                runSpacing: 4,
                children: const [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.person_outline,
                        size: 12,
                        color: TAppColors.textMuted,
                      ),
                      SizedBox(width: 6),
                      Text(
                        'Juan Dela Cruz',
                        style: TextStyle(
                          fontSize: 11,
                          color: TAppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.badge_outlined,
                        size: 12,
                        color: TAppColors.textMuted,
                      ),
                      SizedBox(width: 6),
                      Text(
                        'SN: 2024-00192',
                        style: TextStyle(
                          fontSize: 11,
                          color: TAppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Divider(height: 1, color: TAppColors.background),
              ),
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                spacing: 16,
                runSpacing: 8,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(
                          Icons.download,
                          size: 14,
                          color: TAppColors.primary,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Download Gate Pass',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: TAppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(
                          Icons.close,
                          size: 14,
                          color: TAppColors.errorIcon,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Cancel Schedule',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: TAppColors.errorIcon,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
