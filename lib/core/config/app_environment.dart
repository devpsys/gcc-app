enum AppEnvironment {
  development,
  staging,
  production;

  static AppEnvironment parse(String raw) {
    return switch (raw.trim()) {
      'development' => AppEnvironment.development,
      'staging' => AppEnvironment.staging,
      'production' => AppEnvironment.production,
      _ => throw ArgumentError.value(
        raw,
        'APP_ENV',
        'Expected development, staging, or production.',
      ),
    };
  }
}
