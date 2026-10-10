import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/core/theme/app_colors.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_theme.dart';
import 'package:gcc_app/core/widgets/app_primary_button.dart';
import 'package:gcc_app/core/widgets/destructive_confirm_dialog.dart';
import 'package:gcc_app/core/widgets/held_funds_indicator.dart';
import 'package:gcc_app/core/widgets/skeleton_list_card.dart';
import 'package:gcc_app/core/widgets/status_chip.dart';
import 'package:gcc_app/core/widgets/sync_status_banner.dart';
import 'package:gcc_app/core/widgets/watch_gate_check.dart';
import 'package:gcc_app/l10n/app_localizations.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Future<void> pumpThemed(WidgetTester tester, Widget child) {
    return tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(body: child),
      ),
    );
  }

  testWidgets('primary button is 52px and reports a disabled reason', (
    tester,
  ) async {
    var taps = 0;
    await pumpThemed(
      tester,
      Column(
        children: [
          AppPrimaryButton(label: 'Confirm', onPressed: () => taps++),
          const AppPrimaryButton(
            label: 'Release',
            disabledReason: 'Inspection pending',
          ),
        ],
      ),
    );
    await tester.pump();

    expect(
      tester.getSize(find.widgetWithText(FilledButton, 'Confirm')).height,
      AppDimensions.buttonHeight,
    );
    await tester.tap(find.text('Confirm'));
    await tester.pump();
    expect(taps, 1);
    expect(find.text('Inspection pending'), findsOneWidget);
    expect(find.byIcon(Icons.info_outline), findsOneWidget);
  });

  testWidgets('held status keeps the lock and escrow amount', (tester) async {
    await pumpThemed(
      tester,
      const Column(
        children: [
          StatusChip(label: 'Caution deposit held', tone: StatusTone.held),
          HeldFundsIndicator(label: 'Caution deposit', amount: '₦50,000'),
        ],
      ),
    );

    expect(find.byIcon(Icons.lock), findsNWidgets(2));
    expect(find.text('₦50,000'), findsOneWidget);
  });

  testWidgets('syncing banner shows progress', (tester) async {
    await pumpThemed(
      tester,
      const SyncStatusBanner(
        kind: SyncBannerKind.syncing,
        message: 'Syncing 3 items',
        progress: 0.4,
      ),
    );

    final progress = tester.widget<LinearProgressIndicator>(
      find.byType(LinearProgressIndicator),
    );
    expect(progress.value, 0.4);
    expect(progress.minHeight, AppDimensions.syncProgressHeight);
  });

  testWidgets('destructive dialog returns the chosen action', (tester) async {
    bool? confirmed;
    await pumpThemed(
      tester,
      Builder(
        builder: (context) {
          return TextButton(
            onPressed: () async {
              confirmed = await showDestructiveConfirmDialog(
                context: context,
                title: 'Release deposit',
                message: 'This cannot be undone.',
                notice: '₦5,000 will leave escrow.',
                safeLabel: 'Keep',
                destructiveLabel: 'Release',
              );
            },
            child: const Text('Open'),
          );
        },
      ),
    );

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
    expect(find.text('Keep'), findsOneWidget);
    expect(find.text('₦5,000 will leave escrow.'), findsOneWidget);

    await tester.tap(find.text('Release'));
    await tester.pumpAndSettle();
    expect(confirmed, isTrue);
  });

  testWidgets('disabled watch gate still shows its caption', (tester) async {
    await pumpThemed(
      tester,
      const WatchGateCheck(
        title: 'I watched the return video',
        caption: 'GCC cannot verify this for you.',
        value: false,
      ),
    );

    expect(find.text('GCC cannot verify this for you.'), findsOneWidget);
    await tester.tap(find.text('I watched the return video'));
    await tester.pump();
    expect(find.byIcon(Icons.check), findsNothing);
  });

  testWidgets('skeleton card builds on the light canvas', (tester) async {
    await pumpThemed(tester, const SkeletonListCard());
    await tester.pump();

    expect(find.byType(SkeletonListCard), findsOneWidget);
    final scaffold = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(scaffold.theme?.scaffoldBackgroundColor, AppColors.canvas);
  });
}
