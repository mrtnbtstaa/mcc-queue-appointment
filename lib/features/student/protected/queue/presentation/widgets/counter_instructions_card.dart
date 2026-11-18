import 'package:material_ui/material_ui.dart';

import '../../../../../../core/style/font.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/common_text.dart';

class CounterInstructionsCard extends StatelessWidget {
  const CounterInstructionsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: TAppColors.successBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: TAppColors.successBorder.withValues(alpha: 0.5),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.campaign_outlined,
            color: TAppColors.successText,
            size: 18,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(
                  text: 'Counter Instructions',
                  fontSize: TFont.font12,
                  fontWeight: FontWeight.bold,
                  fontColor: TAppColors.successText,
                ),
                SizedBox(height: 2),
                CommonText(
                  text: 'When your number is called, please proceed directly to Window 2 with your valid MCC Student ID and transaction slip ready.',
                  fontSize: TFont.font12,
                  fontColor: TAppColors.successText,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
