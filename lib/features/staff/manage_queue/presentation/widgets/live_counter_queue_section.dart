import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../../../core/extensions/double_extension.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/common_text.dart';
import '../../../../shared/filter_options/presentation/filter_options_cubit.dart';
import '../../../../shared/queue/domain/entities/queue_entity.dart';
import '../../../../shared/queue/presentation/bloc/queue_bloc.dart';
import '../../../../shared/queue/presentation/bloc/queue_event.dart';
import '../../../../shared/queue/presentation/bloc/queue_state.dart';

class LiveCounterQueueSection extends StatelessWidget {
  final QueueState state;

  const LiveCounterQueueSection({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<QueueBloc>();
    final list = state.filteredQueue;
    final statuses = context
        .watch<FilterOptionsCubit>()
        .state
        .options
        .queueStatuses;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 8,
          runSpacing: 4,
          children: [
            CommonText(
              text: 'Live Counter Queue',
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: TAppColors.border,
                borderRadius: BorderRadius.circular(12),
              ),
              child: CommonText(
                text: '${state.activeCount} Active',
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        12.0.height,
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (var i = 0; i < statuses.length; i++) ...[
                if (i > 0) 8.0.width,
                _buildTab(
                  statuses[i].value,
                  '${statuses[i].label} (${state.countFor(statuses[i].value)})',
                  state.selectedStatus,
                  bloc,
                ),
              ],
            ],
          ),
        ),
        12.0.height,
        if (list.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 16),
            decoration: BoxDecoration(
              color: TAppColors.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: TAppColors.border),
            ),
            child: CommonText(
              text: state.isLoading ? 'Loading queue…' : 'No queue entries.',
              fontSize: 12,
              fontColor: TAppColors.textHint,
              alignment: TextAlign.center,
            ),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: list.length,
            itemBuilder: (context, index) {
              final item = list[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: TAppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border(
                    left: BorderSide(
                      color: item.isPriority
                          ? TAppColors.warning
                          : TAppColors.primary,
                      width: 4,
                    ),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.02),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: TAppColors.background,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: CommonText(
                        text: item.queueNumber,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontColor: TAppColors.primary,
                      ),
                    ),
                    10.0.width,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonText(
                            text: item.studentName.isEmpty
                                ? 'Student'
                                : item.studentName,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            maxLine: 1,
                            textOverFlow: TextOverflow.ellipsis,
                          ),
                          2.0.height,
                          CommonText(
                            text: [
                              if (item.studentId.isNotEmpty) item.studentId,
                              if (item.serviceName.isNotEmpty) item.serviceName,
                              if (item.slotSchedule.isNotEmpty)
                                item.slotSchedule,
                            ].join(' • '),
                            fontSize: 11,
                            fontColor: TAppColors.textHint,
                            maxLine: 1,
                            textOverFlow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    if (item.status == QueueStatus.waiting)
                      IconButton(
                        icon: const Icon(
                          Icons.call,
                          size: 18,
                          color: TAppColors.primary,
                        ),
                        onPressed: () => bloc.add(QueueCallRequested(item.id)),
                      ),
                  ],
                ),
              );
            },
          ),
      ],
    );
  }

  Widget _buildTab(
    String status,
    String label,
    String currentStatus,
    QueueBloc bloc,
  ) {
    final isSelected = status == currentStatus;
    return InkWell(
      onTap: () => bloc.add(QueueStatusChanged(status)),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? TAppColors.primary : TAppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? Colors.transparent : TAppColors.border,
          ),
        ),
        child: CommonText(
          text: label,
          fontSize: 11,
          fontWeight: FontWeight.bold,
          fontColor: isSelected ? TAppColors.surface : TAppColors.textPrimary,
        ),
      ),
    );
  }
}
