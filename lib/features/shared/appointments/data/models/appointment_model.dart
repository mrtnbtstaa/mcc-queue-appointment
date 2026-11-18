import '../../domain/entities/appointment.dart';

class AppointmentModel extends Appointment {
  const AppointmentModel({
    required super.id,
    required super.service,
    required super.slot,
    required super.status,
    super.appointmentCode,
    super.userName,
    super.userEmail,
    super.studentId,
    super.course,
    super.yearLevel,
    super.serviceName,
    super.slotLabel,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      id: json['id']?.toString() ?? '',
      service: json['service']?.toString() ?? '',
      slot: json['slot']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      appointmentCode: json['appointment_code']?.toString() ?? '',
      userName: json['user_name']?.toString() ?? '',
      userEmail: json['user_email']?.toString() ?? '',
      studentId: json['student_id']?.toString() ?? '',
      course: json['course']?.toString() ?? '',
      yearLevel: json['year_level']?.toString() ?? '',
      serviceName: json['service_name']?.toString() ?? '',
      slotLabel: json['slot_schedule']?.toString() ?? '',
    );
  }

  factory AppointmentModel.fromEntity(Appointment entity) {
    return AppointmentModel(
      id: entity.id,
      service: entity.service,
      slot: entity.slot,
      status: entity.status,
      appointmentCode: entity.appointmentCode,
      userName: entity.userName,
      userEmail: entity.userEmail,
      studentId: entity.studentId,
      course: entity.course,
      yearLevel: entity.yearLevel,
      serviceName: entity.serviceName,
      slotLabel: entity.slotLabel,
    );
  }

  Map<String, dynamic> toJson() {
    return {'service': service, 'slot': slot, 'status': status};
  }
}
