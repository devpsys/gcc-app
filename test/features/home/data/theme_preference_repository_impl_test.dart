import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/core/error/exceptions.dart';
import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/home/data/datasources/local/theme_preference_local_data_source.dart';
import 'package:gcc_app/features/home/data/repositories/theme_preference_repository_impl.dart';
import 'package:gcc_app/features/home/domain/entities/theme_preference.dart';

void main() {
  test('decodes a stored theme and falls back when it is missing', () async {
    final dataSource = _MemoryThemePreferenceDataSource();
    final repository = ThemePreferenceRepositoryImpl(dataSource);

    expect((await repository.load()).mode, AppThemeMode.system);

    await repository.save(const ThemePreference(AppThemeMode.dark));
    expect((await repository.load()).mode, AppThemeMode.dark);
    expect(dataSource.value, 'dark');
  });

  test('translates storage exceptions into cache failures', () async {
    final repository = ThemePreferenceRepositoryImpl(
      _MemoryThemePreferenceDataSource()..error = const CacheException('disk'),
    );

    expect(repository.load(), throwsA(isA<CacheFailure>()));
  });
}

class _MemoryThemePreferenceDataSource
    implements ThemePreferenceLocalDataSource {
  String? value;
  CacheException? error;

  @override
  Future<String?> readThemeMode() async {
    final failure = error;
    if (failure != null) {
      throw failure;
    }
    return value;
  }

  @override
  Future<void> writeThemeMode(String newValue) async {
    final failure = error;
    if (failure != null) {
      throw failure;
    }
    value = newValue;
  }
}
