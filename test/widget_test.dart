import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mcc_registrar/core/router/app_router.dart';
import 'package:mcc_registrar/core/router/app_routes.dart';
import 'package:mcc_registrar/core/auth/auth_state.dart';
import 'package:mcc_registrar/core/config/app_config.dart';
import 'package:mcc_registrar/core/di/injector.dart';
import 'package:mcc_registrar/main.dart';

late GoRouter _router;

const _studentRoutes = [
  AppRoutes.studentHomePath,
  AppRoutes.servicesPath,
  AppRoutes.appointmentsPath,
  AppRoutes.appointmentDetailsPath,
  AppRoutes.queuePath,
  AppRoutes.historyPath,
  AppRoutes.profilePath,
];

const _staffRoutes = [
  AppRoutes.staffHomePath,
  AppRoutes.staffServicesPath,
  AppRoutes.staffSchedulesPath,
  AppRoutes.staffAppointmentsPath,
  AppRoutes.staffQueuePath,
  AppRoutes.staffTransactionsPath,
  AppRoutes.staffStudentsPath,
  AppRoutes.staffReportPath,
];

Future<void> _pumpAppAt(WidgetTester tester, Size size) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(() {
    tester.view.resetPhysicalSize();
    tester.view.resetDevicePixelRatio();
  });
  await getIt.reset();
  await configureDependencies(apiBaseUrl: AppConfig.development.baseUrl);
  final authState = getIt<AuthState>();
  _router = AppRouter.build(authState: authState);
  await tester.pumpWidget(
    MccRegistrarApp(router: _router, authState: authState),
  );
  _router.go(AppRoutes.loginPath);
  await tester.pumpAndSettle();
}

/// Pumps a route and fails with the render error (e.g. overflow) if any.
Future<void> _expectNoRenderError(
  WidgetTester tester,
  String path, {
  String? expectedText,
}) async {
  _router.go(path);
  await tester.pumpAndSettle();
  final error = tester.takeException();
  expect(error, isNull, reason: 'Render error on $path');
  expect(
    find.byType(MccRegistrarApp),
    findsOneWidget,
    reason: 'App not mounted on $path',
  );
  if (expectedText != null) {
    expect(
      find.text(expectedText),
      findsWidgets,
      reason: 'Missing $expectedText on $path',
    );
  }
}

void main() {
  testWidgets('login navigates to student area on mobile', (tester) async {
    await _pumpAppAt(tester, const Size(390, 844));

    expect(find.text('Log In'), findsOneWidget);
    expect(tester.takeException(), isNull, reason: 'Login overflow at 390');

    await tester.tap(find.text('Log In'));
    await tester.pumpAndSettle();

    expect(_router.state.uri.path, AppRoutes.studentHomePath);
    expect(tester.takeException(), isNull, reason: 'Dashboard overflow at 390');
    expect(find.byType(BottomNavigationBar), findsOneWidget);
  });

  for (final size in const [
    Size(390, 844),
    Size(768, 1024),
    Size(1440, 1024),
  ]) {
    final label = '${size.width.toInt()}x${size.height.toInt()}';

    testWidgets('student pages render without overflow at $label', (
      tester,
    ) async {
      await _pumpAppAt(tester, size);
      _router.go(AppRoutes.studentHomePath);
      await tester.pumpAndSettle();

      final isMobile = size.width < 600;
      final isDesktop = size.width >= 1024;
      expect(
        find.byType(BottomNavigationBar),
        isMobile ? findsOneWidget : findsNothing,
      );
      expect(
        find.text('View Registrar Services'),
        isDesktop ? findsOneWidget : findsNothing,
        reason: 'Docked sidebar only on desktop',
      );

      for (final path in _studentRoutes) {
        await _expectNoRenderError(tester, path);
      }
    });

    testWidgets('staff pages render without overflow at $label', (
      tester,
    ) async {
      await _pumpAppAt(tester, size);
      _router.go(AppRoutes.staffHomePath);
      await tester.pumpAndSettle();

      final isMobile = size.width < 600;
      final isDesktop = size.width >= 1024;
      expect(
        find.byType(BottomNavigationBar),
        isMobile ? findsOneWidget : findsNothing,
      );
      expect(
        find.text('Queue Management'),
        isDesktop ? findsOneWidget : findsNothing,
        reason: 'Docked sidebar only on desktop',
      );

      for (final path in _staffRoutes) {
        await _expectNoRenderError(tester, path);
      }
    });
  }

  testWidgets('tablet uses a drawer instead of a docked sidebar', (
    tester,
  ) async {
    await _pumpAppAt(tester, const Size(800, 900));
    _router.go(AppRoutes.studentHomePath);
    await tester.pumpAndSettle();

    expect(find.byType(BottomNavigationBar), findsNothing);
    expect(find.text('View Registrar Services'), findsNothing);

    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
    expect(find.byType(Drawer), findsOneWidget);
    expect(find.text('View Registrar Services'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
