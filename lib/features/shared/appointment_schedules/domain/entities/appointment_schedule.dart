// domain/entities/appointment_schedule.dart

import 'package:equatable/equatable.dart';

class AppointmentSchedule extends Equatable {
  final String? id;
  final String service;
  final String serviceName;
  final String status;
  final String startTime;
  final String endTime;
  final DateTime date;
  final int capacity;
  final int? remainingCapacity;

  const AppointmentSchedule({
    this.id,
    required this.service,
    required this.serviceName,
    required this.status,
    required this.startTime,
    required this.endTime,
    required this.date,
    required this.capacity,
    this.remainingCapacity,
  });

  @override
  List<Object?> get props => [
    id,
    service,
    serviceName,
    status,
    startTime,
    endTime,
    date,
    capacity,
    remainingCapacity,
  ];
}
