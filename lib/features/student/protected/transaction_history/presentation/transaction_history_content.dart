import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../../core/di/injector.dart';
import '../../../../../core/extensions/double_extension.dart';
import '../../../../../core/widgets/common_page_body.dart';
import '../../../../shared/transaction_history/presentation/cubit/transaction_cubit.dart';
import '../../../../shared/transaction_history/presentation/cubit/transaction_state.dart';
import 'widgets/transaction_filter_tabs.dart';
import 'widgets/transaction_header.dart';
import 'widgets/transaction_list.dart';
import 'widgets/transaction_search_filter.dart';

class TransactionWrapper extends StatelessWidget {
  const TransactionWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<TransactionCubit>()..loadTransactions(),
      child: const TransactionHistoryContent(),
    );
  }
}

class TransactionHistoryContent extends StatelessWidget {
  const TransactionHistoryContent({super.key});

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const TransactionHeader(),
            16.0.height,
            BlocBuilder<TransactionCubit, TransactionState>(
              builder: (context, state) {
                return TransactionFilterTabs(
                  selectedFilterIndex: state.selectedFilterIndex,
                  onFilterChanged: (index) =>
                      context.read<TransactionCubit>().changeFilter(index),
                );
              },
            ),
            16.0.height,
            BlocBuilder<TransactionCubit, TransactionState>(
              builder: (context, state) {
                return TransactionSearchFilter(
                  onSearchChanged: (query) =>
                      context.read<TransactionCubit>().setSearchQuery(query),
                );
              },
            ),
            16.0.height,
            // Transaction Items List
            const TransactionList(),
            20.0.height,
          ],
        ),
      ),
    );
  }
}
