import 'package:gcc_app/core/config/app_config.dart';
import 'package:gcc_app/core/config/app_environment.dart';

const testConfig = AppConfig(
  environment: AppEnvironment.development,
  apiBaseUrl: '',
  connectTimeout: AppConfig.defaultConnectTimeout,
  receiveTimeout: AppConfig.defaultReceiveTimeout,
  sendTimeout: AppConfig.defaultSendTimeout,
  enableHttpLogging: false,
);

const configuredTestConfig = AppConfig(
  environment: AppEnvironment.staging,
  apiBaseUrl: 'https://api.example.test',
  connectTimeout: AppConfig.defaultConnectTimeout,
  receiveTimeout: AppConfig.defaultReceiveTimeout,
  sendTimeout: AppConfig.defaultSendTimeout,
  enableHttpLogging: false,
);
