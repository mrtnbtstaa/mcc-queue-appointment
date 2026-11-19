import 'package:material_ui/material_ui.dart';

import '../theme/app_colors.dart';

class CommonEmptyState extends StatelessWidget {
  const CommonEmptyState({
    super.key,
    required this.title,
    required this.message,
    this.actionLabel,
    this.onAction,
    this.illustrationHeight = 160,
  });

  final String title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;
  final double illustrationHeight;

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/illustrations/no_data_rafiki.png',
            height: illustrationHeight,
            fit: BoxFit.contain,
            semanticLabel: 'Illustration for an empty list',
          ),
          const SizedBox(height: 12),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: TAppColors.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: TAppColors.textSecondary,
                fontSize: 13,
                height: 1.4,
              ),
            ),
          ),
          if (actionLabel != null && onAction != null) ...[
            const SizedBox(height: 12),
            TextButton(onPressed: onAction, child: Text(actionLabel!)),
          ],
          const SizedBox(height: 8),
          const Text(
            'Illustration by Storyset · storyset.com',
            textAlign: TextAlign.center,
            style: TextStyle(color: TAppColors.textHint, fontSize: 10),
          ),
        ],
      ),
    ),
  );
}
