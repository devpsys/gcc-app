import 'package:equatable/equatable.dart';

enum AppThemeMode { system, light, dark }

class ThemePreference extends Equatable {
  const ThemePreference(this.mode);

  final AppThemeMode mode;

  @override
  List<Object?> get props => [mode];
}
