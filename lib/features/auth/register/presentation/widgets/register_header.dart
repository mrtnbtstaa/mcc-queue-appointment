import 'package:material_ui/material_ui.dart';

import '../../../../../core/extensions/double_extension.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/common_text.dart';

class RegisterHeader extends StatelessWidget {
  const RegisterHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText(
          text: 'Create your account',
          fontColor: TAppColors.textPrimary,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        6.0.height,
        CommonText(
          text: 'Register with your student details to access appointment and queue services.',
          fontColor: TAppColors.textMuted,
          fontSize: 13,
          height: 1.4,
        ),
        20.0.height,
      ],
    );
  }
}
