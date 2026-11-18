import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:printing/printing.dart';

import '../../../../../core/network/api_client.dart';
import '../../../../../core/network/api_result.dart';
import 'reports_state.dart';

class RegistrarReportsCubit extends Cubit<RegistrarReportsState> {
  final ApiClient apiClient;

  RegistrarReportsCubit(this.apiClient)
    : super(RegistrarReportsState.initial());

  void setDateRange(DateTimeRange range) {
    final from = DateTime(range.start.year, range.start.month, range.start.day);
    final to = DateTime(range.end.year, range.end.month, range.end.day);
    emit(
      state.copyWith(
        dateFrom: from,
        dateTo: to,
        dateScope: '${_format(from)} - ${_format(to)}',
        clearError: true,
      ),
    );
  }

  Future<void> generateReport() async {
    if (state.dateTo.isBefore(state.dateFrom)) {
      emit(state.copyWith(error: 'End date must be on or after start date.'));
      return;
    }
    emit(
      state.copyWith(isGenerating: true, clearError: true, clearSuccess: true),
    );
    final result = await apiClient.getBytes(
      'v1/reports/summary/',
      query: {
        'date_from': _isoDate(state.dateFrom),
        'date_to': _isoDate(state.dateTo),
      },
    );
    if (isClosed) return;
    switch (result) {
      case ApiFailure(:final error):
        emit(state.copyWith(isGenerating: false, error: _errorText(error)));
      case ApiSuccess(:final data):
        if (data.length < 4 || ascii.decode(data.take(4).toList()) != '%PDF') {
          emit(
            state.copyWith(
              isGenerating: false,
              error: 'The report response was not a valid PDF.',
            ),
          );
          return;
        }
        try {
          await Printing.sharePdf(
            bytes: data,
            filename:
                'appointments-transactions-${_isoDate(state.dateFrom)}-${_isoDate(state.dateTo)}.pdf',
          );
          if (!isClosed) {
            emit(
              state.copyWith(
                isGenerating: false,
                successMessage: 'PDF report is ready to save or share.',
              ),
            );
          }
        } catch (error) {
          if (!isClosed) {
            emit(state.copyWith(isGenerating: false, error: error.toString()));
          }
        }
    }
  }

  static String _isoDate(DateTime date) =>
      '${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

  static String _format(DateTime date) =>
      '${date.month}/${date.day}/${date.year}';

  static String _errorText(dynamic error) {
    final details = error.details;
    if (details is Map && details.isNotEmpty) {
      return details.values
          .expand((value) => value is List ? value : [value])
          .join(', ');
    }
    return error.message?.toString() ?? 'Unable to generate the report.';
  }
}
