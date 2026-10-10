import 'package:gcc_app/core/config/app_environment.dart';

class AppConfig {
  const AppConfig({
    required this.environment,
    required this.apiBaseUrl,
    required this.connectTimeout,
    required this.receiveTimeout,
    required this.sendTimeout,
    required this.enableHttpLogging,
  });

  static const Duration defaultConnectTimeout = Duration(seconds: 15);
  static const Duration defaultReceiveTimeout = Duration(seconds: 30);
  static const Duration defaultSendTimeout = Duration(seconds: 30);

  factory AppConfig.fromEnvironment() {
    const rawEnvironment = String.fromEnvironment(
      'APP_ENV',
      defaultValue: 'development',
    );
    const apiBaseUrl = String.fromEnvironment('API_BASE_URL');
    final environment = AppEnvironment.parse(rawEnvironment);
    return AppConfig(
      environment: environment,
      apiBaseUrl: apiBaseUrl.trim(),
      connectTimeout: defaultConnectTimeout,
      receiveTimeout: defaultReceiveTimeout,
      sendTimeout: defaultSendTimeout,
      enableHttpLogging: environment == AppEnvironment.development,
    );
  }

  final AppEnvironment environment;
  final String apiBaseUrl;
  final Duration connectTimeout;
  final Duration receiveTimeout;
  final Duration sendTimeout;
  final bool enableHttpLogging;

  bool get hasApiBaseUrl => apiBaseUrl.isNotEmpty;
}
