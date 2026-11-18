import 'package:material_ui/material_ui.dart';

import '../../../../../core/extensions/double_extension.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/common_text.dart';

class AppointmentHeaderStats extends StatelessWidget {
  const AppointmentHeaderStats({super.key, required this.total});

  final int total;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText(
          text: 'REGISTRAR DESK',
          fontSize: 10,
          fontWeight: FontWeight.bold,
          fontColor: TAppColors.textHint,
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: CommonText(
                text: 'Appointments Management',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontColor: TAppColors.textPrimary,
              ),
            ),
            10.0.width,
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: TAppColors.successBg,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 3,
                    backgroundColor: TAppColors.success,
                  ),
                  const SizedBox(width: 6),
                  CommonText(
                    text:
                        '$total ${total == 1 ? 'appointment' : 'appointments'}',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    fontColor: TAppColors.successText,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        CommonText(
          text: 'Review, confirm, cancel, and verify submitted student appointment bookings.',
          fontSize: 12,
          fontColor: TAppColors.textSecondary,
        ),
      ],
    );
  }
}
