import 'package:material_ui/material_ui.dart';

import '../../../../../../core/extensions/double_extension.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/common_empty_state.dart';
import '../../../../../shared/queue/domain/entities/queue_entity.dart';
import 'live_counter_queue_header.dart';
import 'queue_item.dart';

class LiveCounterQueueList extends StatelessWidget {
  final List<QueueItemModel> queues;
  final QueueItemModel? myQueue;

  const LiveCounterQueueList({super.key, required this.queues, this.myQueue});

  @override
  Widget build(BuildContext context) {
    final activeQueues =
        queues
            .where(
              (queue) =>
                  queue.status == QueueStatus.waiting ||
                  queue.status == QueueStatus.serving,
            )
            .toList()
          ..sort((a, b) => a.position.compareTo(b.position));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const LiveCounterQueueHeader(),
        10.0.height,
        Container(
          decoration: BoxDecoration(
            color: TAppColors.surface,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: activeQueues.isEmpty
              ? const CommonEmptyState(
                  title: 'No active queues',
                  message: 'Your queue will appear here after you join.',
                  illustrationHeight: 110,
                )
              : Column(
                  children: [
                    for (var i = 0; i < activeQueues.length; i++) ...[
                      if (i > 0)
                        const Divider(
                          height: 1,
                          indent: 16,
                          endIndent: 16,
                          color: TAppColors.background,
                        ),
                      _queueItem(activeQueues[i], i),
                    ],
                  ],
                ),
        ),
      ],
    );
  }

  Widget _queueItem(QueueItemModel queue, int index) {
    final serving = queue.status == QueueStatus.serving;
    final mine = queue.id == myQueue?.id;
    final color = serving || mine ? TAppColors.primary : TAppColors.warningText;
    return QueueItem(
      numberBadge: queue.position > 0 ? '${queue.position}' : '${index + 1}',
      title: mine ? '${queue.queueNumber} (You)' : queue.queueNumber,
      subtitle: queue.serviceName,
      status: mine ? 'Your Queue' : queue.status.label,
      statusBg: serving || mine
          ? TAppColors.statusOpenBg
          : TAppColors.warningBg,
      statusText: color,
      avatarColor: color,
      isHighlighted: mine,
      scheduledTime: queue.appointmentTime,
    );
  }
}
