enum AppEnvironment { development, production, debug }

class AppConfig {
  final AppEnvironment environment;
  final String appName;
  final String baseUrl;

  const AppConfig({
    required this.environment,
    required this.appName,
    required this.baseUrl,
  });

  static const development = AppConfig(
    environment: AppEnvironment.development,
    appName: 'MCC Registrar Development',
    baseUrl: 'http://10.0.2.2:8000/api/',
  );

  static const production = AppConfig(
    environment: AppEnvironment.production,
    appName: 'MCC Registrar',
    baseUrl: String.fromEnvironment(
      'API_BASE_URL',
      defaultValue: 'https://mcc-queue-appointment-be.onrender.com/api/',
    ),
  );
}
