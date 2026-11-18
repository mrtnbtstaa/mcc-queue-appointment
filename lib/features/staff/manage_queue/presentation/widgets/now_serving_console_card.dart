import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../../../core/extensions/double_extension.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/common_elevated_button.dart';
import '../../../../../../core/widgets/common_text.dart';
import '../../../../shared/queue/domain/entities/queue_entity.dart';
import '../../../../shared/queue/presentation/bloc/queue_bloc.dart';
import '../../../../shared/queue/presentation/bloc/queue_event.dart';

class NowServingConsoleCard extends StatelessWidget {
  final QueueItemModel? serving;
  final QueueItemModel? nextWaiting;
  final bool isUpdating;

  const NowServingConsoleCard({
    super.key,
    required this.serving,
    required this.nextWaiting,
    required this.isUpdating,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<QueueBloc>();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: TAppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: TAppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 4,
                      backgroundColor: TAppColors.primary,
                    ),
                    6.0.width,
                    Flexible(
                      child: CommonText(
                        text: 'NOW SERVING CONSOLE',
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        fontColor: TAppColors.textHint,
                        maxLine: 1,
                        textOverFlow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              8.0.width,
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: TAppColors.border,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.timer,
                      size: 12,
                      color: TAppColors.textSecondary,
                    ),
                    4.0.width,
                    CommonText(
                      text: serving?.waitTime.isNotEmpty == true
                          ? serving!.waitTime
                          : 'Idle',
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
            ],
          ),
          16.0.height,
          if (serving != null) ...[
            Center(
              child: Column(
                children: [
                  CommonText(
                    text: serving!.queueNumber,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    fontColor: TAppColors.primary,
                  ),
                  4.0.height,
                  CommonText(
                    text: serving!.studentName.isEmpty
                        ? 'Student'
                        : serving!.studentName,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  4.0.height,
                  CommonText(
                    text: [
                      if (serving!.studentId.isNotEmpty)
                        'Student ID: ${serving!.studentId}',
                      if (serving!.course.isNotEmpty) serving!.course,
                    ].join(' • '),
                    fontSize: 11,
                    fontColor: TAppColors.textHint,
                  ),
                  12.0.height,
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: TAppColors.background,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        CommonText(
                          text: 'Current Service',
                          fontSize: 10,
                          fontColor: TAppColors.textHint,
                        ),
                        2.0.height,
                        CommonText(
                          text: serving!.serviceName.isEmpty
                              ? 'Registrar Service'
                              : serving!.serviceName,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ] else ...[
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: CommonText(
                  text: 'No active student currently being served.',
                  fontColor: TAppColors.textHint,
                ),
              ),
            ),
          ],
          8.0.height,
          CommonElevatedButton(
            text: nextWaiting == null
                ? 'No Waiting Students'
                : 'Call Next Student (${nextWaiting!.queueNumber})',
            backgroundColor: TAppColors.primary,
            onButtonPressed: nextWaiting == null || isUpdating
                ? null
                : () => bloc.add(const QueueCallNextRequested()),
          ),
          12.0.height,
          Row(
            children: [
              Expanded(
                child: CommonElevatedButton(
                  text: 'Complete',
                  backgroundColor: TAppColors.success,
                  onButtonPressed: serving == null || isUpdating
                      ? null
                      : () => bloc.add(const QueueCompleteRequested()),
                ),
              ),
              8.0.width,
              Expanded(
                child: CommonElevatedButton(
                  text: 'No-Show / Skip',
                  backgroundColor: TAppColors.errorIcon,
                  onButtonPressed: serving == null || isUpdating
                      ? null
                      : () => bloc.add(const QueueSkipRequested()),
                ),
              ),
            ],
          ),
          8.0.height,
        ],
      ),
    );
  }
}
