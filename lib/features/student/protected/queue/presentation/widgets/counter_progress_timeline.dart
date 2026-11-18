import 'package:material_ui/material_ui.dart';

import '../../../../../../core/extensions/double_extension.dart';
import '../../../../../../core/style/font.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/common_circle_avatar.dart';
import '../../../../../../core/widgets/common_text.dart';
import '../../../../../shared/queue/domain/entities/queue_entity.dart';

class CounterProgressTimeline extends StatelessWidget {
  final QueueItemModel? mine;
  final QueueItemModel? serving;
  final List<QueueItemModel> queues;

  const CounterProgressTimeline({
    super.key,
    required this.mine,
    required this.serving,
    required this.queues,
  });

  @override
  Widget build(BuildContext context) {
    final active = queues
        .where(
          (queue) =>
              queue.status == QueueStatus.waiting ||
              queue.status == QueueStatus.serving,
        )
        .take(4)
        .toList();

    final mineIncluded = active.any((queue) => queue.isMine);
    if (mine != null && !mineIncluded) {
      active.add(mine!);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CommonText(
              text: 'Progress Timeline',
              fontSize: TFont.font10,
              fontWeight: FontWeight.bold,
              fontColor: TAppColors.textPrimary,
            ),
            CommonText(
              text: active.isEmpty ? 'No active queue' : 'Live order',
              fontSize: TFont.font8,
              fontColor: TAppColors.textMuted,
            ),
          ],
        ),
        10.0.height,
        if (active.isEmpty)
          CommonText(
            text: 'Queue updates will appear here once your appointment is checked in.',
            fontSize: TFont.font10,
            fontColor: TAppColors.textMuted,
          )
        else
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (final queue in active)
                _buildTimelineNode(
                  queue.queueNumber,
                  _statusFor(queue),
                  _colorFor(queue),
                ),
            ],
          ),
      ],
    );
  }

  String _statusFor(QueueItemModel queue) {
    if (queue.status == QueueStatus.serving) return 'Serving';
    if (queue.isMine) return 'You';
    if (queue.status == QueueStatus.waiting && queue.position == 2) {
      return 'Next';
    }
    return queue.statusLabel;
  }

  Color _colorFor(QueueItemModel queue) {
    if (queue.status == QueueStatus.serving) return TAppColors.queueIcon;
    if (queue.isMine) return TAppColors.primary;
    if (queue.status == QueueStatus.waiting && queue.position == 2) {
      return Colors.orange;
    }
    return TAppColors.textMuted;
  }

  Widget _buildTimelineNode(String code, String status, Color color) {
    return Column(
      children: [
        CommonCircleAvatar(
          radius: 14,
          backgroundColor: color,
          child: const Icon(Icons.person, size: 12, color: TAppColors.surface),
        ),
        4.0.height,
        CommonText(
          text: code,
          fontSize: TFont.font8,
          fontWeight: FontWeight.bold,
          fontColor: color,
        ),
        CommonText(
          text: status,
          fontSize: TFont.font8,
          fontColor: TAppColors.textMuted,
        ),
      ],
    );
  }
}
