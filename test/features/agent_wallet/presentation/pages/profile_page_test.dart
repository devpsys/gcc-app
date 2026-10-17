import '../../../../helpers/pump_app.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/widgets/app_switch_track.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/agent_profile.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/notification_channel.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/storage_category.dart';
import 'package:gcc_app/features/agent_wallet/presentation/pages/notification_channels_page.dart';
import 'package:gcc_app/features/agent_wallet/presentation/pages/profile_page.dart';
import 'package:gcc_app/features/agent_wallet/presentation/widgets/install_prompt_card.dart';
import 'package:gcc_app/features/agent_wallet/presentation/widgets/profile_header.dart';
import 'package:gcc_app/features/agent_wallet/presentation/widgets/settings_row.dart';
import 'package:gcc_app/features/agent_wallet/presentation/widgets/storage_category_row.dart';

void main() {
  const profile = AgentProfile(
    name: 'Ibrahim Musa',
    agentId: 'AG-0142',
    base: 'Kugbo',
    coveredMarkets: 'Kugbo, Dei-Dei',
    since: 'Agent since Mar 2026',
    submissionCount: 61,
    verifiedCount: 54,
    supportPhone: '+234 803 441 2290',
  );

  const storage = [
    StorageCategory(label: 'Map cache', size: '1.8 GB', clearable: true),
    StorageCategory(label: 'Upload history', size: '420 MB', clearable: true),
    StorageCategory(label: 'Shop photos', size: '180 MB', clearable: false),
  ];

  const channels = [
    NotificationChannel(
      id: 'sms',
      detail: 'Booking requests and verdicts',
      enabled: true,
      lastSentAt: '13 Oct, 11:08',
      delivered: true,
    ),
    NotificationChannel(
      id: 'push',
      detail: 'Queue and payout updates',
      enabled: true,
      lastSentAt: '13 Oct, 10:44',
      delivered: true,
    ),
  ];

  /// Scrolls until [text] is built and fully on screen.
  Future<void> reveal(WidgetTester tester, String text) async {
    final target = find.text(text);
    for (var i = 0; i < 10 && target.evaluate().isEmpty; i++) {
      await tester.drag(find.byType(ListView), const Offset(0, -280));
      await tester.pumpAndSettle();
    }
    await tester.ensureVisible(target);
    await tester.pumpAndSettle();
  }

  Future<void> pumpProfile(
    WidgetTester tester, {
    void Function(String)? onClear,
  }) => pumpLocalized(
    tester,
    size: const Size(360, 800),
    child: ProfilePage(
      profile: profile,
      storageCategories: storage,
      channels: channels,
      onClearStorage: onClear,
    ),
  );

  testWidgets('AGT-17 profile shows identity, tenure and track record', (
    tester,
  ) async {
    await pumpProfile(tester);

    expect(find.text('Profile'), findsOneWidget);
    expect(find.byType(ProfileHeader), findsOneWidget);
    expect(find.text('Ibrahim Musa'), findsOneWidget);
    expect(find.text('Field Agent · AG-0142'), findsOneWidget);
    expect(find.textContaining('61 submissions'), findsOneWidget);
    expect(find.textContaining('54 verified'), findsOneWidget);
  });

  testWidgets('AGT-17 profile carries no money and no lock glyphs', (
    tester,
  ) async {
    await pumpProfile(tester);

    // The design says zero money context on this screen.
    expect(find.byIcon(Icons.lock), findsNothing);
    expect(find.byIcon(Icons.lock_outline), findsNothing);
    expect(find.textContaining('₦'), findsNothing);
  });

  testWidgets('AGT-17 preferences lead to language and notifications', (
    tester,
  ) async {
    var languageOpened = false;
    var notificationsOpened = false;
    await pumpLocalized(
      tester,
      size: const Size(360, 800),
      child: ProfilePage(
        profile: profile,
        storageCategories: storage,
        channels: channels,
        onOpenLanguage: () => languageOpened = true,
        onOpenNotifications: () => notificationsOpened = true,
      ),
    );

    // 'Language' is both a row label and the row's own value, so target the
    // row's semantic tap target rather than the text.
    final languageRow = find.widgetWithText(SettingsRow, 'Language');
    await tester.tap(languageRow.first);
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(SettingsRow, 'Notifications'));
    await tester.pumpAndSettle();

    expect(languageOpened, isTrue);
    expect(notificationsOpened, isTrue);
    expect(find.text('SMS and push'), findsOneWidget);
  });

  testWidgets('AGT-17 withholds clear when no storage backend exists', (
    tester,
  ) async {
    await pumpProfile(tester);

    await reveal(tester, 'Map cache');
    // No handler means no dead button, even though the category is clearable.
    expect(find.text('Clear'), findsNothing);
    expect(find.byType(StorageCategoryRow), findsNWidgets(storage.length));
  });

  testWidgets('AGT-17 clear appears once a handler is supplied', (
    tester,
  ) async {
    var cleared = '';
    await pumpProfile(tester, onClear: (label) => cleared = label);

    await reveal(tester, 'Map cache');
    // Only the clearable categories get one; shop photos does not.
    expect(find.text('Clear'), findsNWidgets(2));

    await tester.tap(find.text('Clear').first);
    await tester.pumpAndSettle();
    expect(cleared, isNotEmpty);
  });

  testWidgets('AGT-17 device details and offline toggle are present', (
    tester,
  ) async {
    await pumpProfile(tester);

    await reveal(tester, 'Samsung Galaxy A12');
    expect(find.text('Android 12'), findsOneWidget);
    expect(find.text('2.4.1 (build 118)'), findsOneWidget);

    await reveal(tester, 'Offline capture');
    expect(find.byType(AppSwitchTrack), findsOneWidget);
  });

  testWidgets('AGT-17 install prompt and sign out are both reachable', (
    tester,
  ) async {
    var installed = false;
    var signedOut = false;
    await pumpLocalized(
      tester,
      size: const Size(360, 800),
      child: ProfilePage(
        profile: profile,
        storageCategories: storage,
        channels: channels,
        onInstall: () => installed = true,
        onSignOut: () => signedOut = true,
      ),
    );

    await reveal(tester, 'Add to home screen');
    expect(find.byType(InstallPromptCard), findsOneWidget);
    expect(find.text('Sign out'), findsOneWidget);

    await tester.tap(find.text('Add to home screen'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Sign out'));
    await tester.pumpAndSettle();

    expect(installed, isTrue);
    expect(signedOut, isTrue);
  });

  testWidgets('AGT-17 settings rows meet the minimum touch bound', (
    tester,
  ) async {
    await pumpProfile(tester);

    final row = find.widgetWithText(SettingsRow, 'Language').first;
    expect(
      tester.getSize(row).height,
      greaterThanOrEqualTo(AppDimensions.minTouchTarget),
    );
  });

  testWidgets('AGT-17 notifications list each channel and its last send', (
    tester,
  ) async {
    await pumpLocalized(
      tester,
      size: const Size(360, 800),
      child: NotificationChannelsPage(
        channels: const [
          NotificationChannel(
            id: 'sms',
            detail: 'Booking requests and verdicts',
            enabled: true,
            lastSentAt: '13 Oct, 11:08',
            delivered: true,
          ),
          NotificationChannel(
            id: 'push',
            detail: 'Bounty updates',
            enabled: false,
            lastSentAt: '',
            delivered: false,
          ),
        ],
      ),
    );

    expect(find.text('Notifications'), findsOneWidget);
    expect(find.text('SMS'), findsOneWidget);
    expect(find.text('Booking requests and verdicts'), findsOneWidget);
    expect(find.text('Push'), findsOneWidget);
    expect(find.text('Bounty updates'), findsOneWidget);

    expect(find.text('Last SMS sent'), findsOneWidget);
    expect(find.text('13 Oct, 11:08'), findsOneWidget);
    // Delivery is stated, not implied by the absence of an error.
    expect(find.text('delivered'), findsOneWidget);
    expect(find.text('not delivered'), findsNothing);
  });

  testWidgets('AGT-17 notification toggles report their channel', (
    tester,
  ) async {
    final changed = <String, bool>{};
    await pumpLocalized(
      tester,
      size: const Size(360, 800),
      child: NotificationChannelsPage(
        channels: const [
          NotificationChannel(
            id: 'sms',
            detail: 'Booking requests and verdicts',
            enabled: true,
            lastSentAt: '',
            delivered: false,
          ),
          NotificationChannel(
            id: 'push',
            detail: 'Bounty updates',
            enabled: false,
            lastSentAt: '',
            delivered: false,
          ),
        ],
        onChanged: (id, value) => changed[id] = value,
      ),
    );

    final toggles = find.byType(AppSwitchTrack);
    expect(toggles, findsNWidgets(2));
    await tester.tap(toggles.last);
    await tester.pumpAndSettle();

    expect(changed['push'], isTrue);
  });
}
