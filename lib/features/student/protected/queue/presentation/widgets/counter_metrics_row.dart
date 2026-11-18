import 'package:material_ui/material_ui.dart';

import '../../../../../../core/extensions/double_extension.dart';
import '../../../../../../core/style/font.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/common_circle_avatar.dart';
import '../../../../../../core/widgets/common_text.dart';
import '../../../../../shared/queue/domain/entities/queue_entity.dart';

class CounterMetricsRow extends StatelessWidget {
  final QueueItemModel? mine;
  final QueueItemModel? serving;

  const CounterMetricsRow({
    super.key,
    required this.mine,
    required this.serving,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: TAppColors.inputFill,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: TAppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: CommonText(
                        text: 'Now Serving',
                        fontSize: TFont.font8,
                        fontColor: TAppColors.textHint,
                        maxLine: 1,
                        textOverFlow: TextOverflow.ellipsis,
                      ),
                    ),
                    CommonCircleAvatar(
                      radius: 3,
                      backgroundColor: TAppColors.queueIcon,
                    ),
                  ],
                ),
                4.0.height,
                Row(
                  children: [
                    CommonText(
                      text: serving?.queueNumber ?? '—',
                      fontSize: TFont.font16,
                      fontWeight: FontWeight.bold,
                      fontColor: TAppColors.textPrimary,
                    ),
                    SizedBox(width: 4),
                    Flexible(
                      child: CommonText(
                        text: serving == null ? 'Idle' : serving!.statusLabel,
                        fontSize: TFont.font10,
                        fontWeight: FontWeight.bold,
                        fontColor: TAppColors.queueIcon,
                        maxLine: 1,
                        textOverFlow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        10.0.width,
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: TAppColors.errorBg,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: TAppColors.errorBorder.withValues(alpha: 0.5),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: CommonText(
                        text: 'Your Number',
                        fontSize: TFont.font10,
                        fontColor: TAppColors.primary,
                        maxLine: 1,
                        textOverFlow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (mine != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 1,
                        ),
                        decoration: BoxDecoration(
                          color: TAppColors.primary,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: CommonText(
                          text: 'YOU',
                          fontSize: TFont.font8,
                          fontWeight: FontWeight.bold,
                          fontColor: TAppColors.surface,
                        ),
                      ),
                  ],
                ),
                4.0.height,
                Row(
                  children: [
                    CommonText(
                      text: mine?.queueNumber ?? '—',
                      fontSize: TFont.font16,
                      fontWeight: FontWeight.bold,
                      fontColor: TAppColors.primary,
                    ),
                    SizedBox(width: 4),
                    Flexible(
                      child: CommonText(
                        text: mine?.statusLabel ?? 'No queue',
                        fontSize: TFont.font10,
                        fontColor: TAppColors.textMuted,
                        maxLine: 1,
                        textOverFlow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
