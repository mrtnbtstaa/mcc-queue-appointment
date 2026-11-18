import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import 'core/auth/auth_state.dart';
import 'core/config/app_config.dart';
import 'core/di/injector.dart';
import 'core/router/app_router.dart';
import 'core/storage/token_store.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const environment = String.fromEnvironment(
    "ENV",
    defaultValue: "development",
  );

  final config = switch (environment) {
    "production" => AppConfig.production,
    "development" => AppConfig.development,
    _ => AppConfig.development,
  };

  await configureDependencies(apiBaseUrl: config.baseUrl);

  final authState = getIt<AuthState>();
  final tokenStore = getIt<TokenStore>();

  final token = await tokenStore.readAccessToken();
  if (token != null && token.isNotEmpty) {
    final role = await tokenStore.readRole();
    authState.setSignedIn(accessToken: token, role: role);
  }

  final router = AppRouter.build(authState: authState);
  runApp(MccRegistrarApp(router: router, authState: authState));
}

class MccRegistrarApp extends StatelessWidget {
  const MccRegistrarApp({
    super.key,
    required this.router,
    required this.authState,
  });

  final GoRouter router;
  final AuthState authState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'MCC Registrar',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
    );
  }
}
