import 'package:equatable/equatable.dart';

enum QueueTab { waiting, serving, done, skipped }

enum QueueStatus { waiting, serving, done, skipped }

QueueStatus queueStatusFromApi(String? value) {
  return switch (value?.toUpperCase()) {
    'SERVING' => QueueStatus.serving,
    'COMPLETED' || 'DONE' => QueueStatus.done,
    'SKIPPED' => QueueStatus.skipped,
    _ => QueueStatus.waiting,
  };
}

extension QueueStatusX on QueueStatus {
  String get apiValue => switch (this) {
    QueueStatus.waiting => 'WAITING',
    QueueStatus.serving => 'SERVING',
    QueueStatus.done => 'COMPLETED',
    QueueStatus.skipped => 'SKIPPED',
  };

  String get label => switch (this) {
    QueueStatus.waiting => 'Waiting',
    QueueStatus.serving => 'Serving',
    QueueStatus.done => 'Completed',
    QueueStatus.skipped => 'Skipped',
  };
}

DateTime? _dateTime(Object? value) =>
    value == null ? null : DateTime.tryParse(value.toString());

class QueueItemModel extends Equatable {
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
  final DateTime? queueDate;
  final QueueStatus status;
  final int position;
  final bool isMine;
  final DateTime? calledAt;
  final DateTime? completedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const QueueItemModel({
    required this.id,
    this.appointment = '',
    this.appointmentCode = '',
    this.studentName = '',
    this.studentId = '',
    this.course = '',
    this.yearLevel = '',
    this.serviceName = '',
    this.slotSchedule = '',
    required this.queueNumber,
    this.queueDate,
    required this.status,
    this.position = 0,
    this.isMine = false,
    this.calledAt,
    this.completedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory QueueItemModel.fromJson(Map<String, dynamic> json) {
    return QueueItemModel(
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
      queueDate: _dateTime(json['queue_date']),
      status: queueStatusFromApi(json['status']?.toString()),
      position: (json['position'] as num?)?.toInt() ?? 0,
      isMine: json['is_mine'] == true,
      calledAt: _dateTime(json['called_at']),
      completedAt: _dateTime(json['completed_at']),
      createdAt: _dateTime(json['created_at']),
      updatedAt: _dateTime(json['updated_at']),
    );
  }

  String get service => serviceName;

  String? get appointmentTime => slotSchedule.isEmpty ? null : slotSchedule;

  // No priority flag exists in the backend yet.
  bool get isPriority => false;

  String get statusLabel => status.label;

  String get waitTime {
    final since = status == QueueStatus.serving ? calledAt : createdAt;
    if (since == null) return '';

    final elapsed = DateTime.now().difference(since);
    if (elapsed.inMinutes < 1) return 'Just now';
    if (elapsed.inHours < 1) return '${elapsed.inMinutes}m elapsed';
    return '${elapsed.inHours}h ${elapsed.inMinutes % 60}m elapsed';
  }

  QueueItemModel copyWith({QueueStatus? status}) {
    return QueueItemModel(
      id: id,
      appointment: appointment,
      appointmentCode: appointmentCode,
      studentName: studentName,
      studentId: studentId,
      course: course,
      yearLevel: yearLevel,
      serviceName: serviceName,
      slotSchedule: slotSchedule,
      queueNumber: queueNumber,
      queueDate: queueDate,
      status: status ?? this.status,
      position: position,
      isMine: isMine,
      calledAt: calledAt,
      completedAt: completedAt,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
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
    queueDate,
    status,
    position,
    isMine,
    calledAt,
    completedAt,
    createdAt,
    updatedAt,
  ];
}
