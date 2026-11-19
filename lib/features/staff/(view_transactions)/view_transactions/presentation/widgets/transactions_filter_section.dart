import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../../../core/extensions/double_extension.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/common_text.dart';
import '../../../../../../core/widgets/common_text_field.dart';
import '../../../../../shared/transaction_history/domain/entities/transaction_entity.dart';
import '../../../../../shared/transaction_history/presentation/cubit/transaction_cubit.dart';
import '../../../../../shared/transaction_history/presentation/cubit/transaction_state.dart';

class TransactionsFilterSection extends StatelessWidget {
  const TransactionsFilterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TransactionCubit>();

    return BlocBuilder<TransactionCubit, TransactionState>(
      builder: (context, state) {
        return Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildTab(
                    cubit,
                    state,
                    TransactionTab.allRecords,
                    'All Records',
                    '${state.transactions.length}',
                  ),
                  8.0.width,
                  _buildTab(
                    cubit,
                    state,
                    TransactionTab.completed,
                    'Completed',
                    '${state.completedCount}',
                  ),
                  8.0.width,
                  _buildTab(
                    cubit,
                    state,
                    TransactionTab.inProgress,
                    'Pending / Processing',
                    '${state.inProgressCount}',
                  ),
                ],
              ),
            ),
            12.0.height,
            Row(
              children: [
                Expanded(
                  child: CommonTextField(
                    hintText: 'Search reference, student name, evaluator...',
                    prefixIcon: const Icon(Icons.search, size: 18),
                    onChanged: (val) => cubit.setSearchQuery(val),
                  ),
                ),
                8.0.width,
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: TAppColors.surface,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: TAppColors.border),
                  ),
                  child: const Icon(
                    Icons.tune,
                    size: 18,
                    color: TAppColors.textSecondary,
                  ),
                ),
              ],
            ),
            12.0.height,
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: TAppColors.surface,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: TAppColors.border),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.calendar_today,
                          size: 14,
                          color: TAppColors.primary,
                        ),
                        6.0.width,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonText(
                                text: 'DATE WINDOW',
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                                fontColor: TAppColors.textHint,
                              ),
                              CommonText(
                                text: state.dateWindow,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.arrow_drop_down, size: 18),
                      ],
                    ),
                  ),
                ),
                8.0.width,
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: TAppColors.surface,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: TAppColors.border),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              const Icon(
                                Icons.room_service,
                                size: 14,
                                color: TAppColors.primary,
                              ),
                              6.0.width,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CommonText(
                                      text: 'SERVICE TYPE',
                                      fontSize: 8,
                                      fontWeight: FontWeight.bold,
                                      fontColor: TAppColors.textHint,
                                      maxLine: 1,
                                      textOverFlow: TextOverflow.ellipsis,
                                    ),
                                    CommonText(
                                      text: state.serviceType,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      maxLine: 1,
                                      textOverFlow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.arrow_drop_down, size: 18),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildTab(
    TransactionCubit cubit,
    TransactionState state,
    TransactionTab tab,
    String label,
    String count,
  ) {
    final isSelected = state.selectedTab == tab;
    return InkWell(
      onTap: () => cubit.setTab(tab),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? TAppColors.primary : TAppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? Colors.transparent : TAppColors.border,
          ),
        ),
        child: Row(
          children: [
            CommonText(
              text: label,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              fontColor: isSelected
                  ? TAppColors.surface
                  : TAppColors.textPrimary,
            ),
            6.0.width,
            CircleAvatar(
              radius: 9,
              backgroundColor: isSelected
                  ? TAppColors.surface.withValues(alpha: 0.24)
                  : TAppColors.border,
              child: CommonText(
                text: count,
                fontSize: 9,
                fontWeight: FontWeight.bold,
                fontColor: isSelected
                    ? TAppColors.surface
                    : TAppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
