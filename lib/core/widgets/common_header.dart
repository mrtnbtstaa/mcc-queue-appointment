import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../../../core/style/font.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/common_circle_avatar.dart';
import '../../../../../../core/widgets/common_responsive_modal.dart';
import '../../../../../../core/widgets/common_text.dart';
import '../../features/shared/notifications/presentation/notification_feed_sheet.dart';
import '../../features/shared/notifications/presentation/notifications_cubit.dart';

class CommonHeader extends StatelessWidget implements PreferredSizeWidget {
  const CommonHeader({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(65);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: TAppColors.primary,
      elevation: 0,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(
            text: "Mabalacat City College",
            fontColor: TAppColors.surface,
            fontSize: TFont.font12,
            fontWeight: FontWeight.bold,
            maxLine: 1,
            textOverFlow: TextOverflow.ellipsis,
          ),
          CommonText(
            text: "Registrar's Office • Student Services System",
            fontColor: TAppColors.surface,
            fontSize: TFont.font8,
            maxLine: 1,
            textOverFlow: TextOverflow.ellipsis,
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {
            final cubit = context.read<NotificationsCubit>();
            CommonResponsiveModal.show<void>(
              context: context,
              isScrollControlled: true,
              builder: (_) => BlocProvider.value(
                value: cubit,
                child: const NotificationFeedSheet(),
              ),
            );
          },
          icon: BlocBuilder<NotificationsCubit, NotificationsState>(
            builder: (context, state) => Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(
                  Icons.notifications_outlined,
                  color: TAppColors.surface,
                ),
                if (state.unreadCount > 0)
                  Positioned(
                    right: -7,
                    top: -7,
                    child: Container(
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: const BoxDecoration(
                        color: Colors.orange,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        state.unreadCount > 99 ? '99+' : '${state.unreadCount}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: CommonCircleAvatar(
            radius: 16,
            backgroundColor: Colors.white24,
            child: const Icon(
              Icons.person,
              color: TAppColors.surface,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }
}
