import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../../../core/di/injector.dart';
import '../../../../../../core/extensions/double_extension.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/common_elevated_button.dart';
import '../../../../../../core/widgets/common_snackbar.dart';
import '../../../../../../core/widgets/common_text.dart';
import '../../../../../../features/shared/transaction_history/domain/usecases/get_transaction.dart';
import '../../../../../../features/shared/transaction_history/domain/usecases/set_transaction_status.dart';
import 'cubit/update_transactions_cubit.dart';
import 'cubit/update_transactions_state.dart';
import 'widgets/transaction_summary_card.dart';
import 'widgets/update_status_form_card.dart';

class UpdateTransactionWrapper extends StatelessWidget {
  final String transactionId;
  const UpdateTransactionWrapper({super.key, required this.transactionId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdateTransactionCubit(
        transactionId: transactionId,
        getTransaction: getIt<GetTransaction>(),
        setTransactionStatus: getIt<SetTransactionStatus>(),
      )..load(),
      child: const UpdateTransactionScreen(),
    );
  }
}

class UpdateTransactionScreen extends StatelessWidget {
  const UpdateTransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UpdateTransactionCubit>();

    return Scaffold(
      backgroundColor: TAppColors.background,
      appBar: AppBar(
        backgroundColor: TAppColors.surface,
        elevation: 0,
        title: CommonText(
          text: 'Request Progression Workflow',
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontColor: TAppColors.textPrimary,
        ),
        iconTheme: const IconThemeData(color: TAppColors.textPrimary),
      ),
      body: BlocListener<UpdateTransactionCubit, UpdateTransactionState>(
        listenWhen: (previous, current) =>
            previous.error != current.error && current.error != null ||
            previous.successMessage != current.successMessage &&
                current.successMessage != null,
        listener: (context, state) {
          if (state.error != null) {
            CommonSnackbar.showError(context, state.error!);
          } else if (state.successMessage != null) {
            CommonSnackbar.showSuccess(context, state.successMessage!);
            Navigator.of(context).pop();
          }
        },
        child: BlocBuilder<UpdateTransactionCubit, UpdateTransactionState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.error != null && state.transactionRef.isEmpty) {
              return Center(child: CommonText(text: state.error!));
            }
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.verified,
                        size: 14,
                        color: TAppColors.primary,
                      ),
                      6.0.width,
                      CommonText(
                        text:
                            'Official Request Progression & Dispatch Workflow',
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        fontColor: TAppColors.primary,
                      ),
                    ],
                  ),
                  4.0.height,
                  CommonText(
                    text: 'Update official request progression, staff evaluation notes, and dispatch student alerts.',
                    fontSize: 11,
                    fontColor: TAppColors.textSecondary,
                  ),
                  16.0.height,
                  const TransactionSummaryCard(),
                  16.0.height,
                  const UpdateStatusFormCard(),
                  16.0.height,
                  CommonElevatedButton(
                    text: 'Save & Update Transaction Status',
                    backgroundColor: TAppColors.primary,
                    onButtonPressed: state.isSaving ? null : cubit.saveUpdate,
                  ),
                  10.0.height,
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: TAppColors.border),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: CommonText(
                        text: 'Cancel Changes',
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        fontColor: TAppColors.textPrimary,
                      ),
                    ),
                  ),
                  20.0.height,
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
