import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../../../core/extensions/double_extension.dart';
import '../../../../../../core/router/app_routes.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/common_text.dart';
import '../../../../../shared/transaction_history/domain/entities/transaction_entity.dart';

class TransactionCardItem extends StatelessWidget {
  final TransactionEntity transaction;

  const TransactionCardItem({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final isCompleted = transaction.isCompleted;

    return InkWell(
      onTap: () => context.pushNamed(
        AppRoutes.staffTransactionUpdateName,
        pathParameters: {'id': transaction.id},
      ),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: TAppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border(
            left: BorderSide(
              color: isCompleted ? TAppColors.success : TAppColors.warning,
              width: 4,
            ),
          ),
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
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 8,
              runSpacing: 4,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CommonText(
                      text: 'Ref: ${transaction.refNo}',
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      fontColor: TAppColors.primary,
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: TAppColors.border,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: CommonText(
                        text: transaction.queueNumber,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: isCompleted
                        ? TAppColors.successBg
                        : TAppColors.warningBg,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 3,
                        backgroundColor: isCompleted
                            ? TAppColors.success
                            : TAppColors.warningText,
                      ),
                      const SizedBox(width: 4),
                      CommonText(
                        text: transaction.statusText,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        fontColor: isCompleted
                            ? TAppColors.success
                            : TAppColors.warningText,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            CommonText(
              text: transaction.studentName,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 2),
            CommonText(
              text: 'ID: ${transaction.studentId} • ${transaction.course}',
              fontSize: 11,
              fontColor: TAppColors.textHint,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(
                  Icons.school,
                  size: 14,
                  color: TAppColors.textSecondary,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: CommonText(
                    text: transaction.service,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    maxLine: 1,
                    textOverFlow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            if (transaction.paymentInfo != null) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.payment, size: 14, color: Colors.orange),
                    const SizedBox(width: 6),
                    Expanded(
                      child: CommonText(
                        text: transaction.paymentInfo!,
                        fontSize: 11,
                        fontColor: Colors.orange.shade900,
                        maxLine: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            if (transaction.remark != null) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: TAppColors.queueIconBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.info_outline,
                      size: 14,
                      color: TAppColors.queueIcon,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: CommonText(
                        text: transaction.remark!,
                        fontSize: 11,
                        fontColor: TAppColors.queueIcon,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const Divider(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.window,
                        size: 12,
                        color: TAppColors.textHint,
                      ),
                      const SizedBox(width: 4),
                      Flexible(
                        child: CommonText(
                          text: transaction.windowAndStaff,
                          fontSize: 11,
                          fontColor: TAppColors.textSecondary,
                          maxLine: 1,
                          textOverFlow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                8.0.width,
                Row(
                  children: [
                    CommonText(
                      text: transaction.dateStr,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      fontColor: TAppColors.textHint,
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.chevron_right,
                      size: 16,
                      color: TAppColors.textHint,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
