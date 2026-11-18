import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../features/auth/login/presentation/login_page.dart';
import '../../features/auth/register/presentation/register_page.dart';
import '../../features/shared/profile/presentation/profile_page.dart';
import '../../features/staff/(view_transactions)/update_transactions/presentation/update_transactions_page.dart';
import '../../features/staff/(view_transactions)/view_transactions/presentation/view_transactions_content.dart';
import '../../features/staff/appointment_schedules/presentation/appointment_schedule_content.dart';
import '../../features/staff/dashboard/presentation/dashboard_content.dart';
import '../../features/staff/manage_queue/presentation/manage_queue_content.dart';
import '../../features/staff/reports/presentation/reports_page.dart';
import '../../features/staff/services/presentation/services_content.dart';
import '../../features/staff/students/presentation/student_detail_page.dart';
import '../../features/staff/students/presentation/students_page.dart';
import '../../features/staff/view_appointments/presentation/view_appointments_content.dart';
import '../../features/student/protected/appointment_schedule/appointment/presentation/appointment_schedule_content.dart';
import '../../features/student/protected/appointment_schedule/appointment_details/presentation/appointment_details_page.dart';
import '../../features/student/protected/dashboard/presentation/dashboard_content.dart';
import '../../features/student/protected/queue/presentation/queue_content.dart';
import '../../features/student/protected/services/presentation/services_content.dart';
import '../../features/student/protected/transaction_history/presentation/transaction_history_content.dart';
import '../auth/auth_state.dart';
import '../constants/navigation.dart';
import '../constants/sidebar.dart';
import '../widgets/app_shell.dart';
import '../widgets/common_text.dart';
import 'app_routes.dart';

class AppRouter {
  AppRouter._();

  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');

  /// Builds the router. Must be called exactly once, after
  /// [configureDependencies] has completed, so [authState] is the DI-owned
  /// singleton.
  static GoRouter build({required AuthState authState}) {
    return GoRouter(
      navigatorKey: rootNavigatorKey,
      initialLocation: '/',
      debugLogDiagnostics: kDebugMode,
      refreshListenable: authState,
      redirect: (context, state) => _redirect(authState, state),
      routes: _routes(),
      errorBuilder: (context, state) => Scaffold(
        body: Center(
          child: CommonText(
            text: 'Page not found: ${state.uri.toString()}',
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  static String? _redirect(AuthState authState, GoRouterState state) {
    final path = state.uri.path;
    final isSignedIn = authState.isSignedIn;
    final isAuthPath =
        path == AppRoutes.loginPath || path == AppRoutes.registerPath;

    // Unauthenticated: only auth pages are reachable.
    if (!isSignedIn) {
      return isAuthPath ? null : AppRoutes.loginPath;
    }

    // Authenticated on an auth page or root → send to role home.
    if (isAuthPath || path == '/') {
      return authState.role == UserRole.staff
          ? AppRoutes.staffHomePath
          : AppRoutes.studentHomePath;
    }

    // Block cross-role access.
    final isStaffPath = path.startsWith('/staff');
    final isStudentPath = path.startsWith('/student');

    if (authState.role == UserRole.staff && isStudentPath) {
      return AppRoutes.staffHomePath;
    }
    if (authState.role == UserRole.student && isStaffPath) {
      return AppRoutes.studentHomePath;
    }

    return null;
  }

  static List<RouteBase> _routes() => [
    GoRoute(
      name: AppRoutes.loginName,
      path: AppRoutes.loginPath,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      name: AppRoutes.registerName,
      path: AppRoutes.registerPath,
      builder: (context, state) => const RegisterPage(),
    ),

    // Student area
    ShellRoute(
      builder: (context, state, child) => AppShell(
        menuItems: studentSidebarItems,
        bottomItems: studentNavigations,
        child: child,
      ),
      routes: [
        GoRoute(
          name: AppRoutes.studentHomeName,
          path: AppRoutes.studentHomePath,
          builder: (context, state) => const DashboardContent(),
        ),
        GoRoute(
          name: AppRoutes.servicesName,
          path: AppRoutes.servicesPath,
          builder: (context, state) => const ServicesWrapper(),
        ),
        GoRoute(
          name: AppRoutes.appointmentsName,
          path: AppRoutes.appointmentsPath,
          builder: (context, state) =>
              const AppointmentScheduleStudentWrapper(),
        ),
        GoRoute(
          name: AppRoutes.appointmentDetailsName,
          path: AppRoutes.appointmentDetailsPath,
          builder: (context, state) => const AppointmentDetailsWrapper(),
        ),
        GoRoute(
          name: AppRoutes.queueName,
          path: AppRoutes.queuePath,
          builder: (context, state) => const QueueContent(),
        ),
        GoRoute(
          name: AppRoutes.historyName,
          path: AppRoutes.historyPath,
          builder: (context, state) => const TransactionWrapper(),
        ),
        GoRoute(
          name: AppRoutes.profileName,
          path: AppRoutes.profilePath,
          builder: (context, state) => const ProfileWrapper(),
        ),
      ],
    ),

    // Staff area
    ShellRoute(
      builder: (context, state, child) => AppShell(
        menuItems: staffSidebarItems,
        bottomItems: staffNavigations,
        child: child,
      ),
      routes: [
        GoRoute(
          name: AppRoutes.staffHomeName,
          path: AppRoutes.staffHomePath,
          builder: (context, state) => const StaffDashoardWrapper(),
        ),
        GoRoute(
          name: AppRoutes.staffServicesName,
          path: AppRoutes.staffServicesPath,
          builder: (context, state) => const StaffServicesWrapper(),
        ),
        GoRoute(
          name: AppRoutes.staffSchedulesName,
          path: AppRoutes.staffSchedulesPath,
          builder: (context, state) => const AppointmentScheduleWrapper(),
        ),
        GoRoute(
          name: AppRoutes.staffAppointmentsName,
          path: AppRoutes.staffAppointmentsPath,
          builder: (context, state) => const ViewAppointmentsWrapper(),
        ),
        GoRoute(
          name: AppRoutes.staffQueueName,
          path: AppRoutes.staffQueuePath,
          builder: (context, state) => const ManageQueueWrapper(),
        ),
        GoRoute(
          name: AppRoutes.staffTransactionsName,
          path: AppRoutes.staffTransactionsPath,
          builder: (context, state) => const ViewTransactionsWrapper(),
        ),
        GoRoute(
          name: AppRoutes.staffTransactionUpdateName,
          path: AppRoutes.staffTransactionUpdatePath,
          builder: (context, state) => UpdateTransactionWrapper(
            transactionId: state.pathParameters['id']!,
          ),
        ),
        GoRoute(
          name: AppRoutes.staffStudentsName,
          path: AppRoutes.staffStudentsPath,
          builder: (context, state) => const RegisteredStudentsWrapper(),
        ),
        GoRoute(
          name: AppRoutes.staffStudentDetailName,
          path: AppRoutes.staffStudentDetailPath,
          builder: (context, state) =>
              StudentDetailPage(id: state.pathParameters['id']!),
        ),
        GoRoute(
          name: AppRoutes.staffReportName,
          path: AppRoutes.staffReportPath,
          builder: (context, state) => const RegistrarReportsWrapper(),
        ),
        GoRoute(
          name: AppRoutes.staffProfileName,
          path: AppRoutes.staffProfilePath,
          builder: (context, state) => const ProfileWrapper(),
        ),
      ],
    ),
  ];
}
