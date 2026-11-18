import 'package:material_ui/material_ui.dart';

import '../../../../../../../core/theme/app_colors.dart';

class AppointmentHeader extends StatelessWidget {
  const AppointmentHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'REGISTRAR BOOKING',
                style: TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.bold,
                  color: TAppColors.primary,
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'Appointment Schedules',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: TAppColors.textPrimary,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Select a service and date to view available appointment slots.',
                style: TextStyle(fontSize: 12, color: TAppColors.textMuted),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: TAppColors.errorBg,
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.calendar_today_outlined,
              color: TAppColors.primary,
              size: 20,
            ),
            constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
            padding: EdgeInsets.zero,
          ),
        ),
      ],
    );
  }
}
