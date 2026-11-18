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
    appName: 'MyApp Development',
    baseUrl: 'http://10.0.2.2:8000/api/',
  );

  static const production = AppConfig(
    environment: AppEnvironment.production,
    appName: 'MyApp',
    baseUrl: String.fromEnvironment(
      'API_BASE_URL',
      defaultValue: 'https://api.example.com/api/',
    ),
  );
}
