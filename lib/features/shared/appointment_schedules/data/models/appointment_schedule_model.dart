// data/models/appointment_schedule_model.dart

import '../../domain/entities/appointment_schedule.dart';

class AppointmentScheduleModel extends AppointmentSchedule {
  const AppointmentScheduleModel({
    required super.id,
    required super.status,
    required super.startTime,
    required super.endTime,
    required super.date,
    required super.capacity,
    super.remainingCapacity,
    required super.service,
    required super.serviceName,
  });

  factory AppointmentScheduleModel.fromJson(Map<String, dynamic> json) {
    return AppointmentScheduleModel(
      id: json['id'] ?? '',
      status: json['status'] ?? '',
      startTime: json['start_time'] ?? '',
      endTime: json['end_time'] ?? '',
      date: DateTime.parse(json['appointment_date']),
      capacity: json['capacity'] ?? 0,
      remainingCapacity: json['remaining_capacity'] as int?,
      service: json['service'] ?? '',
      serviceName: json["service_name"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'service': serviceName,
      'appointment_date': _appointmentDate,
      'start_time': startTime,
      'end_time': endTime,
      'capacity': capacity,
      'status': status,
    };
  }

  // The API binds service by name (slug_field="name"), not by PK.
  Map<String, dynamic> toUpdateJson() => {
    'service': serviceName,
    'appointment_date': _appointmentDate,
    'start_time': startTime,
    'end_time': endTime,
    'capacity': capacity,
  };

  String get _appointmentDate =>
      '${date.year.toString().padLeft(4, '0')}-'
      '${date.month.toString().padLeft(2, '0')}-'
      '${date.day.toString().padLeft(2, '0')}';
}
