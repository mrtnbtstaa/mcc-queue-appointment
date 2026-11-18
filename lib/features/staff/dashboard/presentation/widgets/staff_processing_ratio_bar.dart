import 'package:material_ui/material_ui.dart';

import '../../../../../../core/extensions/double_extension.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/common_text.dart';

class StaffProcessingRatioBar extends StatelessWidget {
  const StaffProcessingRatioBar({super.key});

  @override
  Widget build(BuildContext context) {
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
              CommonText(
                text: 'Daily Processing Ratio',
                fontColor: TAppColors.textPrimary,
                fontSize: 12.5,
                fontWeight: FontWeight.bold,
              ),
              CommonText(
                text: '48 Inquiries Total',
                fontColor: TAppColors.textMuted,
                fontSize: 11,
              ),
            ],
          ),
          12.0.height,
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Row(
              children: [
                Expanded(
                  flex: 65,
                  child: Container(height: 8, color: TAppColors.statusOpenText),
                ),
                Expanded(
                  flex: 20,
                  child: Container(height: 8, color: TAppColors.queueIcon),
                ),
                Expanded(
                  flex: 15,
                  child: Container(height: 8, color: TAppColors.warningText),
                ),
              ],
            ),
          ),
          10.0.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.circle, size: 8, color: TAppColors.statusOpenText),
                  4.0.width,
                  CommonText(
                    text: 'Completed (65%)',
                    fontColor: TAppColors.textMuted,
                    fontSize: 10.5,
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.circle, size: 8, color: TAppColors.queueIcon),
                  4.0.width,
                  CommonText(
                    text: 'In Progress (20%)',
                    fontColor: TAppColors.textMuted,
                    fontSize: 10.5,
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.circle, size: 8, color: TAppColors.warning),
                  4.0.width,
                  CommonText(
                    text: 'Pending (15%)',
                    fontColor: TAppColors.textMuted,
                    fontSize: 10.5,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
