import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/core/config/app_environment.dart';
import 'package:gcc_app/core/theme/app_theme.dart';
import 'package:gcc_app/core/widgets/app_debug_env_banner.dart';

Finder bannerWith(String message) {
  return find.byWidgetPredicate(
    (widget) => widget is Banner && widget.message == message,
  );
}

Future<void> pumpBanner(
  WidgetTester tester, {
  required AppEnvironment environment,
  bool forceVisible = true,
}) async {
  await tester.pumpWidget(
    MaterialApp(
      theme: AppTheme.light(),
      debugShowCheckedModeBanner: false,
      home: AppDebugEnvBanner(
        environment: environment,
        forceVisible: forceVisible,
        child: const SizedBox.expand(),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('shows a bottom-end banner for development', (tester) async {
    await pumpBanner(tester, environment: AppEnvironment.development);

    final banner = tester.widget<Banner>(bannerWith('GCC · DEV'));
    expect(banner.location, BannerLocation.bottomEnd);
  });

  testWidgets('shows a bottom-end banner for staging', (tester) async {
    await pumpBanner(tester, environment: AppEnvironment.staging);

    final banner = tester.widget<Banner>(bannerWith('GCC · STAGING'));
    expect(banner.location, BannerLocation.bottomEnd);
  });

  testWidgets('hides for production even when forced', (tester) async {
    await pumpBanner(tester, environment: AppEnvironment.production);

    expect(find.byType(Banner), findsNothing);
  });

  test('shouldShow is false for production', () {
    expect(
      AppDebugEnvBanner.shouldShow(
        AppEnvironment.production,
        forceVisible: true,
      ),
      isFalse,
    );
  });
}
