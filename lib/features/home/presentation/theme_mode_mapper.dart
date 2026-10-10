import 'package:flutter/material.dart';
import 'package:gcc_app/features/home/domain/entities/theme_preference.dart';

ThemeMode themeModeFromPreference(AppThemeMode mode) {
  return switch (mode) {
    AppThemeMode.system => ThemeMode.system,
    AppThemeMode.light => ThemeMode.light,
    AppThemeMode.dark => ThemeMode.dark,
  };
}
