import 'package:gcc_app/features/home/domain/entities/theme_preference.dart';

abstract final class ThemePreferenceModel {
  static const String system = 'system';
  static const String light = 'light';
  static const String dark = 'dark';

  static String encode(AppThemeMode mode) {
    return switch (mode) {
      AppThemeMode.system => system,
      AppThemeMode.light => light,
      AppThemeMode.dark => dark,
    };
  }

  static AppThemeMode decode(String? value) {
    return switch (value) {
      light => AppThemeMode.light,
      dark => AppThemeMode.dark,
      _ => AppThemeMode.system,
    };
  }
}
