import 'package:material_ui/material_ui.dart';

import '../../../../../../core/extensions/double_extension.dart';
import '../../../../../../core/style/font.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/common_circle_avatar.dart';
import '../../../../../../core/widgets/common_text.dart';

class TransactionDetailHeader extends StatelessWidget {
  final VoidCallback onClose;

  const TransactionDetailHeader({super.key, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const CommonCircleAvatar(
              radius: 16,
              backgroundColor: TAppColors.errorBg,
              child: Icon(
                Icons.assignment_outlined,
                size: 16,
                color: TAppColors.primary,
              ),
            ),
            10.0.width,
            CommonText(
              text: 'Transaction Detail',
              fontSize: TFont.font16,
              fontWeight: FontWeight.bold,
              fontColor: TAppColors.textPrimary,
            ),
          ],
        ),
        IconButton(
          onPressed: onClose,
          icon: const Icon(Icons.close, size: 18, color: TAppColors.textMuted),
          constraints: const BoxConstraints(),
          padding: EdgeInsets.zero,
        ),
      ],
    );
  }
}
