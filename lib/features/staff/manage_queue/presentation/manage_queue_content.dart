import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../../../core/di/injector.dart';
import '../../../../../../core/extensions/context_extension.dart';
import '../../../../../../core/extensions/double_extension.dart';
import '../../../../../../core/widgets/common_page_body.dart';
import '../../../../../../core/widgets/common_text.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../shared/queue/presentation/bloc/queue_bloc.dart';
import '../../../shared/queue/presentation/bloc/queue_event.dart';
import '../../../shared/queue/presentation/bloc/queue_state.dart';
import 'widgets/live_counter_queue_section.dart';
import 'widgets/now_serving_console_card.dart';

class ManageQueueWrapper extends StatelessWidget {
  const ManageQueueWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<QueueBloc>()..add(const QueueStarted()),
      child: const ManageQueueContent(),
    );
  }
}

class ManageQueueContent extends StatelessWidget {
  const ManageQueueContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QueueBloc, QueueState>(
      builder: (context, state) {
        final console = NowServingConsoleCard(
          serving: state.currentlyServing,
          nextWaiting: state.nextWaiting,
          isUpdating: state.isUpdating,
        );
        final queue = LiveCounterQueueSection(state: state);

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
                      Expanded(flex: 5, child: queue),
                      20.0.width,
                      Expanded(flex: 4, child: console),
                    ],
                  )
                else
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [console, 16.0.height, queue],
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
