import 'package:material_ui/material_ui.dart';

import '../../../../../../core/extensions/double_extension.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/common_text.dart';

class OfficialAccessBanner extends StatelessWidget {
  const OfficialAccessBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: TAppColors.errorBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: TAppColors.errorBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.admin_panel_settings,
            color: TAppColors.primary,
            size: 20,
          ),
          10.0.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(
                  text: 'OFFICIAL ACCESS',
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  fontColor: TAppColors.primary,
                ),
                2.0.height,
                CommonText(
                  text: 'Student records are loaded from the official account directory.',
                  fontSize: 11,
                  fontColor: TAppColors.textSecondary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
