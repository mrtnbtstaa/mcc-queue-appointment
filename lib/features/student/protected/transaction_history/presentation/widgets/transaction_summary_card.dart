import 'package:material_ui/material_ui.dart';

import '../../../../../../core/extensions/double_extension.dart';
import '../../../../../../core/style/font.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/common_circle_avatar.dart';
import '../../../../../../core/widgets/common_text.dart';
import '../../../../../shared/transaction_history/domain/entities/transaction_entity.dart';

class TransactionSummaryCard extends StatelessWidget {
  final TransactionEntity transaction;

  const TransactionSummaryCard({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: TAppColors.inputFill,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: TAppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonText(
                text: 'Service Type',
                fontSize: TFont.font10,
                fontColor: TAppColors.textMuted,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: transaction.statusBgColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CommonCircleAvatar(
                      radius: 2.5,
                      backgroundColor: transaction.statusTextColor,
                    ),
                    4.0.width,
                    CommonText(
                      text: transaction.statusText,
                      fontSize: TFont.font10,
                      fontWeight: FontWeight.bold,
                      fontColor: transaction.statusTextColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
          4.0.height,
          CommonText(
            text: transaction.title,
            fontSize: TFont.font14,
            fontWeight: FontWeight.bold,
            fontColor: TAppColors.textPrimary,
          ),
          12.0.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CommonText(
                    text: 'Ref: ',
                    fontSize: TFont.font10,
                    fontColor: TAppColors.textMuted,
                  ),
                  CommonText(
                    text: transaction.refNo,
                    fontSize: TFont.font10,
                    fontWeight: FontWeight.bold,
                    fontColor: TAppColors.textPrimary,
                  ),
                ],
              ),
              Row(
                children: [
                  CommonText(
                    text: 'Queue No: ',
                    fontSize: TFont.font10,
                    fontColor: TAppColors.textMuted,
                  ),
                  CommonText(
                    text: transaction.queueNo,
                    fontSize: TFont.font10,
                    fontWeight: FontWeight.bold,
                    fontColor: TAppColors.primary,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
