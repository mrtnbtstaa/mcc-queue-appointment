import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../../../core/extensions/double_extension.dart';
import '../../../../../../core/router/app_routes.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/common_adaptive_grid.dart';
import '../../../../../../core/widgets/common_text.dart';

class StaffQuickActionsGrid extends StatelessWidget {
  const StaffQuickActionsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CommonText(
          text: 'Quick Actions',
          fontColor: TAppColors.textPrimary,
          fontSize: 13.5,
          fontWeight: FontWeight.bold,
        ),
        12.0.height,
        CommonAdaptiveGrid(
          minItemWidth: 140,
          maxColumns: 2,
          spacing: 10,
          children: [
            _actionCard(
              context,
              Icons.edit_calendar,
              TAppColors.promoBg,
              TAppColors.primary,
              '+ Add Schedule',
              'Open slot window',
              AppRoutes.staffSchedulesPath,
            ),
            _actionCard(
              context,
              Icons.add_circle_outline,
              TAppColors.queueIconBg,
              TAppColors.queueIcon,
              '+ Add Service',
              'New MCC requirement',
              AppRoutes.staffServicesPath,
            ),
            _actionCard(
              context,
              Icons.tv,
              TAppColors.queueIconBg,
              TAppColors.queueIcon,
              'Queue Control',
              'Full TV screen',
              AppRoutes.staffQueuePath,
            ),
          ],
        ),
      ],
    );
  }

  Widget _actionCard(
    BuildContext context,
    IconData icon,
    Color iconBg,
    Color iconColor,
    String title,
    String subtitle,
    String route,
  ) {
    return InkWell(
      onTap: () => context.go(route),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: TAppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: TAppColors.border),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
              child: Icon(icon, size: 16, color: iconColor),
            ),
            8.0.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText(
                    text: title,
                    fontColor: TAppColors.textPrimary,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    maxLine: 1,
                    textOverFlow: TextOverflow.ellipsis,
                  ),
                  CommonText(
                    text: subtitle,
                    fontColor: TAppColors.textMuted,
                    fontSize: 10,
                    maxLine: 1,
                    textOverFlow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
