import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../../core/theme/app_colors.dart';

enum TransactionTab { allRecords, completed, inProgress }

class TimelineStepModel {
  final String title;
  final String subtitle;
  final bool isCompleted;
  final bool isInProgress;

  const TimelineStepModel({
    required this.title,
    required this.subtitle,
    this.isCompleted = false,
    this.isInProgress = false,
  });
}

class TransactionEntity extends Equatable {
  final String id;
  final String appointment;
  final String appointmentCode;
  final String studentName;
  final String studentId;
  final String course;
  final String yearLevel;
  final String serviceName;
  final String slotSchedule;
  final String queueNumber;
  final String processedBy;
  final String processedByName;
  final String transactionStatus;
  final String transactionStatusDisplay;
  final String? remarks;
  final DateTime? processedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const TransactionEntity({
    required this.id,
    this.appointment = '',
    this.appointmentCode = '',
    this.studentName = '',
    this.studentId = '',
    this.course = '',
    this.yearLevel = '',
    this.serviceName = '',
    this.slotSchedule = '',
    this.queueNumber = '',
    this.processedBy = '',
    this.processedByName = '',
    this.transactionStatus = 'PENDING',
    this.transactionStatusDisplay = '',
    this.remarks,
    this.processedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory TransactionEntity.fromJson(Map<String, dynamic> json) {
    return TransactionEntity(
      id: json['id']?.toString() ?? '',
      appointment: json['appointment']?.toString() ?? '',
      appointmentCode: json['appointment_code']?.toString() ?? '',
      studentName: json['student_name']?.toString() ?? '',
      studentId: json['student_id']?.toString() ?? '',
      course: json['course']?.toString() ?? '',
      yearLevel: json['year_level']?.toString() ?? '',
      serviceName: json['service_name']?.toString() ?? '',
      slotSchedule: json['slot_schedule']?.toString() ?? '',
      queueNumber: json['queue_number']?.toString() ?? '',
      processedBy: json['processed_by']?.toString() ?? '',
      processedByName: json['processed_by_name']?.toString() ?? '',
      transactionStatus: json['transaction_status']?.toString() ?? 'PENDING',
      transactionStatusDisplay:
          json['transaction_status_display']?.toString() ?? '',
      remarks: json['remarks']?.toString(),
      processedAt: _dateTime(json['processed_at']),
      createdAt: _dateTime(json['created_at']),
      updatedAt: _dateTime(json['updated_at']),
    );
  }

  // ---- backend-shaped values -------------------------------------------

  bool get isCompleted => transactionStatus == 'COMPLETED';
  bool get isCancelled => transactionStatus == 'CANCELLED';
  bool get isInProgress =>
      transactionStatus == 'PENDING' || transactionStatus == 'PROCESSING';

  // ---- display values used by the shared staff/student widgets ---------

  String get refNo => appointmentCode;

  String get queueNo => queueNumber.isEmpty ? '—' : queueNumber;

  String get queueInfo => queueNo;

  String get title => serviceName.isEmpty ? 'Registrar Service' : serviceName;

  String get service => serviceName;

  String get date => _formatDate(createdAt ?? processedAt);

  String get dateStr => date;

  String get statusText {
    if (transactionStatusDisplay.isNotEmpty) return transactionStatusDisplay;
    return switch (transactionStatus) {
      'PROCESSING' => 'Processing',
      'COMPLETED' => 'Completed',
      'CANCELLED' => 'Cancelled',
      _ => 'Pending',
    };
  }

  Color get statusBgColor => switch (transactionStatus) {
    'COMPLETED' => TAppColors.statusOpenBg,
    'CANCELLED' => TAppColors.errorBg,
    'PROCESSING' => const Color(0xFFFEF3C7),
    _ => const Color(0xFFFEF3C7),
  };

  Color get statusTextColor => switch (transactionStatus) {
    'COMPLETED' => TAppColors.statusOpenText,
    'CANCELLED' => TAppColors.errorText,
    'PROCESSING' => const Color(0xFF92400E),
    _ => const Color(0xFF92400E),
  };

  IconData get icon {
    final name = serviceName.toLowerCase();
    if (name.contains('transcript')) {
      return Icons.description_outlined;
    }
    if (name.contains('certificate')) {
      return Icons.workspace_premium_outlined;
    }
    if (name.contains('enroll') || name.contains('registration')) {
      return Icons.school_outlined;
    }
    return Icons.assignment_outlined;
  }

  Color get iconColor => isCompleted
      ? TAppColors.statusOpenText
      : isCancelled
      ? TAppColors.errorText
      : TAppColors.primary;

  String get staffRemarks {
    final value = remarks?.trim();
    return value == null || value.isEmpty
        ? 'No staff remarks recorded for this transaction.'
        : value;
  }

  String get evaluator {
    final value = processedByName.trim();
    return value.isEmpty ? 'Registrar Staff' : value;
  }

  String get windowAndStaff =>
      processedByName.trim().isEmpty ? 'Unassigned' : processedByName;

  String? get paymentInfo => null;

  String? get remark => remarks;

  List<TimelineStepModel> get progressionSteps {
    final steps = <TimelineStepModel>[
      TimelineStepModel(
        title: 'Submitted',
        subtitle: _formatDate(createdAt),
        isCompleted: true,
      ),
    ];

    if (isCancelled) {
      steps.add(
        TimelineStepModel(
          title: 'Cancelled',
          subtitle: remarks?.trim().isNotEmpty == true
              ? remarks!.trim()
              : 'Transaction cancelled.',
          isCompleted: true,
        ),
      );
      return steps;
    }

    steps.add(
      TimelineStepModel(
        title: 'Processing / Under Evaluation',
        subtitle: isCompleted
            ? 'Processed by $evaluator'
            : isInProgress
            ? 'In progress at $evaluator'
            : 'Awaiting registrar action',
        isCompleted: isCompleted,
        isInProgress: isInProgress,
      ),
    );

    steps.add(
      TimelineStepModel(
        title: 'Completed',
        subtitle: isCompleted
            ? _formatDate(processedAt ?? updatedAt)
            : 'Estimated after processing',
        isCompleted: isCompleted,
      ),
    );

    return steps;
  }

  @override
  List<Object?> get props => [
    id,
    appointment,
    appointmentCode,
    studentName,
    studentId,
    course,
    yearLevel,
    serviceName,
    slotSchedule,
    queueNumber,
    processedBy,
    processedByName,
    transactionStatus,
    transactionStatusDisplay,
    remarks,
    processedAt,
    createdAt,
    updatedAt,
  ];
}

DateTime? _dateTime(Object? value) =>
    value == null ? null : DateTime.tryParse(value.toString());

String _formatDate(DateTime? value) {
  if (value == null) return '—';
  return DateFormat('MMM d, yyyy • hh:mm a').format(value.toLocal());
}
