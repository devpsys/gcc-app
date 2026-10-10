import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/home/domain/entities/theme_preference.dart';
import 'package:gcc_app/features/home/domain/repositories/theme_preference_repository.dart';

class FakeThemePreferenceRepository implements ThemePreferenceRepository {
  ThemePreference stored = const ThemePreference(AppThemeMode.system);
  Failure? loadFailure;
  Failure? saveFailure;

  @override
  Future<ThemePreference> load() async {
    final failure = loadFailure;
    if (failure != null) {
      throw failure;
    }
    return stored;
  }

  @override
  Future<void> save(ThemePreference preference) async {
    final failure = saveFailure;
    if (failure != null) {
      throw failure;
    }
    stored = preference;
  }
}
