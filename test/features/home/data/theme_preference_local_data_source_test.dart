import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/features/home/data/datasources/local/theme_preference_local_data_source.dart';
import 'package:hive/hive.dart';

void main() {
  test('round-trips the theme mode through Hive', () async {
    final directory = await Directory.systemTemp.createTemp('gcc_hive_test');
    Hive.init(directory.path);
    final box = await Hive.openBox<String>('preferences');
    final dataSource = HiveThemePreferenceLocalDataSource(box);

    expect(await dataSource.readThemeMode(), isNull);
    await dataSource.writeThemeMode('light');
    expect(await dataSource.readThemeMode(), 'light');

    await Hive.close();
    await directory.delete(recursive: true);
  });
}
