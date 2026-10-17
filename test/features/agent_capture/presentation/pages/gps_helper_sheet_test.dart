import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/features/agent_capture/presentation/pages/gps_helper_sheet.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/gps_acquire_progress.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/gps_accuracy_gauge.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/gps_guidance_list.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/gps_helper_view.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/gps_status_pill.dart';

import '../../../../helpers/pump_app.dart';

void main() {
  Future<GpsHelperResult?> pumpSheet(
    WidgetTester tester,
    GpsHelperView view, {
    void Function(GpsHelperResult? result)? onExit,
  }) async {
    await pumpLocalized(
      tester,
      size: const Size(360, 800),
      child: GpsHelperSheet(initialView: view, onExit: onExit ?? (_) {}),
    );
    return null;
  }

  testWidgets('AGT-07 weak signal shows the gauge and guidance', (
    tester,
  ) async {
    await pumpSheet(tester, GpsHelperView.signalWeak);

    expect(find.byType(GpsHelperSheet), findsOneWidget);
    expect(find.byType(GpsStatusPill), findsOneWidget);
    expect(find.text('Signal weak'), findsOneWidget);
    expect(find.byType(GpsAccuracyGauge), findsOneWidget);
    expect(find.text('±38 m'), findsOneWidget);
    expect(find.text('Target ±25 m or better'), findsOneWidget);
    expect(find.byType(GpsGuidanceList), findsOneWidget);
    expect(find.text('Step into the open sky'), findsWidgets);
    expect(find.text('Hold still for 5 seconds'), findsOneWidget);
    expect(find.text('Move away from metal roofs and walls'), findsOneWidget);
    expect(find.text('Try again'), findsOneWidget);
    expect(find.text('Enter coordinates manually'), findsOneWidget);
  });

  testWidgets('AGT-07 gauge keeps its designed size and is decorative', (
    tester,
  ) async {
    await pumpSheet(tester, GpsHelperView.signalWeak);

    expect(
      tester.getSize(find.byType(GpsAccuracyGauge)).width,
      greaterThanOrEqualTo(AppDimensions.minTouchTarget * 4),
    );
    // The accuracy is announced as text, not conveyed by the arc.
    expect(find.bySemanticsLabel('±38 m'), findsNothing);
  });

  testWidgets('AGT-07 acquired fix drops the guidance and offers acceptance', (
    tester,
  ) async {
    GpsHelperResult? chosen;
    await pumpSheet(
      tester,
      GpsHelperView.fixAcquired,
      onExit: (result) => chosen = result,
    );

    expect(find.text('Signal good'), findsOneWidget);
    expect(find.text('±9 m'), findsOneWidget);
    // An acquired fix has nothing to coach, so the guidance list is gone.
    expect(find.byType(GpsGuidanceList), findsNothing);
    expect(find.text('Use this location'), findsOneWidget);

    await tester.tap(find.text('Use this location'));
    expect(chosen, GpsHelperResult.accept);
  });

  testWidgets('AGT-07 denied permission explains how to re-grant it', (
    tester,
  ) async {
    await pumpSheet(tester, GpsHelperView.permissionDenied);

    expect(find.text('Location access is off'), findsOneWidget);
    expect(find.text('How to allow location'.toUpperCase()), findsOneWidget);
    expect(find.text('Open Settings'), findsOneWidget);
    expect(find.text('Permissions'), findsOneWidget);
    expect(find.text('Location'), findsOneWidget);
    expect(
      find.text('GPS coordinates required for rapid automated bounty payout.'),
      findsOneWidget,
    );
    expect(find.text('Turn on location'), findsOneWidget);
  });

  testWidgets('AGT-07 manual entry rejects out-of-range coordinates', (
    tester,
  ) async {
    GpsHelperResult? chosen;
    await pumpSheet(
      tester,
      GpsHelperView.manualEntry,
      onExit: (result) => chosen = result,
    );

    expect(find.text('Enter coordinates manually'), findsWidgets);
    expect(find.text('LATITUDE'), findsOneWidget);
    expect(find.text('LONGITUDE'), findsOneWidget);
    // Fixed direction blocks rather than a hemisphere to type.
    expect(find.text('° N'), findsOneWidget);
    expect(find.text('° E'), findsOneWidget);

    await tester.enterText(find.widgetWithText(TextField, '9.0580'), '9.0580');
    await tester.enterText(find.widgetWithText(TextField, '7.3986'), '999');
    await tester.tap(find.text('Save coordinates'));
    await tester.pumpAndSettle();

    expect(chosen, isNull);
    expect(find.text('Longitude must be between -180 and 180'), findsOneWidget);
  });

  testWidgets('AGT-07 manual entry saves valid coordinates', (tester) async {
    GpsHelperResult? chosen;
    await pumpSheet(
      tester,
      GpsHelperView.manualEntry,
      onExit: (result) => chosen = result,
    );

    await tester.enterText(find.widgetWithText(TextField, '9.0580'), '9.0580');
    await tester.enterText(find.widgetWithText(TextField, '7.3986'), '7.3986');
    await tester.tap(find.text('Save coordinates'));
    await tester.pumpAndSettle();

    expect(chosen, GpsHelperResult.useCoordinates);
  });

  testWidgets('AGT-07 coordinate formatter strips letters', (tester) async {
    await pumpSheet(tester, GpsHelperView.manualEntry);

    final latitude = find.byType(TextField).first;
    await tester.enterText(latitude, '9a.05b80');
    await tester.pumpAndSettle();

    expect(tester.widget<TextField>(latitude).controller!.text, '9.0580');
  });

  testWidgets('AGT-07 acquire progress counts up', (tester) async {
    await pumpSheet(tester, GpsHelperView.signalWeak);

    expect(find.byType(GpsAcquireProgress), findsNothing);

    await tester.tap(find.text('Try again'));
    await tester.pump();
    expect(find.byType(GpsAcquireProgress), findsOneWidget);
    expect(find.text('Acquiring fix…'), findsOneWidget);

    // The countdown resolves into an acquired fix.
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    expect(find.text('Signal good'), findsOneWidget);
    expect(find.byType(GpsAcquireProgress), findsNothing);
  });
}
