import 'package:gcc_app/core/error/exception_mapper.dart';
import 'package:gcc_app/core/error/exceptions.dart';
import 'package:gcc_app/features/home/data/datasources/local/theme_preference_local_data_source.dart';
import 'package:gcc_app/features/home/data/models/theme_preference_model.dart';
import 'package:gcc_app/features/home/domain/entities/theme_preference.dart';
import 'package:gcc_app/features/home/domain/repositories/theme_preference_repository.dart';

class ThemePreferenceRepositoryImpl implements ThemePreferenceRepository {
  ThemePreferenceRepositoryImpl(this._local);

  final ThemePreferenceLocalDataSource _local;

  @override
  Future<ThemePreference> load() async {
    try {
      final raw = await _local.readThemeMode();
      return ThemePreference(ThemePreferenceModel.decode(raw));
    } on AppException catch (error) {
      throw toFailure(error);
    }
  }

  @override
  Future<void> save(ThemePreference preference) async {
    try {
      await _local.writeThemeMode(ThemePreferenceModel.encode(preference.mode));
    } on AppException catch (error) {
      throw toFailure(error);
    }
  }
}
