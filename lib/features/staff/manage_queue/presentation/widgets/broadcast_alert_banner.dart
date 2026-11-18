import 'package:material_ui/material_ui.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/common_text.dart';

class BroadcastAlertBanner extends StatelessWidget {
  const BroadcastAlertBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: TAppColors.queueIconBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: TAppColors.queueIconBg),
      ),
      child: Row(
        children: [
          const Icon(Icons.campaign, color: TAppColors.queueIcon, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 8,
                  runSpacing: 2,
                  children: [
                    CommonText(
                      text: 'Audio & SMS Broadcast Live',
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      fontColor: TAppColors.queueIcon,
                    ),
                    CommonText(
                      text: 'Just now',
                      fontSize: 10,
                      fontColor: TAppColors.textHint,
                    ),
                  ],
                ),
                SizedBox(height: 2),
                CommonText(
                  text: 'Queue ticket Q012 called to Window 2 via Public Announcement & Student SMS alerts.',
                  fontSize: 11,
                  fontColor: TAppColors.textSecondary,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.close, size: 16, color: TAppColors.textHint),
        ],
      ),
    );
  }
}
