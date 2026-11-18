import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../../../core/extensions/double_extension.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../shared/transaction_history/presentation/cubit/transaction_cubit.dart';
import '../../../../../shared/transaction_history/presentation/cubit/transaction_state.dart';
import 'transaction_detail_bottom_sheet.dart';
import 'transaction_item.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionCubit, TransactionState>(
      builder: (context, state) {
        if (state.isLoading && state.transactions.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.error != null && state.transactions.isEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 32),
            child: Center(child: Text(state.error!)),
          );
        }
        final transactions = state.filteredTransactions;
        if (transactions.isEmpty) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 32),
            child: Center(
              child: Text(
                'No services found for this filter.',
                style: TextStyle(fontSize: 13, color: TAppColors.textMuted),
              ),
            ),
          );
        }
        return Column(
          children: [
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: transactions.length,
              separatorBuilder: (_, _) => 12.0.height,
              itemBuilder: (context, index) {
                final item = transactions[index];
                return TransactionItem(
                  onTap: () => TransactionDetailBottomSheet.show(
                    context,
                    transaction: item,
                  ),
                  transaction: item,
                );
              },
            ),
            if (state.isLoading)
              const Padding(
                padding: EdgeInsets.all(16),
                child: Center(child: CircularProgressIndicator()),
              ),
            if (state.error != null)
              TextButton(
                onPressed: context.read<TransactionCubit>().loadMore,
                child: Text(state.error!),
              ),
          ],
        );
      },
    );
  }
}
