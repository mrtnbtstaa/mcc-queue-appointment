import 'package:material_ui/material_ui.dart';

import '../../../../../../core/extensions/double_extension.dart';
import '../../../../../../core/style/font.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/common_text.dart';

class TransactionHeader extends StatelessWidget {
  const TransactionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText(
          text: 'STUDENT RECORDS ARCHIVE',
          fontSize: TFont.font10,
          fontWeight: FontWeight.bold,
          fontColor: TAppColors.primary,
          letterSpacing: 0.5,
        ),
        2.0.height,
        CommonText(
          text: 'Transaction History',
          fontSize: TFont.font20,
          fontWeight: FontWeight.bold,
          fontColor: TAppColors.textPrimary,
        ),
        4.0.height,
        CommonText(
          text: 'Track all your previous and ongoing registrar requests.',
          fontSize: TFont.font12,
          fontColor: TAppColors.textMuted,
        ),
      ],
    );
  }
}
