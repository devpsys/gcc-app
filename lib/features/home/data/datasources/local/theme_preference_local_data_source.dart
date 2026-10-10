import 'package:gcc_app/core/error/exceptions.dart';
import 'package:hive/hive.dart';

abstract interface class ThemePreferenceLocalDataSource {
  Future<String?> readThemeMode();

  Future<void> writeThemeMode(String value);
}

class HiveThemePreferenceLocalDataSource
    implements ThemePreferenceLocalDataSource {
  HiveThemePreferenceLocalDataSource(this._box);

  static const String _key = 'theme_mode';

  final Box<String> _box;

  @override
  Future<String?> readThemeMode() async {
    try {
      return _box.get(_key);
    } catch (error) {
      throw CacheException(error);
    }
  }

  @override
  Future<void> writeThemeMode(String value) async {
    try {
      await _box.put(_key, value);
    } catch (error) {
      throw CacheException(error);
    }
  }
}
