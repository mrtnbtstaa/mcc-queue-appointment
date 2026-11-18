import 'package:material_ui/material_ui.dart';

import '../../../../../core/extensions/double_extension.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/common_text.dart';

class PasswordStrengthIndicator extends StatelessWidget {
  final double score; // 0.33, 0.66, 1.0
  final String strengthText;

  const PasswordStrengthIndicator({
    super.key,
    required this.score,
    required this.strengthText,
  });

  @override
  Widget build(BuildContext context) {
    Color barColor = TAppColors.success; // Green
    if (score <= 0.33) {
      barColor = TAppColors.errorIcon; // Red
    } else if (score <= 0.66) {
      barColor = TAppColors.warning; // Orange
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                height: 4,
                decoration: BoxDecoration(
                  color: score >= 0.33 ? barColor : TAppColors.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            6.0.width,
            Expanded(
              child: Container(
                height: 4,
                decoration: BoxDecoration(
                  color: score >= 0.66 ? barColor : TAppColors.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            6.0.width,
            Expanded(
              child: Container(
                height: 4,
                decoration: BoxDecoration(
                  color: score >= 1.0 ? barColor : TAppColors.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ],
        ),
        6.0.height,
        Row(
          children: [
            Icon(Icons.verified_user_outlined, size: 13, color: barColor),
            4.0.width,
            Expanded(
              child: CommonText(
                text: strengthText,
                fontColor: barColor,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
