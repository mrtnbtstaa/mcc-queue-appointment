import 'package:material_ui/material_ui.dart';

import '../../../../../core/extensions/double_extension.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/common_elevated_button.dart';
import '../../../../../core/widgets/common_text.dart';

class FreshmenActivationCard extends StatelessWidget {
  final VoidCallback onCreateAccount;

  const FreshmenActivationCard({super.key, required this.onCreateAccount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: TAppColors.promoBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: TAppColors.promoBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.person_add_alt_1_outlined,
                color: TAppColors.errorTitle,
                size: 18,
              ),
              8.0.width,
              Expanded(
                child: CommonText(
                  text: "First Time Student or Freshmen?",
                  fontColor: TAppColors.textPrimary,
                  fontSize: 12.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          6.0.height,
          CommonText(
            text: "Don't have an account yet? Create one to get started.",
            fontColor: TAppColors.textMuted,
            fontSize: 11.5,
            height: 1.35,
          ),
          12.0.height,
          CommonElevatedButton(
            onButtonPressed: onCreateAccount,
            backgroundColor: TAppColors.surface,
            borderColor: TAppColors.primary.withValues(alpha: 0.3),
            borderWidth: 1.0,
            borderRadius: 8.0,
            elevatedPadding: const EdgeInsets.symmetric(vertical: 11),
            custom: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CommonText(
                  text: "Create an Account",
                  fontColor: TAppColors.primary,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                ),
                6.0.width,
                Icon(Icons.arrow_forward, size: 14, color: TAppColors.primary),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
