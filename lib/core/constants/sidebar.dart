import 'package:material_ui/material_ui.dart';

import '../router/app_routes.dart';

class TSidebarMenu {
  final String name;
  final IconData icon;
  final String route;
  TSidebarMenu({required this.name, required this.icon, required this.route});
}

final List<TSidebarMenu> studentSidebarItems = [
  TSidebarMenu(
    name: "Dashboard",
    icon: Icons.dashboard,
    route: AppRoutes.studentHomePath,
  ),
  TSidebarMenu(
    name: "View Registrar Services",
    icon: Icons.grid_view_outlined,
    route: AppRoutes.servicesPath,
  ),
  TSidebarMenu(
    name: "Appointment Schedules",
    icon: Icons.calendar_month_outlined,
    route: AppRoutes.appointmentsPath,
  ),
  TSidebarMenu(
    name: "Queue Status",
    icon: Icons.confirmation_number_outlined,
    route: AppRoutes.queuePath,
  ),
  TSidebarMenu(
    name: "Transaction History",
    icon: Icons.receipt_long_outlined,
    route: AppRoutes.historyPath,
  ),
  TSidebarMenu(
    name: "Profile",
    icon: Icons.manage_accounts_outlined,
    route: AppRoutes.profilePath,
  ),
  TSidebarMenu(
    name: "Log out",
    icon: Icons.logout_outlined,
    route: AppRoutes.logoutPath,
  ),
];

final List<TSidebarMenu> staffSidebarItems = [
  TSidebarMenu(
    name: "Dashboard",
    icon: Icons.dashboard,
    route: AppRoutes.staffHomePath,
  ),
  TSidebarMenu(
    name: "Services",
    icon: Icons.category,
    route: AppRoutes.staffServicesPath,
  ),
  TSidebarMenu(
    name: "Schedules",
    icon: Icons.calendar_month_outlined,
    route: AppRoutes.staffSchedulesPath,
  ),
  TSidebarMenu(
    name: "Appointments",
    icon: Icons.event_available_outlined,
    route: AppRoutes.staffAppointmentsPath,
  ),
  TSidebarMenu(
    name: "Queue Management",
    icon: Icons.confirmation_number_outlined,
    route: AppRoutes.staffQueuePath,
  ),
  TSidebarMenu(
    name: "Transactions",
    icon: Icons.receipt_long_outlined,
    route: AppRoutes.staffTransactionsPath,
  ),
  TSidebarMenu(
    name: "Student Accounts",
    icon: Icons.manage_accounts_outlined,
    route: AppRoutes.staffStudentsPath,
  ),
  TSidebarMenu(
    name: "Reports",
    icon: Icons.analytics_outlined,
    route: AppRoutes.staffReportPath,
  ),
  TSidebarMenu(
    name: "Log out",
    icon: Icons.logout_outlined,
    route: AppRoutes.logoutPath,
  ),
];
