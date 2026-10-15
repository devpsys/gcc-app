import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/home/presentation/bloc/home_cubit.dart';
import 'package:gcc_app/features/home/presentation/pages/home_page.dart';

import '../../../../helpers/pump_app.dart';
import '../../../../helpers/test_config.dart';
import '../../fake_theme_preference_repository.dart';

void main() {
  testWidgets('shows the foundation and saves the selected appearance', (
    tester,
  ) async {
    final repository = FakeThemePreferenceRepository();
    final cubit = HomeCubit(repository, testConfig);

    await pumpLocalized(
      tester,
      size: const Size(390, 844),
      child: BlocProvider(
        create: (_) => cubit..load(),
        child: const HomePage(),
      ),
    );

    expect(find.text('Ready for the next feature'), findsOneWidget);
    expect(find.text('No API base URL is configured.'), findsOneWidget);
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);

    await tester.tap(find.text('Light'));
    await tester.pumpAndSettle();

    expect(repository.stored.mode.name, 'light');
  });

  testWidgets('uses a navigation rail on a wide window', (tester) async {
    final cubit = HomeCubit(FakeThemePreferenceRepository(), testConfig);

    await pumpLocalized(
      tester,
      size: const Size(1280, 800),
      child: BlocProvider(
        create: (_) => cubit..load(),
        child: const HomePage(),
      ),
    );

    expect(find.byType(NavigationRail), findsOneWidget);
    expect(find.byType(NavigationBar), findsNothing);
  });

  testWidgets('offers a retry when preferences cannot be loaded', (
    tester,
  ) async {
    final repository = FakeThemePreferenceRepository()
      ..loadFailure = const CacheFailure();
    final cubit = HomeCubit(repository, testConfig);

    await pumpLocalized(
      tester,
      child: BlocProvider(
        create: (_) => cubit..load(),
        child: const HomePage(),
      ),
    );

    expect(find.text('Preferences could not be loaded.'), findsOneWidget);

    repository.loadFailure = null;
    await tester.tap(find.text('Try again'));
    await tester.pumpAndSettle();

    expect(find.text('Ready for the next feature'), findsOneWidget);
  });
}
