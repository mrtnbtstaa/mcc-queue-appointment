import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../../../core/extensions/double_extension.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/common_circle_avatar.dart';
import '../../../../../../core/widgets/common_text.dart';
import '../cubit/update_transactions_cubit.dart';
import '../cubit/update_transactions_state.dart';

class TransactionSummaryCard extends StatelessWidget {
  const TransactionSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateTransactionCubit, UpdateTransactionState>(
      builder: (context, state) {
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
                  CommonText(
                    text: 'Transaction Reference',
                    fontSize: 11,
                    fontColor: TAppColors.textHint,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: TAppColors.warningBg,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 3,
                          backgroundColor: TAppColors.warningText,
                        ),
                        4.0.width,
                        CommonText(
                          text: state.currentStatus,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          fontColor: TAppColors.warningText,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              4.0.height,
              Row(
                children: [
                  CommonText(
                    text: state.transactionRef,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontColor: TAppColors.primary,
                  ),
                  6.0.width,
                  const Icon(Icons.copy, size: 14, color: TAppColors.textHint),
                ],
              ),
              const Divider(height: 24),
              Row(
                children: [
                  const CommonCircleAvatar(
                    backgroundColor: TAppColors.errorBg,
                    child: Icon(
                      Icons.person,
                      color: TAppColors.primary,
                      size: 18,
                    ),
                  ),
                  10.0.width,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonText(
                          text: state.studentName,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        4.0.height,
                        CommonText(
                          text: 'ID: ${state.studentId} • ${state.course}',
                          fontSize: 11,
                          fontColor: TAppColors.textHint,
                        ),
                        2.0.height,
                        CommonText(
                          text: 'Mabalacat City College',
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          fontColor: TAppColors.primary,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(height: 24),
              _buildRowItem('Requested Ser...', state.requestedService),
              8.0.height,
              _buildRowItem('Date Submitted', state.dateSubmitted),
              8.0.height,
              _buildRowItem('Assigned Eval...', state.assignedEvaluator),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRowItem(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(
              Icons.info_outline,
              size: 14,
              color: TAppColors.textHint,
            ),
            6.0.width,
            CommonText(
              text: label,
              fontSize: 11,
              fontColor: TAppColors.textHint,
            ),
          ],
        ),
        CommonText(text: value, fontSize: 11, fontWeight: FontWeight.bold),
      ],
    );
  }
}
