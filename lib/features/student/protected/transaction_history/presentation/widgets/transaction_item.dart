import 'package:material_ui/material_ui.dart';

import '../../../../../../core/extensions/double_extension.dart';
import '../../../../../../core/style/font.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/common_circle_avatar.dart';
import '../../../../../../core/widgets/common_text.dart';
import '../../../../../shared/transaction_history/domain/entities/transaction_entity.dart';

class TransactionItem extends StatelessWidget {
  final TransactionEntity transaction;
  final VoidCallback? onTap;

  const TransactionItem({super.key, required this.transaction, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: TAppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: transaction.isInProgress
              ? Border.all(color: TAppColors.primary, width: 1.2)
              : Border.all(color: Colors.transparent),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 8,
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
                Expanded(
                  child: Row(
                    children: [
                      CommonCircleAvatar(
                        radius: 18,
                        backgroundColor: transaction.iconColor.withValues(
                          alpha: 0.15,
                        ),
                        child: Icon(
                          transaction.icon,
                          color: transaction.iconColor,
                          size: 18,
                        ),
                      ),
                      12.0.width,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonText(
                              text: transaction.title,
                              fontSize: TFont.font12,
                              fontWeight: FontWeight.bold,
                              fontColor: TAppColors.textPrimary,
                              maxLine: 1,
                              textOverFlow: TextOverflow.ellipsis,
                            ),
                            2.0.height,
                            CommonText(
                              text: transaction.date,
                              fontSize: TFont.font10,
                              fontColor: TAppColors.textMuted,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                8.0.width,
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
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
            12.0.height,
            const Divider(height: 1, color: TAppColors.background),
            10.0.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Wrap(
                    spacing: 2,
                    runSpacing: 2,
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
                      CommonText(
                        text: '   •   ',
                        fontSize: TFont.font10,
                        fontColor: TAppColors.textMuted,
                      ),
                      CommonText(
                        text: 'Queue: ',
                        fontSize: TFont.font10,
                        fontColor: TAppColors.textMuted,
                      ),
                      CommonText(
                        text: transaction.queueInfo,
                        fontSize: TFont.font10,
                        fontWeight: FontWeight.bold,
                        fontColor: TAppColors.primary,
                      ),
                    ],
                  ),
                ),
                8.0.width,
                const Icon(
                  Icons.chevron_right,
                  size: 16,
                  color: TAppColors.textMuted,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
