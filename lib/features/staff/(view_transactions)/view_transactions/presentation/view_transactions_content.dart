import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../../core/di/injector.dart';
import '../../../../../core/extensions/double_extension.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/common_adaptive_grid.dart';
import '../../../../../core/widgets/common_page_body.dart';
import '../../../../../core/widgets/common_text.dart';
import '../../../../shared/transaction_history/presentation/cubit/transaction_cubit.dart';
import '../../../../shared/transaction_history/presentation/cubit/transaction_state.dart';
import 'widgets/transaction_card_item.dart';
import 'widgets/transactions_filter_section.dart';
import 'widgets/transactions_header.dart';

class ViewTransactionsWrapper extends StatelessWidget {
  const ViewTransactionsWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<TransactionCubit>()..loadTransactions(),
      child: const ViewTransactionsContent(),
    );
  }
}

class ViewTransactionsContent extends StatelessWidget {
  const ViewTransactionsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification.metrics.extentAfter < 300) {
          context.read<TransactionCubit>().loadMore();
        }
        return false;
      },
      child: CommonPageBody(
        child: BlocBuilder<TransactionCubit, TransactionState>(
          builder: (context, state) {
            final list = state.filteredTransactions;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const TransactionsHeader(),
                16.0.height,
                const TransactionsFilterSection(),
                16.0.height,
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 12,
                  runSpacing: 4,
                  children: [
                    CommonText(
                      text: 'Processed Records',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    CommonText(
                      text:
                          'Showing ${list.length} of ${state.transactions.length}',
                      fontSize: 11,
                      fontColor: TAppColors.textHint,
                    ),
                  ],
                ),
                10.0.height,
                CommonAdaptiveGrid(
                  minItemWidth: 520,
                  maxColumns: 2,
                  children: [
                    for (final transaction in list)
                      TransactionCardItem(transaction: transaction),
                  ],
                ),
                if (state.isLoading)
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                20.0.height,
              ],
            );
          },
        ),
      ),
    );
  }
}
