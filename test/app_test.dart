import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/app.dart';
import 'package:gcc_app/core/di/injection.dart';
import 'package:hive/hive.dart';

import 'helpers/test_config.dart';

void main() {
  late Directory directory;

  setUp(() async {
    directory = await Directory.systemTemp.createTemp('gcc_app_test');
    await configureDependencies(
      config: testConfig,
      storageDirectory: directory.path,
    );
  });

  tearDown(() async {
    await Hive.close();
    await getIt.reset();
    await directory.delete(recursive: true);
  });

  testWidgets('starts on the home page', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const GccApp());
    await tester.pumpAndSettle();

    expect(find.text('Ready for the next feature'), findsOneWidget);
    expect(find.text('Environment: Development'), findsOneWidget);
  });
}
