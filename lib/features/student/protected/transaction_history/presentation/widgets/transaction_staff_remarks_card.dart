import 'package:material_ui/material_ui.dart';

import '../../../../../../core/extensions/double_extension.dart';
import '../../../../../../core/style/font.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/common_text.dart';

class TransactionStaffRemarksCard extends StatelessWidget {
  final String remarks;
  final String evaluator;

  const TransactionStaffRemarksCard({
    super.key,
    required this.remarks,
    required this.evaluator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: TAppColors.errorBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: TAppColors.errorBorder.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.rate_review_outlined,
                size: 14,
                color: TAppColors.primary,
              ),
              6.0.width,
              CommonText(
                text: 'STAFF REMARKS',
                fontSize: TFont.font10,
                fontWeight: FontWeight.bold,
                fontColor: TAppColors.primary,
              ),
            ],
          ),
          8.0.height,
          CommonText(
            text: remarks,
            fontSize: TFont.font11,
            fontColor: TAppColors.textPrimary,
          ),
          8.0.height,
          Align(
            alignment: Alignment.centerRight,
            child: CommonText(
              text: 'Evaluator: $evaluator',
              fontSize: TFont.font8,
              fontColor: TAppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}
