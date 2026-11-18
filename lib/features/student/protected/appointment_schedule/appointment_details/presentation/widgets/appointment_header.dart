import 'package:material_ui/material_ui.dart';

import '../../../../../../../core/extensions/double_extension.dart';
import '../../../../../../../core/theme/app_colors.dart';
import '../../../../../../../core/widgets/common_text.dart';

class AppointmentHeader extends StatelessWidget {
  const AppointmentHeader({super.key, required this.onDownload});

  final VoidCallback onDownload;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CommonText(
                  text: 'Appointment Slip',
                  fontColor: TAppColors.textPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                8.0.width,
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: TAppColors.statusOpenBg,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: TAppColors.statusOpenBorder),
                  ),
                  child: CommonText(
                    text: 'Valid',
                    fontColor: TAppColors.statusOpenText,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            4.0.height,
            CommonText(
              text: 'Official Registrar Transaction Pass & Queue Ticket',
              fontColor: TAppColors.textMuted,
              fontSize: 11.5,
            ),
          ],
        ),
        GestureDetector(
          onTap: onDownload,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: TAppColors.surface,
              shape: BoxShape.circle,
              border: Border.all(color: TAppColors.border),
            ),
            child: const Icon(
              Icons.download,
              size: 18,
              color: TAppColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
