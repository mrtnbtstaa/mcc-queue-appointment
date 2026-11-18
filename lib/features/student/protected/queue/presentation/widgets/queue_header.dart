import 'package:material_ui/material_ui.dart';

import '../../../../../../core/extensions/double_extension.dart';
import '../../../../../../core/style/font.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/common_circle_avatar.dart';
import '../../../../../../core/widgets/common_text.dart';

class QueueHeader extends StatelessWidget {
  final VoidCallback onRefresh;
  final bool isRefreshing;

  const QueueHeader({
    super.key,
    required this.onRefresh,
    required this.isRefreshing,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText(
                text: 'Queue Status',
                fontSize: TFont.font20,
                fontWeight: FontWeight.bold,
                fontColor: TAppColors.textPrimary,
              ),
              2.0.height,
              CommonText(
                text: 'Real-time registrar counter tracking',
                fontSize: TFont.font12,
                fontColor: TAppColors.textMuted,
              ),
            ],
          ),
        ),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: TAppColors.statusOpenBg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  CommonCircleAvatar(
                    radius: 3,
                    backgroundColor: TAppColors.statusOpenText,
                  ),
                  5.0.width,
                  CommonText(
                    text: 'Updated just now',
                    fontSize: TFont.font10,
                    fontWeight: FontWeight.bold,
                    fontColor: TAppColors.statusOpenText,
                  ),
                ],
              ),
            ),
            6.0.width,
            Container(
              decoration: BoxDecoration(
                color: TAppColors.surface,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: TAppColors.border),
              ),
              child: IconButton(
                onPressed: isRefreshing ? null : onRefresh,
                icon: isRefreshing
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(
                        Icons.refresh,
                        size: 16,
                        color: TAppColors.textMuted,
                      ),
                constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                padding: EdgeInsets.zero,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
