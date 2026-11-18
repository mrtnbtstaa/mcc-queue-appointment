import 'package:equatable/equatable.dart';

class RegistrarReportsState extends Equatable {
  final String dateScope;
  final DateTime dateFrom;
  final DateTime dateTo;
  final bool isGenerating;
  final String? error;
  final String? successMessage;

  const RegistrarReportsState({
    required this.dateScope,
    required this.dateFrom,
    required this.dateTo,
    required this.isGenerating,
    this.error,
    this.successMessage,
  });

  factory RegistrarReportsState.initial() {
    final now = DateTime.now();
    final from = DateTime(now.year, now.month);
    return RegistrarReportsState(
      dateScope: '${_label(from)} - ${_label(now)}',
      dateFrom: from,
      dateTo: now,
      isGenerating: false,
    );
  }

  RegistrarReportsState copyWith({
    String? dateScope,
    DateTime? dateFrom,
    DateTime? dateTo,
    bool? isGenerating,
    String? error,
    bool clearError = false,
    String? successMessage,
    bool clearSuccess = false,
  }) => RegistrarReportsState(
    dateScope: dateScope ?? this.dateScope,
    dateFrom: dateFrom ?? this.dateFrom,
    dateTo: dateTo ?? this.dateTo,
    isGenerating: isGenerating ?? this.isGenerating,
    error: clearError ? null : error ?? this.error,
    successMessage: clearSuccess ? null : successMessage ?? this.successMessage,
  );

  @override
  List<Object?> get props => [
    dateScope,
    dateFrom,
    dateTo,
    isGenerating,
    error,
    successMessage,
  ];
}

String _label(DateTime date) =>
    '${_month(date.month)} ${date.day}, ${date.year}';

String _month(int month) => const [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December',
][month - 1];
