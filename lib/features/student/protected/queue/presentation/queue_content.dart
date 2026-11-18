import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../../../core/di/injector.dart';
import '../../../../../../core/extensions/context_extension.dart';
import '../../../../../../core/extensions/double_extension.dart';
import '../../../../../../core/widgets/common_page_body.dart';
import '../../../../../../core/widgets/common_text.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../shared/queue/presentation/bloc/queue_bloc.dart';
import '../../../../shared/queue/presentation/bloc/queue_event.dart';
import '../../../../shared/queue/presentation/bloc/queue_state.dart';
// import 'widgets/counter_instructions_card.dart';
import 'widgets/counter_status_card.dart';
import 'widgets/live_counter_queue_list.dart';
import 'widgets/queue_header.dart';

class QueueContent extends StatelessWidget {
  const QueueContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<QueueBloc>()..add(const QueueStarted()),
      child: const _QueueView(),
    );
  }
}

class _QueueView extends StatelessWidget {
  const _QueueView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QueueBloc, QueueState>(
      builder: (context, state) {
        final mine = state.myQueue;

        final details = Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CounterStatusCard(
              mine: mine,
              serving: state.currentlyServing,
              queues: state.queues,
            ),
            16.0.height,
            // const CounterInstructionsCard(),
          ],
        );

        return NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification.metrics.extentAfter < 300) {
              context.read<QueueBloc>().add(const QueueLoadMoreRequested());
            }
            return false;
          },
          child: CommonPageBody(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                QueueHeader(
                  onRefresh: () =>
                      context.read<QueueBloc>().add(const QueueRefreshed()),
                  isRefreshing: state.isLoading,
                ),
                16.0.height,
                if (state.error != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: CommonText(
                      text: state.error!,
                      fontSize: 12,
                      fontColor: TAppColors.errorIcon,
                    ),
                  ),
                if (context.isDesktop)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 5, child: details),
                      20.0.width,
                      Expanded(
                        flex: 4,
                        child: LiveCounterQueueList(
                          queues: state.queues,
                          myQueue: mine,
                        ),
                      ),
                    ],
                  )
                else
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      details,
                      16.0.height,
                      LiveCounterQueueList(queues: state.queues, myQueue: mine),
                    ],
                  ),
                if (state.isLoadingMore)
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                20.0.height,
              ],
            ),
          ),
        );
      },
    );
  }
}
