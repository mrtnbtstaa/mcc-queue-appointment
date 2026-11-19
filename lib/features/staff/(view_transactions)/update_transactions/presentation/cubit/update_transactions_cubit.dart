import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/errors/failure.dart';
import '../../../../../shared/transaction_history/domain/usecases/get_transaction.dart';
import '../../../../../shared/transaction_history/domain/usecases/set_transaction_status.dart';
import 'update_transactions_state.dart';

class UpdateTransactionCubit extends Cubit<UpdateTransactionState> {
  final String transactionId;
  final GetTransaction getTransaction;
  final SetTransactionStatus setTransactionStatus;

  UpdateTransactionCubit({
    required this.transactionId,
    required this.getTransaction,
    required this.setTransactionStatus,
  }) : super(UpdateTransactionState.initial());

  Future<void> load() async {
    final result = await getTransaction(transactionId);
    if (isClosed) return;
    result.fold(
      (failure) => emit(
        state.copyWith(isLoading: false, error: failureMessage(failure)),
      ),
      (transaction) =>
          emit(UpdateTransactionState.fromTransaction(transaction)),
    );
  }

  void setStatus(String status) => emit(state.copyWith(selectedStatus: status));
  void setTargetCounter(String counter) =>
      emit(state.copyWith(targetCounter: counter));
  void setRemarks(String remarks) => emit(state.copyWith(remarksText: remarks));
  void toggleDispatch(bool enabled) =>
      emit(state.copyWith(isMultiChannelDispatchEnabled: enabled));

  Future<void> saveUpdate() async {
    if (state.selectedStatus.isEmpty) {
      emit(state.copyWith(error: 'Select a transaction status.'));
      return;
    }
    emit(
      state.copyWith(
        isSaving: true,
        clearError: true,
        clearSuccessMessage: true,
      ),
    );
    final result = await setTransactionStatus(
      SetTransactionStatusParams(
        id: transactionId,
        status: state.selectedStatus,
        remarks: state.remarksText,
      ),
    );
    if (isClosed) return;
    result.fold(
      (failure) =>
          emit(state.copyWith(isSaving: false, error: failureMessage(failure))),
      (transaction) => emit(
        UpdateTransactionState.fromTransaction(transaction)
            .copyWith(successMessage: 'Transaction status updated.'),
      ),
    );
  }
}
