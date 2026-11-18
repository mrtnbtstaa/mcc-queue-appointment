import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../features/shared/notifications/presentation/notifications_cubit.dart';

class NotificationsSection extends StatelessWidget {
  const NotificationsSection({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<NotificationsCubit, NotificationsState>(
        builder: (context, state) => Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: TAppColors.surface,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Notifications',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${state.unreadCount} unread',
                    style: const TextStyle(
                      fontSize: 11,
                      color: TAppColors.textMuted,
                    ),
                  ),
                ],
              ),
              if (state.error != null) ...[
                const SizedBox(height: 8),
                Text(
                  state.error!,
                  style: const TextStyle(
                    color: TAppColors.errorIcon,
                    fontSize: 12,
                  ),
                ),
              ],
              if (state.items.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  child: Text(
                    'No unread notifications.',
                    style: TextStyle(color: TAppColors.textMuted),
                  ),
                )
              else
                for (final item in state.items.take(3))
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    title: Text(
                      item.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      item.message,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: IconButton(
                      tooltip: 'Mark as read',
                      icon: const Icon(Icons.check_circle_outline, size: 18),
                      onPressed: () =>
                          context.read<NotificationsCubit>().markRead(item.id),
                    ),
                  ),
            ],
          ),
        ),
      );
}
