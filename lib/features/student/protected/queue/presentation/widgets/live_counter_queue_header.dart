import 'package:material_ui/material_ui.dart';

import '../../../../../../core/extensions/double_extension.dart';
import '../../../../../../core/style/font.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/common_text.dart';

class LiveCounterQueueHeader extends StatelessWidget {
  const LiveCounterQueueHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 8,
      runSpacing: 2,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.format_list_numbered,
              size: 16,
              color: TAppColors.textPrimary,
            ),
            6.0.width,
            CommonText(
              text: 'Live Counter Queue',
              fontSize: TFont.font14,
              fontWeight: FontWeight.bold,
              fontColor: TAppColors.textPrimary,
            ),
          ],
        ),
        CommonText(
          text: 'Window 2 - 5 In queue',
          fontSize: TFont.font11,
          fontColor: TAppColors.textMuted,
        ),
      ],
    );
  }
}
