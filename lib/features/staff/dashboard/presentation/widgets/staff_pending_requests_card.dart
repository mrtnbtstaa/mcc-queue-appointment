import 'package:material_ui/material_ui.dart';

import '../../../../../../core/extensions/double_extension.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/common_text.dart';

class StaffPendingRequestsCard extends StatelessWidget {
  const StaffPendingRequestsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: TAppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: TAppColors.border),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: TAppColors.promoBg,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.assignment_late_outlined,
              size: 18,
              color: TAppColors.primary,
            ),
          ),
          12.0.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CommonText(
                      text: '8 Pending Requests',
                      fontColor: TAppColors.textPrimary,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
                2.0.height,
                CommonText(
                  text: 'Document approvals, TOR requests & clearance tags',
                  fontColor: TAppColors.textMuted,
                  fontSize: 11,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: TAppColors.promoBg,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: TAppColors.promoBorder),
            ),
            child: CommonText(
              text: 'Requires Review',
              fontColor: TAppColors.primary,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          8.0.width,
          const Icon(
            Icons.chevron_right,
            size: 18,
            color: TAppColors.textMuted,
          ),
        ],
      ),
    );
  }
}
