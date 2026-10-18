import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/core/di/injection.dart';
import 'package:gcc_app/core/router/app_router.dart';
import 'package:gcc_app/core/router/route_paths.dart';
import 'package:gcc_app/core/theme/app_theme.dart';
import 'package:gcc_app/features/agent_capture/presentation/bloc/capture_cubit.dart';
import 'package:gcc_app/features/agent_sync/presentation/gateway/sync_queue_gateway.dart';
import 'package:gcc_app/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';

import '../../../../helpers/establish_agent_session.dart';
import '../../../../helpers/test_config.dart';

void main() {
  late Directory directory;
  late GoRouter router;

  setUp(() async {
    directory = await Directory.systemTemp.createTemp('queue_link_test');
    await configureDependencies(
      config: testConfig,
      storageDirectory: directory.path,
    );
    await establishAgentSession();
    router = createAppRouter();
  });

  tearDown(() async {
    router.dispose();
    await Hive.close();
    await getIt.reset();
    await directory.delete(recursive: true);
  });

  testWidgets('a submitted draft shows in the queue and discard removes it', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(360, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final cubit = getIt<CaptureCubit>()
      ..editShopName('Zaria Tools')
      ..editOwnerName('Amina Yusuf')
      ..editMarket('Kugbo Market');
    await cubit.submit();

    router.go(RoutePaths.agentQueue);
    await tester.pumpWidget(
      MaterialApp.router(
        theme: AppTheme.light(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: router,
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Zaria Tools'), findsOneWidget);

    final gateway = getIt<SyncQueueGateway>();
    final submitted = (await gateway.loadItems()).firstWhere(
      (item) => item.shopName == 'Zaria Tools',
    );
    expect(submitted.owner, 'Amina Yusuf');
    expect(submitted.location, 'Kugbo Market');
    expect(submitted.doneBytes, isNull);
    expect(submitted.totalBytes, isNull);

    await gateway.discardSubmission(submitted.reference);
    router.go(RoutePaths.agentToday);
    await tester.pumpAndSettle();
    router.go(RoutePaths.agentQueue);
    await tester.pumpAndSettle();
    expect(find.text('Zaria Tools'), findsNothing);
  });
}
