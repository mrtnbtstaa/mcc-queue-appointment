class TApi {
  static const login = '/auth/login';
  static const register = '/auth/register';
  static const me = '/auth/me';
  static const logout = '/auth/logout';

  static const studentDashboard = '/student/dashboard';
  static const studentServices = '/student/services';
  static const studentAppointmentDates = '/student/appointments/dates';
  static const studentAppointmentSlots = '/student/appointments/slots';
  static const studentAppointments = '/student/appointments';
  static const studentUpcomingAppointments = '/student/appointments/upcoming';
  static const studentQueue = '/student/queue';
  static const studentTransactions = '/student/transactions';
  static const studentProfile = '/student/profile';
  static const studentChangePassword = '/student/profile/change-password';

  static const staffDashboard = '/staff/dashboard';
  static const staffShift = '/staff/shift';
  static const staffQueue = '/staff/queue';
  static const staffAppointments = '/staff/appointments';
  static const staffSchedules = '/staff/schedules';
  static const staffServices = '/staff/services';
  static const staffStudents = '/staff/students';
  static const staffTransactions = '/staff/transactions';
  static const staffReports = '/staff/reports';

  static String appointment(String id) => '$studentAppointments/$id';
  static String appointmentCancel(String id) =>
      '$studentAppointments/$id/cancel';
  static String appointmentReschedule(String id) =>
      '$studentAppointments/$id/reschedule';
  static String appointmentGatePass(String id) =>
      '$studentAppointments/$id/gate-pass';
  static String transaction(String id) => '$studentTransactions/$id';
  static String staffAppointment(String id) => '$staffAppointments/$id';
  static String staffAppointmentStatus(String id) =>
      '$staffAppointments/$id/status';
  static String staffScheduleSlots(String id) => '$staffSchedules/$id/slots';
  static String staffService(String id) => '$staffServices/$id';
  static String staffStudentStatus(String id) => '$staffStudents/$id/status';
  static String staffTransaction(String id) => '$staffTransactions/$id';
  static String staffReportDownload(String id) => '$staffReports/$id/download';
}
