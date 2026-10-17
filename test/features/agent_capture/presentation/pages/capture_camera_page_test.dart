import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/features/agent_capture/presentation/bloc/capture_cubit.dart';
import 'package:gcc_app/features/agent_capture/presentation/pages/capture_camera_page.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/camera_failure_banner.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/camera_permission_panel.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/camera_stage.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/film_checklist.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/record_control.dart';

import '../../../../helpers/pump_app.dart';
import '../../fake_capture_gateway.dart';

void main() {
  Future<CaptureCubit> pumpCamera(WidgetTester tester) async {
    final cubit = CaptureCubit(FakeCaptureGateway());
    await pumpLocalized(
      tester,
      size: const Size(360, 800),
      child: BlocProvider.value(value: cubit, child: const CaptureCameraPage()),
    );
    return cubit;
  }

  testWidgets('AGT-09 idle shows the checklist collapsed and the stage ready', (
    tester,
  ) async {
    final cubit = await pumpCamera(tester);

    expect(find.text('STEP 4 OF 4 · PHOTO & VIDEO'), findsOneWidget);
    expect(find.byType(CameraStage), findsOneWidget);
    expect(find.byType(FilmChecklist), findsOneWidget);
    expect(find.text('What to film'), findsOneWidget);
    expect(find.text('2/5 ready'), findsOneWidget);
    // Collapsed: the first two shots, the rest hidden.
    expect(find.text('Whole machine from all four sides'), findsOneWidget);
    expect(find.text('Existing damage and wear'), findsOneWidget);
    expect(find.text('Serial number plate'), findsNothing);
    expect(find.text('30s CLIP'), findsOneWidget);

    await cubit.close();
  });

  testWidgets('AGT-09 expanding the checklist reveals all five shots', (
    tester,
  ) async {
    final cubit = await pumpCamera(tester);

    await tester.tap(find.text('What to film'));
    await tester.pumpAndSettle();

    expect(find.text('Serial number plate'), findsOneWidget);
    expect(find.text('Fuel and fluid levels'), findsOneWidget);
    expect(find.text('Accessories and attachments'), findsOneWidget);

    await cubit.close();
  });

  testWidgets('AGT-09 record control is a fixed 96px target', (tester) async {
    final cubit = await pumpCamera(tester);

    expect(
      tester.getSize(find.byKey(const Key('capture.recordControl'))).width,
      RecordControl.diameter,
    );
    expect(RecordControl.diameter, 96);

    await cubit.close();
  });

  testWidgets('AGT-09 recording shows the timer and the five-shot checklist', (
    tester,
  ) async {
    final cubit = await pumpCamera(tester);

    await tester.tap(find.byKey(const Key('capture.recordControl')));
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    expect(find.text('00:03'), findsOneWidget);
    expect(find.text('REC: 3s / 30s MINIMUM'), findsOneWidget);
    expect(find.text('● RECORDING'), findsOneWidget);
    expect(find.text('5/5 ready'), findsOneWidget);

    await cubit.close();
  });

  testWidgets('AGT-09 warning tone appears in the last five seconds', (
    tester,
  ) async {
    final cubit = await pumpCamera(tester);

    await tester.tap(find.byKey(const Key('capture.recordControl')));
    await tester.pump(const Duration(seconds: 26));
    await tester.pumpAndSettle();

    expect(find.text('00:26'), findsOneWidget);
    expect(find.text('Almost done — keep it steady'), findsWidgets);

    await cubit.close();
  });

  testWidgets('AGT-09 a short clip reports an incomplete recording', (
    tester,
  ) async {
    final cubit = await pumpCamera(tester);

    await tester.tap(find.byKey(const Key('capture.recordControl')));
    await tester.pump(const Duration(seconds: 6));
    await tester.pumpAndSettle();
    // Stopping under the minimum length fails the clip.
    await tester.tap(find.byKey(const Key('capture.recordControl')));
    await tester.pumpAndSettle();

    expect(find.byType(CameraFailureBanner), findsOneWidget);
    expect(find.text('INCOMPLETE CLIP'), findsOneWidget);
    expect(
      find.text('Recording stopped after 12 s — the minimum is 30 seconds.'),
      findsOneWidget,
    );
    expect(
      find.text('Clip too short for warranty dispute audit'),
      findsOneWidget,
    );
    expect(find.text('Re-record 30s video'), findsOneWidget);
    expect(find.text('Use what we have (12 s)'), findsOneWidget);

    await cubit.close();
  });

  testWidgets('AGT-09 a full-length clip returns to idle', (tester) async {
    final cubit = await pumpCamera(tester);

    await tester.tap(find.byKey(const Key('capture.recordControl')));
    await tester.pump(const Duration(seconds: 31));
    await tester.pumpAndSettle();

    expect(find.byType(CameraFailureBanner), findsNothing);
    expect(find.text('30s CLIP'), findsOneWidget);

    await cubit.close();
  });

  testWidgets('AGT-09 denied permission still offers a way past', (
    tester,
  ) async {
    final cubit = await pumpCamera(tester);

    // The gallery action is the design's route into the permission frame.
    await tester.tap(find.byType(Icon).last);
    await tester.pumpAndSettle();

    expect(find.byType(CameraPermissionPanel), findsOneWidget);
    expect(find.text('Camera access is off'), findsOneWidget);
    expect(
      find.text('How to allow camera access'.toUpperCase()),
      findsOneWidget,
    );
    expect(find.text('Turn on camera'), findsOneWidget);
    // Never a dead end.
    expect(find.text('Continue without video'), findsOneWidget);

    await cubit.close();
  });

  testWidgets('AGT-09 keeps the 72px wizard bar', (tester) async {
    final cubit = await pumpCamera(tester);

    expect(
      tester.getSize(find.byKey(const Key('capture.wizardBar'))).height,
      AppDimensions.wizardBarHeight,
    );
    expect(find.text('Use photo'), findsWidgets);
    expect(find.text('Retake'), findsWidgets);

    await cubit.close();
  });
}
