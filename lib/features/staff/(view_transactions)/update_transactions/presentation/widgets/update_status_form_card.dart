import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../../../core/extensions/double_extension.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/common_text.dart';
import '../cubit/update_transactions_cubit.dart';
import '../cubit/update_transactions_state.dart';

class UpdateStatusFormCard extends StatelessWidget {
  const UpdateStatusFormCard({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UpdateTransactionCubit>();

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
                  Row(
                    children: [
                      const Icon(
                        Icons.tune,
                        size: 16,
                        color: TAppColors.primary,
                      ),
                      8.0.width,
                      CommonText(
                        text: 'Update Status & Disposition',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: TAppColors.errorBg,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: CommonText(
                      text: 'FR-16 Flow',
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      fontColor: TAppColors.primary,
                    ),
                  ),
                ],
              ),
              14.0.height,
              CommonText(
                text: 'New Transaction Status *',
                fontSize: 11,
                fontWeight: FontWeight.bold,
                fontColor: TAppColors.textSecondary,
              ),
              6.0.height,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: TAppColors.background,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: TAppColors.border),
                ),
                child: Row(
                  children: [
                    Icon(Icons.refresh, size: 16, color: TAppColors.primary),
                    8.0.width,
                    Expanded(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: state.selectedStatus,
                          items:
                              [
                                    'Ready for Release',
                                    'In Progress',
                                    'Completed',
                                    'Cancelled',
                                  ]
                                  .map(
                                    (val) => DropdownMenuItem(
                                      value: val,
                                      child: CommonText(
                                        text: val,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                  .toList(),
                          onChanged: (val) {
                            if (val != null) cubit.setStatus(val);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              4.0.height,
              CommonText(
                text: 'Setting this to Ready will prepare claim documents and alert the applicant.',
                fontSize: 10,
                fontColor: TAppColors.textHint,
              ),
              14.0.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonText(
                    text: 'Target Release Window / Counter',
                    fontSize: 11,
                    fontColor: TAppColors.textSecondary,
                  ),
                  CommonText(
                    text: 'Counter Active',
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    fontColor: TAppColors.success,
                  ),
                ],
              ),
              6.0.height,
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: TAppColors.background,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: TAppColors.border),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.window,
                      size: 16,
                      color: TAppColors.primary,
                    ),
                    8.0.width,
                    CommonText(
                      text: state.targetCounter,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
              14.0.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonText(
                    text: 'Official Staff Remarks / Evaluation Notes',
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    fontColor: TAppColors.textSecondary,
                  ),
                  CommonText(
                    text: 'Visible to student',
                    fontSize: 10,
                    fontColor: TAppColors.textHint,
                  ),
                ],
              ),
              6.0.height,
              TextField(
                controller: TextEditingController(text: state.remarksText)
                  ..selection = TextSelection.fromPosition(
                    TextPosition(offset: state.remarksText.length),
                  ),
                maxLines: 4,
                onChanged: (val) => cubit.setRemarks(val),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: TAppColors.background,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: TAppColors.border),
                  ),
                  contentPadding: const EdgeInsets.all(12),
                ),
              ),
              6.0.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.check_circle,
                        size: 14,
                        color: TAppColors.success,
                      ),
                      4.0.width,
                      CommonText(
                        text: 'Registrar verification seal stamped on record file',
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        fontColor: TAppColors.success,
                      ),
                    ],
                  ),
                  CommonText(
                    text: '128 chars',
                    fontSize: 10,
                    fontColor: TAppColors.textHint,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
