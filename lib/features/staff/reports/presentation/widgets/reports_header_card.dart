import 'package:material_ui/material_ui.dart';

import '../../../../../../core/extensions/double_extension.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/common_text.dart';

class ReportsHeaderCard extends StatelessWidget {
  const ReportsHeaderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: TAppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: TAppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: TAppColors.errorBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: CommonText(
                  text: 'FR-19 Reporting Engine',
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  fontColor: TAppColors.primary,
                ),
              ),
              const Icon(
                Icons.analytics_outlined,
                color: TAppColors.primary,
                size: 20,
              ),
            ],
          ),
          10.0.height,
          CommonText(
            text: 'Registrar Reports & Analytics',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontColor: TAppColors.textPrimary,
          ),
          4.0.height,
          CommonText(
            text: 'Generate PDF summaries from appointment and transaction records.',
            fontSize: 12,
            fontColor: TAppColors.textSecondary,
          ),
        ],
      ),
    );
  }
}
