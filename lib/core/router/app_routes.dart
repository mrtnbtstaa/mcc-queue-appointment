class AppRoutes {
  /* -------------  AUTH ROUTES ------------------ */
  static const String loginName = 'login';
  static const String loginPath = '/login';

  static const String registerName = 'register';
  static const String registerPath = '/register';

  static const String logoutName = 'logout';
  static const String logoutPath = '/logout';
  /* -------------  AUTH ROUTES ------------------ */

  /* -------------  STUDENT ROUTES ------------------ */
  static const String studentHomeName = 'student-home';
  static const String studentHomePath = '/student';

  static const String appointmentDetailsName = 'appointment-details';
  static const String appointmentDetailsPath = '/student/appointments/details';

  static const String appointmentsName = 'student-appointments';
  static const String appointmentsPath = '/student/appointments';

  static const String servicesName = 'student-services';
  static const String servicesPath = '/student/services';

  static const String queueName = 'student-queue';
  static const String queuePath = '/student/queue';

  static const String historyName = 'student-transactions';
  static const String historyPath = '/student/history';

  static const String profileName = 'student-profile';
  static const String profilePath = '/student/profile';
  /* -------------  STUDENT ROUTES ------------------ */

  /* -------------  STAFF ROUTES ------------------ */
  static const String staffHomeName = 'staff-home';
  static const String staffHomePath = '/staff';

  static const String staffServicesName = 'staff-services';
  static const String staffServicesPath = '/staff/services';

  static const String staffSchedulesName = 'staff-schedules';
  static const String staffSchedulesPath = '/staff/schedules';

  static const String staffAppointmentsName = 'staff-appointments';
  static const String staffAppointmentsPath = '/staff/appointments';

  static const String staffQueueName = 'staff-queue';
  static const String staffQueuePath = '/staff/queue';

  static const String staffTransactionsName = 'staff-transactions';
  static const String staffTransactionsPath = '/staff/transactions';

  static const String staffTransactionUpdateName = 'staff-transaction-update';
  static const String staffTransactionUpdatePath =
      '/staff/transactions/:id/update';

  static const String staffStudentsName = 'staff-students';
  static const String staffStudentsPath = '/staff/students';

  static const String staffStudentDetailName = 'staff-student-detail';
  static const String staffStudentDetailPath = '/staff/students/:id';

  static const String staffReportName = 'staff-reports';
  static const String staffReportPath = '/staff/reports';

  static const String staffProfileName = 'staff-profile';
  static const String staffProfilePath = '/staff/profile';
  /* -------------  STAFF ROUTES ------------------ */
}
