import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/features/agent_capture/presentation/bloc/capture_cubit.dart';
import 'package:gcc_app/features/agent_capture/presentation/pages/capture_location_page.dart';

import '../../../../helpers/pump_app.dart';
import '../../fake_capture_gateway.dart';

void main() {
  testWidgets('AGT-06 keeps the card stepper and asks for a landmark', (
    tester,
  ) async {
    final cubit = CaptureCubit(FakeCaptureGateway());
    await pumpLocalized(
      tester,
      size: const Size(360, 800),
      child: BlocProvider.value(
        value: cubit,
        child: const CaptureLocationPage(),
      ),
    );

    expect(find.text('STEP 2 OF 4 · SPATIAL TAGGING'), findsOneWidget);
    expect(find.text('2 / 4 ACTIVE'), findsOneWidget);
    expect(find.text('Location'), findsWidgets);
    expect(
      find.text('e.g. beside Bola Hardware, near the main gate'),
      findsOneWidget,
    );
    final scrollable = find.byType(Scrollable).first;
    await tester.scrollUntilVisible(
      find.text('No location signal'),
      400,
      scrollable: scrollable,
    );
    expect(find.text('No location signal'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('Map pin disabled'),
      400,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Map pin disabled'), findsOneWidget);
    expect(find.text('Add a landmark to continue'), findsOneWidget);
    expect(
      tester
          .widget<FilledButton>(find.widgetWithText(FilledButton, 'Continue'))
          .onPressed,
      isNull,
    );
    expect(tester.takeException(), isNull);
    await cubit.close();
  });

  // The no-signal frame is the design's own path: the agent continues without
  // a pin and an admin verifies the location afterwards. The app has no GPS
  // service, so this is the only reachable frame — Continue must not be a
  // permanent dead end.
  testWidgets(
    'AGT-06 continues without a verified pin once a landmark exists',
    (tester) async {
      final cubit = CaptureCubit(FakeCaptureGateway());
      await pumpLocalized(
        tester,
        size: const Size(360, 800),
        child: BlocProvider.value(
          value: cubit,
          child: const CaptureLocationPage(),
        ),
      );

      // Still blocked with an empty landmark.
      expect(
        tester
            .widget<FilledButton>(find.widgetWithText(FilledButton, 'Continue'))
            .onPressed,
        isNull,
      );

      cubit.editLandmark('beside the main gate');
      await tester.pumpAndSettle();

      expect(
        tester
            .widget<FilledButton>(find.widgetWithText(FilledButton, 'Continue'))
            .onPressed,
        isNotNull,
      );
      // The reason explains what happens to the un-verified location.
      expect(
        find.text(
          'Submitting without a pin — an admin will verify this location',
        ),
        findsOneWidget,
      );

      await cubit.close();
    },
  );

  testWidgets('AGT-06 saves a typed market onto the path', (tester) async {
    final cubit = CaptureCubit(FakeCaptureGateway());
    await pumpLocalized(
      tester,
      size: const Size(360, 800),
      child: BlocProvider.value(
        value: cubit,
        child: const CaptureLocationPage(),
      ),
    );

    await tester.ensureVisible(find.text('Choose a market'));
    await tester.tap(find.text('Choose a market'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).last, 'Kugbo Market');
    await tester.pump();
    await tester.tap(find.text('Use "Kugbo Market" as custom text'));
    await tester.pumpAndSettle();

    expect(cubit.state.draft.market, 'Kugbo Market');
    final position = tester
        .state<ScrollableState>(find.byType(Scrollable).first)
        .position;
    position.jumpTo(0);
    await tester.pump();
    expect(find.text('KUGBO MARKET CLUSTER'), findsOneWidget);
    expect(tester.takeException(), isNull);
    await cubit.close();
  });
}
