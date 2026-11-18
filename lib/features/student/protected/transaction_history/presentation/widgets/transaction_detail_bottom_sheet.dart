import 'package:material_ui/material_ui.dart';

import '../../../../../../core/extensions/double_extension.dart';
import '../../../../../../core/style/font.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/common_bottom_sheet.dart';
import '../../../../../../core/widgets/common_text.dart';
import '../../../../../shared/transaction_history/domain/entities/transaction_entity.dart';
import 'transaction_detail_header.dart';
import 'transaction_staff_remarks_card.dart';
import 'transaction_status_progression.dart';
import 'transaction_summary_card.dart';

class TransactionDetailBottomSheet extends StatelessWidget {
  static void show(
    BuildContext context, {
    required TransactionEntity transaction,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => TransactionDetailBottomSheet(transaction: transaction),
    );
  }

  final TransactionEntity transaction;

  const TransactionDetailBottomSheet({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return CommonBottomSheet(
      onClosing: () {},
      builder: (context) {
        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TransactionDetailHeader(
                onClose: () => Navigator.of(context).pop(),
              ),
              16.0.height,
              TransactionSummaryCard(transaction: transaction),
              20.0.height,
              TransactionStatusProgression(steps: transaction.progressionSteps),
              20.0.height,
              TransactionStaffRemarksCard(
                remarks: transaction.staffRemarks,
                evaluator: transaction.evaluator,
              ),
              20.0.height,
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: TAppColors.primary,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.download_rounded,
                        size: 16,
                        color: TAppColors.surface,
                      ),
                      8.0.width,
                      CommonText(
                        text: 'Download Official E-Receipt (PDF)',
                        fontSize: TFont.font12,
                        fontWeight: FontWeight.bold,
                        fontColor: TAppColors.surface,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
