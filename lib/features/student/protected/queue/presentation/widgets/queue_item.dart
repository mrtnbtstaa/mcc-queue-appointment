import 'package:material_ui/material_ui.dart';

import '../../../../../../core/extensions/double_extension.dart';
import '../../../../../../core/style/font.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/common_circle_avatar.dart';
import '../../../../../../core/widgets/common_text.dart';

class QueueItem extends StatelessWidget {
  final String numberBadge;
  final String title;
  final String subtitle;
  final String status;
  final Color statusBg;
  final Color statusText;
  final Color avatarColor;
  final bool isHighlighted;
  final String? scheduledTime;

  const QueueItem({
    super.key,
    required this.numberBadge,
    required this.title,
    required this.subtitle,
    required this.status,
    required this.statusBg,
    required this.statusText,
    required this.avatarColor,
    this.isHighlighted = false,
    this.scheduledTime,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isHighlighted ? TAppColors.errorBg : Colors.transparent,
      child: ListTile(
        leading: CommonCircleAvatar(
          radius: 16,
          backgroundColor: isHighlighted
              ? TAppColors.primary
              : avatarColor.withValues(alpha: 0.15),
          child: CommonText(
            text: numberBadge,
            fontSize: TFont.font11,
            fontWeight: FontWeight.bold,
            fontColor: isHighlighted ? TAppColors.surface : avatarColor,
          ),
        ),
        title: Row(
          children: [
            Flexible(
              child: CommonText(
                text: title,
                fontSize: TFont.font12,
                fontWeight: FontWeight.bold,
                fontColor: isHighlighted
                    ? TAppColors.primary
                    : TAppColors.textPrimary,
                maxLine: 1,
                textOverFlow: TextOverflow.ellipsis,
              ),
            ),
            if (isHighlighted) ...[
              4.0.width,
              const CommonCircleAvatar(
                radius: 2.5,
                backgroundColor: TAppColors.primary,
              ),
            ],
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 2),
          child: CommonText(
            text: scheduledTime != null
                ? 'Scheduled: $scheduledTime'
                : subtitle,
            fontSize: TFont.font10,
            fontColor: TAppColors.textMuted,
          ),
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: statusBg,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isHighlighted) ...[
                const Icon(
                  Icons.check,
                  size: 10,
                  color: TAppColors.statusOpenText,
                ),
                3.0.width,
              ],
              CommonText(
                text: status,
                fontSize: TFont.font10,
                fontWeight: FontWeight.bold,
                fontColor: statusText,
              ),
            ],
          ),
        ),
        dense: true,
      ),
    );
  }
}
