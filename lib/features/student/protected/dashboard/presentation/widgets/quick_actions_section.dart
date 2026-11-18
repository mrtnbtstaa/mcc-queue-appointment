import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../../../core/router/app_routes.dart';
import '../../../../../../core/theme/app_colors.dart';

class QuickActionsSection extends StatelessWidget {
  const QuickActionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Actions',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: TAppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 10),
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
          child: Column(
            children: [
              _QuickActionItem(
                Icons.calendar_month_outlined,
                TAppColors.errorIcon,
                'Book Appointment',
                () => context.go(AppRoutes.appointmentsPath),
              ),
              const Divider(
                height: 1,
                indent: 50,
                color: TAppColors.background,
              ),
              _QuickActionItem(
                Icons.confirmation_number_outlined,
                TAppColors.queueIcon,
                'Check Queue Status',
                () => context.go(AppRoutes.queuePath),
              ),
              const Divider(
                height: 1,
                indent: 50,
                color: TAppColors.background,
              ),
              _QuickActionItem(
                Icons.receipt_long_outlined,
                TAppColors.success,
                'View Transaction History',
                () => context.go(AppRoutes.historyPath),
              ),
              const Divider(
                height: 1,
                indent: 50,
                color: TAppColors.background,
              ),
              _QuickActionItem(
                Icons.manage_accounts_outlined,
                TAppColors.primary,
                'View Profile',
                () => context.go(AppRoutes.profilePath),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _QuickActionItem extends StatelessWidget {
  const _QuickActionItem(this.icon, this.color, this.title, this.onTap);

  final IconData icon;
  final Color color;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Material(
    color: Colors.transparent,
    child: ListTile(
      leading: CircleAvatar(
        radius: 16,
        backgroundColor: color.withValues(alpha: 0.1),
        child: Icon(icon, size: 16, color: color),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: TAppColors.textPrimary,
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        size: 18,
        color: TAppColors.textMuted,
      ),
      onTap: onTap,
      dense: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  );
}
