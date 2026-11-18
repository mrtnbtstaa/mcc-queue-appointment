import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../../../core/extensions/double_extension.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/common_text.dart';

class StaffHeader extends StatelessWidget {
  const StaffHeader({super.key});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: TAppColors.surface,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: TAppColors.border),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.access_time,
              size: 13,
              color: TAppColors.textMuted,
            ),
            6.0.width,
            CommonText(
              text: DateFormat('MMMM d, yyyy - EEEE, h:mm a')
                  .format(DateTime.now()),
              fontColor: TAppColors.textMuted,
              fontSize: 11,
            ),
          ],
        ),
        14.0.height,
        Row(
          children: [
            const CircleAvatar(
              radius: 26,
              backgroundColor: TAppColors.primary,
              child: Icon(Icons.person, color: TAppColors.surface),
            ),
            12.0.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText(
                    text: 'Staff Dashboard',
                    fontColor: TAppColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 4),
                  CommonText(
                    text: 'Registrar Staff',
                    fontColor: TAppColors.textMuted,
                    fontSize: 11.5,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
