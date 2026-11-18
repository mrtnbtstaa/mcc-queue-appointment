import 'package:material_ui/material_ui.dart';

import '../../../../../../core/extensions/double_extension.dart';
import '../../../../../../core/style/font.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/common_text.dart';

class TransactionPaginationBar extends StatelessWidget {
  const TransactionPaginationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 8,
      runSpacing: 6,
      children: [
        // Previous Button
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: TAppColors.surface,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: TAppColors.border),
          ),
          child: Row(
            children: [
              Icon(Icons.chevron_left, size: 16, color: TAppColors.textHint),
              4.0.width,
              CommonText(
                text: 'Previous',
                fontSize: TFont.font10,
                fontColor: TAppColors.textHint,
              ),
            ],
          ),
        ),
        // Record Counter Info
        CommonText(
          text: 'Showing 4 of 4 records',
          fontSize: TFont.font11,
          fontWeight: FontWeight.bold,
          fontColor: TAppColors.textPrimary,
        ),
        // Next Button
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: TAppColors.surface,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: TAppColors.border),
          ),
          child: Row(
            children: [
              CommonText(
                text: 'Next',
                fontSize: TFont.font10,
                fontColor: TAppColors.textHint,
              ),
              4.0.width,
              Icon(Icons.chevron_right, size: 16, color: TAppColors.textHint),
            ],
          ),
        ),
      ],
    );
  }
}
