import 'package:material_ui/material_ui.dart';

import '../../../../../core/extensions/double_extension.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/common_text.dart';

class LoginErrorBanner extends StatelessWidget {
  final String message;
  final VoidCallback onDismiss;

  const LoginErrorBanner({
    super.key,
    required this.message,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: TAppColors.errorBg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: TAppColors.errorBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.error_outline,
            color: TAppColors.errorIcon,
            size: 18,
          ),
          10.0.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(
                  text: "Authentication Failed",
                  fontColor: TAppColors.errorTitle,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.5,
                ),
                2.0.height,
                CommonText(
                  text: message,
                  fontColor: TAppColors.errorText,
                  fontSize: 11.5,
                  height: 1.35,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onDismiss,
            behavior: HitTestBehavior.opaque,
            child: const Padding(
              padding: EdgeInsets.only(left: 8),
              child: Icon(Icons.close, color: TAppColors.errorIcon, size: 16),
            ),
          ),
        ],
      ),
    );
  }
}
