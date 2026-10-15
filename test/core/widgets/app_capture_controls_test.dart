import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/app_avatar.dart';
import 'package:gcc_app/core/widgets/app_choice_chip.dart';
import 'package:gcc_app/core/widgets/app_segment_option.dart';
import 'package:gcc_app/core/widgets/app_segmented_control.dart';
import 'package:gcc_app/core/widgets/app_switch_track.dart';
import 'package:gcc_app/core/widgets/app_toggle_switch.dart';
import 'package:gcc_app/core/widgets/app_wizard_stepper.dart';
import 'package:gcc_app/core/widgets/wizard_step_badge.dart';
import 'package:gcc_app/core/widgets/wizard_step_pill.dart';

import '../../helpers/pump_app.dart';

void main() {
  testWidgets('segmented control reports the selected option', (tester) async {
    String? selected;
    await pumpLocalized(
      tester,
      child: AppSegmentedControl<String>(
        selected: 'yard',
        onChanged: (value) => selected = value,
        options: const [
          AppSegmentOption(value: 'yard', label: 'Equipment yard'),
          AppSegmentOption(value: 'bulk', label: 'Bulk supplier'),
        ],
      ),
    );

    await tester.tap(find.text('Bulk supplier'));
    await tester.pump();
    expect(selected, 'bulk');
  });

  testWidgets('choice chip and switch report changes', (tester) async {
    var chosen = false;
    var enabled = false;
    await pumpLocalized(
      tester,
      child: Material(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppChoiceChip(
              label: 'Generators',
              selected: chosen,
              onSelected: (value) => chosen = value,
            ),
            AppToggleSwitch(
              label: 'WhatsApp',
              value: enabled,
              onChanged: (value) => enabled = value,
            ),
          ],
        ),
      ),
    );

    expect(
      tester.getSize(find.byType(AppChoiceChip)).height,
      AppDimensions.minTouchTarget,
    );
    expect(
      tester
          .getSize(
            find.descendant(
              of: find.byType(AppChoiceChip),
              matching: find.byType(DecoratedBox),
            ),
          )
          .height,
      AppDimensions.minTouchTarget - AppSpacing.sm,
    );
    await tester.tap(find.text('Generators'));
    await tester.tap(find.byType(AppSwitchTrack));
    await tester.pumpAndSettle();
    expect(chosen, isTrue);
    expect(enabled, isTrue);
  });

  testWidgets('switch track matches the designed 44x24 geometry', (
    tester,
  ) async {
    await pumpLocalized(
      tester,
      child: AppToggleSwitch(label: 'WhatsApp', value: true, onChanged: (_) {}),
    );

    expect(
      tester.getSize(find.byType(AppSwitchTrack)),
      const Size(
        AppDimensions.switchTrackWidth,
        AppDimensions.switchTrackHeight,
      ),
    );
    // The platform control must not sneak back in.
    expect(find.byType(Switch), findsNothing);
  });

  testWidgets('wizard stepper names the current step', (tester) async {
    await pumpLocalized(
      tester,
      child: const AppWizardStepper(
        labels: ['Shop', 'Location', 'Assets', 'Media'],
        currentIndex: 0,
        eyebrow: 'Step 1 of 4 · Shop details',
        badge: '1 / 4 ACTIVE',
        badgeStyle: WizardStepBadge.active,
      ),
    );

    expect(find.text('1 / 4 ACTIVE'), findsOneWidget);
    expect(find.text('STEP 1 OF 4 · SHOP DETAILS'), findsOneWidget);
    expect(find.bySemanticsLabel('Step 1 of 4, Shop'), findsOneWidget);
  });

  // Design conformance: the selected variant draws 32 px pills inside a card,
  // not the thin progress bars a generic stepper would produce.
  testWidgets('wizard stepper pills match the design geometry', (tester) async {
    await pumpLocalized(
      tester,
      child: const AppWizardStepper(
        labels: ['Shop', 'Location', 'Assets', 'Media'],
        currentIndex: 1,
        eyebrow: 'Step 2 of 4 · Location',
        badge: '2 / 4 ACTIVE',
        badgeStyle: WizardStepBadge.active,
      ),
    );

    final pills = find.byType(WizardStepPill);
    expect(pills, findsNWidgets(4));
    for (var i = 0; i < 4; i++) {
      expect(
        tester.getSize(pills.at(i)).height,
        AppDimensions.wizardStepHeight,
      );
    }

    // 6 px gutters between pills, inside the card's own 8 px inset.
    final firstRight = tester.getBottomRight(pills.at(0)).dx;
    final secondLeft = tester.getTopLeft(pills.at(1)).dx;
    expect(secondLeft - firstRight, closeTo(AppSpacing.tight, 0.01));
  });

  testWidgets('segmented control leaves unselected segments bare', (
    tester,
  ) async {
    await pumpLocalized(
      tester,
      child: AppSegmentedControl<String>(
        selected: 'yard',
        onChanged: (_) {},
        options: const [
          AppSegmentOption(value: 'yard', label: 'Equipment yard'),
          AppSegmentOption(value: 'bulk', label: 'Bulk supplier'),
          AppSegmentOption(value: 'both', label: 'Both'),
        ],
      ),
    );

    final scheme = Theme.of(
      tester.element(find.byType(AppSegmentedControl<String>)),
    ).colorScheme;
    TextStyle styleOf(String label) =>
        tester.widget<Text>(find.text(label)).style!;

    // The selected segment is brand-filled text at 600; the design leaves the
    // rest as bare de-emphasised labels, so they must not read as ink-900.
    expect(styleOf('Equipment yard').color, scheme.primary);
    expect(styleOf('Equipment yard').fontWeight, FontWeight.w600);
    expect(styleOf('Bulk supplier').color, scheme.onSurfaceVariant);
    expect(styleOf('Bulk supplier').fontWeight, FontWeight.w500);
    expect(styleOf('Both').color, scheme.onSurfaceVariant);

    // Designed segment height is 40 px even though the tap target is larger.
    expect(
      tester.getSize(find.byType(AppSegmentedControl<String>)).height,
      greaterThanOrEqualTo(AppDimensions.minTouchTarget - AppSpacing.xs),
    );
  });

  testWidgets('avatar uses the first letters of the name', (tester) async {
    await pumpLocalized(tester, child: const AppAvatar(name: 'Ibrahim Musa'));

    expect(find.text('IM'), findsOneWidget);
  });
}
