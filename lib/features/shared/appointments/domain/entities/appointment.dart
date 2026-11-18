class Appointment {
  final String id;
  final String service;
  final String slot;
  final String status;
  final String appointmentCode;
  final String userName;
  final String userEmail;
  final String studentId;
  final String course;
  final String yearLevel;
  final String serviceName;
  final String slotLabel;

  const Appointment({
    required this.id,
    required this.service,
    required this.slot,
    required this.status,
    this.appointmentCode = '',
    this.userName = '',
    this.userEmail = '',
    this.studentId = '',
    this.course = '',
    this.yearLevel = '',
    this.serviceName = '',
    this.slotLabel = '',
  });
}
