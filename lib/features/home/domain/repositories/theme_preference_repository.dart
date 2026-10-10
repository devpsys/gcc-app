import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/home/domain/entities/theme_preference.dart';

abstract interface class ThemePreferenceRepository {
  /// Throws [CacheFailure] when the preference cannot be read.
  Future<ThemePreference> load();

  /// Throws [CacheFailure] when the preference cannot be saved.
  Future<void> save(ThemePreference preference);
}
