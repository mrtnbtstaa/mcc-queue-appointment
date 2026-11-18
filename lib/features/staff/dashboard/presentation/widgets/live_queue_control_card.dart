import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../../../core/router/app_routes.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/common_elevated_button.dart';
import '../../../../../../core/widgets/common_text.dart';
import '../../../../../../features/shared/dashboard/domain/dashboard_summary.dart';

class LiveQueueControlCard extends StatelessWidget {
  final DashboardSummary? summary;
  const LiveQueueControlCard({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    final serving = summary?.nowServing;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: TAppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: TAppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CommonText(
            text: 'NOW SERVING',
            fontColor: TAppColors.textHint,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 10),
          if (serving == null)
            CommonText(
              text: 'No one is currently being served.',
              fontColor: TAppColors.textSecondary,
              fontSize: 14,
            )
          else ...[
            CommonText(
              text: serving['queue_number']?.toString() ?? 'Queue',
              fontColor: TAppColors.primary,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
            CommonText(
              text: serving['student_name']?.toString() ?? '',
              fontColor: TAppColors.textPrimary,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
            CommonText(
              text: serving['service_name']?.toString() ?? '',
              fontColor: TAppColors.textMuted,
              fontSize: 11,
            ),
          ],
          const SizedBox(height: 14),
          CommonElevatedButton(
            text: 'Open Queue Management',
            backgroundColor: TAppColors.primary,
            onButtonPressed: () => context.go(AppRoutes.staffQueuePath),
          ),
        ],
      ),
    );
  }
}
