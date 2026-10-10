import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/core/theme/app_theme.dart';
import 'package:gcc_app/l10n/app_localizations.dart';

Future<void> pumpLocalized(
  WidgetTester tester, {
  required Widget child,
  Size size = const Size(800, 600),
  TextScaler textScaler = TextScaler.noScaling,
}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  await tester.pumpWidget(
    MaterialApp(
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      builder: (context, appChild) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: textScaler),
          child: appChild ?? const SizedBox.shrink(),
        );
      },
      home: child,
    ),
  );
  await tester.pumpAndSettle();
}
