import 'package:equatable/equatable.dart';

import '../../../../../shared/transaction_history/domain/entities/transaction_entity.dart';

class UpdateTransactionState extends Equatable {
  final String transactionRef;
  final String studentName;
  final String studentId;
  final String course;
  final String requestedService;
  final String dateSubmitted;
  final String assignedEvaluator;
  final String currentStatus;
  final String selectedStatus;
  final String targetCounter;
  final String remarksText;
  final bool isMultiChannelDispatchEnabled;
  final bool isLoading;
  final bool isSaving;
  final String? error;
  final String? successMessage;

  const UpdateTransactionState({
    required this.transactionRef,
    required this.studentName,
    required this.studentId,
    required this.course,
    required this.requestedService,
    required this.dateSubmitted,
    required this.assignedEvaluator,
    required this.currentStatus,
    required this.selectedStatus,
    required this.targetCounter,
    required this.remarksText,
    required this.isMultiChannelDispatchEnabled,
    this.isLoading = true,
    this.isSaving = false,
    this.error,
    this.successMessage,
  });

  factory UpdateTransactionState.initial() => const UpdateTransactionState(
    transactionRef: '',
    studentName: '',
    studentId: '',
    course: '',
    requestedService: '',
    dateSubmitted: '',
    assignedEvaluator: '',
    currentStatus: '',
    selectedStatus: 'In Progress',
    targetCounter: 'Registrar Window',
    remarksText: '',
    isMultiChannelDispatchEnabled: false,
  );

  factory UpdateTransactionState.fromTransaction(TransactionEntity value) =>
      UpdateTransactionState(
        transactionRef: value.appointmentCode,
        studentName: value.studentName,
        studentId: value.studentId,
        course: '${value.course.toUpperCase()} - Year ${value.yearLevel}',
        requestedService: value.serviceName,
        dateSubmitted: value.date,
        assignedEvaluator: value.processedByName,
        currentStatus: value.statusText,
        selectedStatus: switch (value.transactionStatus) {
          'COMPLETED' => 'Completed',
          'CANCELLED' => 'Cancelled',
          'PROCESSING' => 'Ready for Release',
          _ => 'In Progress',
        },
        targetCounter: 'Registrar Window',
        remarksText: value.remarks ?? '',
        isMultiChannelDispatchEnabled: false,
        isLoading: false,
      );

  UpdateTransactionState copyWith({
    String? selectedStatus,
    String? targetCounter,
    String? remarksText,
    bool? isMultiChannelDispatchEnabled,
    bool? isLoading,
    bool? isSaving,
    String? error,
    bool clearError = false,
    String? successMessage,
    bool clearSuccessMessage = false,
  }) => UpdateTransactionState(
    transactionRef: transactionRef,
    studentName: studentName,
    studentId: studentId,
    course: course,
    requestedService: requestedService,
    dateSubmitted: dateSubmitted,
    assignedEvaluator: assignedEvaluator,
    currentStatus: currentStatus,
    selectedStatus: selectedStatus ?? this.selectedStatus,
    targetCounter: targetCounter ?? this.targetCounter,
    remarksText: remarksText ?? this.remarksText,
    isMultiChannelDispatchEnabled:
        isMultiChannelDispatchEnabled ?? this.isMultiChannelDispatchEnabled,
    isLoading: isLoading ?? this.isLoading,
    isSaving: isSaving ?? this.isSaving,
    error: clearError ? null : error ?? this.error,
    successMessage: clearSuccessMessage
        ? null
        : successMessage ?? this.successMessage,
  );

  @override
  List<Object?> get props => [
    transactionRef,
    studentName,
    studentId,
    course,
    requestedService,
    dateSubmitted,
    assignedEvaluator,
    currentStatus,
    selectedStatus,
    targetCounter,
    remarksText,
    isMultiChannelDispatchEnabled,
    isLoading,
    isSaving,
    error,
    successMessage,
  ];
}
