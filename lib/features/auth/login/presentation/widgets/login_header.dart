import 'package:material_ui/material_ui.dart';

import '../../../../../core/extensions/double_extension.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/common_text.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.waving_hand_rounded,
              color: TAppColors.primary,
              size: 22,
            ),
            8.0.width,
            CommonText(
              text: 'Welcome back',
              fontColor: TAppColors.textPrimary,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
        6.0.height,
        CommonText(
          text: 'Log in to your student account to manage appointments and queue tickets.',
          fontColor: TAppColors.textMuted,
          fontSize: 13,
          height: 1.4,
          alignment: TextAlign.center,
        ),
        16.0.height,
      ],
    );
  }
}
