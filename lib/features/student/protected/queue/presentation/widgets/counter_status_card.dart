import 'package:material_ui/material_ui.dart';

import '../../../../../../core/extensions/double_extension.dart';
import '../../../../../../core/style/font.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/common_text.dart';
import '../../../../../shared/queue/domain/entities/queue_entity.dart';
import 'counter_details_row.dart';
import 'counter_metrics_row.dart';
import 'counter_progress_timeline.dart';
import 'counter_window_header.dart';

class CounterStatusCard extends StatelessWidget {
  final QueueItemModel? mine;
  final QueueItemModel? serving;
  final List<QueueItemModel> queues;

  const CounterStatusCard({
    super.key,
    required this.mine,
    required this.serving,
    required this.queues,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CounterWindowHeader(serviceName: mine?.serviceName ?? ''),
          12.0.height,
          CounterMetricsRow(mine: mine, serving: serving),
          10.0.height,
          CounterDetailsRow(mine: mine),
          14.0.height,
          CounterProgressTimeline(mine: mine, serving: serving, queues: queues),
        ],
      ),
    );
  }
}

class CounterStatusCardPlaceholder extends StatelessWidget {
  const CounterStatusCardPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: CommonText(
          text: 'No active queue for your account today.',
          fontSize: TFont.font12,
          fontColor: TAppColors.textHint,
        ),
      ),
    );
  }
}
