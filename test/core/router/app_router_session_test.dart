import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/core/di/injection.dart';
import 'package:gcc_app/core/router/app_router.dart';
import 'package:gcc_app/core/router/route_paths.dart';
import 'package:gcc_app/core/theme/app_theme.dart';
import 'package:gcc_app/features/auth/data/hive_device_lock_flag_store.dart';
import 'package:gcc_app/features/auth/domain/auth_role.dart';
import 'package:gcc_app/features/auth/domain/session_repository.dart';
import 'package:gcc_app/l10n/app_localizations.dart';
import 'package:hive/hive.dart';

import '../../helpers/establish_agent_session.dart';
import '../../helpers/test_config.dart';

void main() {
  late Directory directory;

  setUp(() async {
    directory = await Directory.systemTemp.createTemp('auth_redirect');
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

  testWidgets('a signed-out visit to today returns to sign-in', (
    tester,
  ) async {
    final router = createAppRouter();
    addTearDown(router.dispose);
    await tester.pumpWidget(
      MaterialApp.router(
        theme: AppTheme.light(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: router,
      ),
    );
    router.go(RoutePaths.agentToday);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));

    expect(router.state.uri.path, RoutePaths.authSignIn);
  });

  testWidgets('an enrolled locked visit to today opens unlock', (tester) async {
    await getIt<DeviceLockFlagStore>().writeEnrolled(AuthRole.agent);
    await getIt<SessionRepository>().prepareColdStart();

    final router = createAppRouter();
    addTearDown(router.dispose);
    await tester.pumpWidget(
      MaterialApp.router(
        theme: AppTheme.light(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: router,
      ),
    );
    router.go(RoutePaths.agentToday);
    await tester.pump();

    expect(router.state.uri.path, RoutePaths.biometricUnlock);
  });

  testWidgets('an unlocked visit to the unlock screen opens today', (
    tester,
  ) async {
    await establishAgentSession();
    final router = createAppRouter();
    addTearDown(router.dispose);
    await tester.pumpWidget(
      MaterialApp.router(
        theme: AppTheme.light(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: router,
      ),
    );
    router.go(RoutePaths.biometricUnlock);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));

    expect(router.state.uri.path, RoutePaths.agentToday);
  });
}
