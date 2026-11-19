import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../core/widgets/common_empty_state.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/common_text.dart';
import 'notifications_cubit.dart';

class NotificationFeedSheet extends StatelessWidget {
  const NotificationFeedSheet({super.key, this.height});

  final double? height;

  @override
  Widget build(BuildContext context) => SafeArea(
    child: SizedBox(
      height: height ?? MediaQuery.sizeOf(context).height * 0.72,
      child: BlocBuilder<NotificationsCubit, NotificationsState>(
        builder: (context, state) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 12, 12),
              child: Row(
                children: [
                  Expanded(
                    child: CommonText(
                      text: 'Notifications',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontColor: TAppColors.textPrimary,
                    ),
                  ),
                  if (state.items.isNotEmpty)
                    TextButton(
                      onPressed: context.read<NotificationsCubit>().markAllRead,
                      child: const Text('Mark all read'),
                    ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
            ),
            if (state.error != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        state.error!,
                        style: const TextStyle(color: TAppColors.errorText),
                      ),
                    ),
                    IconButton(
                      onPressed: context.read<NotificationsCubit>().refresh,
                      icon: const Icon(Icons.refresh),
                    ),
                  ],
                ),
              ),
            const Divider(height: 1),
            Expanded(
              child: state.items.isEmpty
                  ? const CommonEmptyState(
                      title: 'You’re all caught up',
                      message: 'New notifications will appear here.',
                      illustrationHeight: 140,
                    )
                  : ListView.separated(
                      itemCount: state.items.length,
                      separatorBuilder: (_, _) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final item = state.items[index];
                        return ListTile(
                          title: Text(item.title),
                          subtitle: Text(item.message),
                          trailing: IconButton(
                            tooltip: 'Mark as read',
                            onPressed: () => context
                                .read<NotificationsCubit>()
                                .markRead(item.id),
                            icon: const Icon(Icons.check),
                          ),
                          onTap: () => context
                              .read<NotificationsCubit>()
                              .markRead(item.id),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    ),
  );
}
