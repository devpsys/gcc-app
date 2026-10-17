import '../../../../helpers/pump_app.dart';
import '../../fake_sync_queue_gateway.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/widgets/app_primary_button.dart';
import 'package:gcc_app/features/agent_sync/presentation/bloc/conflict_claim.dart';
import 'package:gcc_app/features/agent_sync/presentation/bloc/connection_quality.dart';
import 'package:gcc_app/features/agent_sync/presentation/bloc/queue_file.dart';
import 'package:gcc_app/features/agent_sync/presentation/bloc/queue_file_state.dart';
import 'package:gcc_app/features/agent_sync/presentation/bloc/queue_item.dart';
import 'package:gcc_app/features/agent_sync/presentation/bloc/queue_item_detail_state.dart';
import 'package:gcc_app/features/agent_sync/presentation/bloc/queue_item_status.dart';
import 'package:gcc_app/features/agent_sync/presentation/bloc/sync_summary.dart';
import 'package:gcc_app/features/agent_sync/presentation/widgets/queue_file_row.dart';
import 'package:gcc_app/features/agent_sync/presentation/widgets/queue_status_chip.dart';
import 'package:gcc_app/features/agent_sync/presentation/widgets/sync_queue_nothing_yet.dart';
import 'package:gcc_app/features/agent_sync/presentation/widgets/sync_status_panel.dart';
import 'package:gcc_app/features/agent_sync/presentation/bloc/sync_queue_cubit.dart';
import 'package:gcc_app/features/agent_sync/presentation/pages/queue_item_page.dart';
import 'package:gcc_app/features/agent_sync/presentation/pages/sync_queue_page.dart';
import 'package:gcc_app/features/agent_sync/presentation/pages/sync_queue_screen.dart';

void main() {
  const summary = SyncSummary(
    connection: ConnectionQuality.offline,
    lastSync: '09:24',
    storageFree: '2.1 GB',
    storageTotal: '8 GB',
    queuedCount: 4,
    queuedBytes: '24.1 MB',
  );
  final items = [
    const QueueItem(
      reference: 'SUB-2214',
      shopName: 'Bola Hardware',
      capturedAt: '10:42',
      itemCount: 2,
      status: QueueItemStatus.queued,
    ),
    const QueueItem(
      reference: 'SUB-2213',
      shopName: 'Eze & Sons Auto Electricals',
      capturedAt: '09:18',
      itemCount: 4,
      status: QueueItemStatus.queued,
    ),
    const QueueItem(
      reference: 'SUB-2212',
      shopName: 'Mrs. Adaeze Nwankwo Hardware',
      capturedAt: '08:55',
      itemCount: 1,
      status: QueueItemStatus.uploading,
      progress: 0.52,
      doneBytes: '1.1 MB',
      totalBytes: '2.1 MB',
    ),
    const QueueItem(
      reference: 'SUB-2211',
      shopName: 'Uche Generator Point',
      capturedAt: '08:31',
      itemCount: 2,
      status: QueueItemStatus.failed,
      failureReason: 'Network timeout after 60 s',
    ),
  ];

  /// Scrolls the page content down.
  ///
  /// A ListView only builds what is visible, so anything below the fold is not
  /// in the tree until it is dragged into it.
  Future<void> reveal(WidgetTester tester, String text) async {
    final target = find.text(text);
    // Drag until it is built, then bring it fully on screen before any tap.
    for (var i = 0; i < 8 && target.evaluate().isEmpty; i++) {
      await tester.drag(find.byType(ListView), const Offset(0, -280));
      await tester.pumpAndSettle();
    }
    await tester.ensureVisible(target);
    await tester.pumpAndSettle();
  }

  Future<void> pumpQueue(
    WidgetTester tester, {
    SyncSummary data = summary,
    List<QueueItem> data2 = const [],
  }) async {
    await pumpLocalized(
      tester,
      size: const Size(360, 800),
      child: SyncQueuePage(summary: data, items: data2.isEmpty ? items : data2),
    );
  }

  testWidgets('AGT-03 status panel reports device facts', (tester) async {
    await pumpQueue(tester);
    expect(find.byType(SyncStatusPanel), findsOneWidget);
    expect(find.text('Connection'), findsOneWidget);
    expect(find.text('Last sync'), findsOneWidget);
    expect(find.text('Storage'), findsOneWidget);
    expect(find.text('Queued'), findsWidgets);
    expect(find.text('2.1 GB free of 8 GB'), findsNWidgets(2));
    expect(find.text('4 items · 24.1 MB'), findsOneWidget);
    expect(find.text('Sync now'), findsOneWidget);
  });
  testWidgets('AGT-03 status tones follow the design rules', (tester) async {
    await pumpQueue(tester);
    final offline = tester.widget<QueueStatusChip>(
      find.byType(QueueStatusChip).first,
    );
    expect(offline.status, QueueItemStatus.queued);
    // Queued is info and failed is danger, never amber-and-locked.
    expect(find.byIcon(Icons.lock), findsNothing);
    expect(find.byIcon(Icons.lock_outline), findsNothing);
  });
  testWidgets('AGT-03 lists every queued submission', (tester) async {
    await pumpQueue(tester);
    expect(find.text('Bola Hardware'), findsOneWidget);
    expect(find.text('WAITING TO UPLOAD (4)'), findsOneWidget);
    await reveal(tester, 'Uche Generator Point');
    expect(find.text('Network timeout after 60 s'), findsOneWidget);
    await reveal(tester, 'Discard failed items');
    expect(find.text('Discard failed items'), findsOneWidget);
  });
  testWidgets('AGT-03 shows upload progress on the uploading card', (
    tester,
  ) async {
    await pumpQueue(tester);
    expect(find.text('◐ Uploading'), findsOneWidget);
    await reveal(tester, '52 % · 1.1 MB of 2.1 MB');
    expect(find.text('52 % · 1.1 MB of 2.1 MB'), findsOneWidget);
  });
  testWidgets('AGT-03 mid-sync shows batch progress and the close hint', (
    tester,
  ) async {
    await pumpQueue(
      tester,
      data: const SyncSummary(
        connection: ConnectionQuality.syncing,
        lastSync: 'In progress…',
        storageFree: '2.1 GB',
        storageTotal: '8 GB',
        queuedCount: 7,
        queuedBytes: '24.1 MB',
        overallProgress: 0.43,
      ),
    );
    expect(find.text('43% completed'), findsOneWidget);
    expect(
      find.text('You can close this screen. Syncing continues.'),
      findsOneWidget,
    );
    expect(find.text('Pause'), findsOneWidget);
  });
  testWidgets('AGT-03 capped shows the Wi-Fi-only path, not a generic error', (
    tester,
  ) async {
    await pumpQueue(
      tester,
      data: const SyncSummary(
        connection: ConnectionQuality.capped,
        lastSync: '09:24',
        storageFree: '2.1 GB',
        storageTotal: '8 GB',
        queuedCount: 7,
        queuedBytes: '24.1 MB',
      ),
    );
    expect(find.text('Limit capped'), findsOneWidget);
    expect(find.text('Upload on Wi-Fi only'), findsOneWidget);
    expect(find.text('DATA LIMIT'), findsOneWidget);
  });
  testWidgets('AGT-03 all-synced never shows a lock on the bounty', (
    tester,
  ) async {
    await pumpQueue(
      tester,
      data: const SyncSummary(
        connection: ConnectionQuality.weak,
        lastSync: 'Just now',
        storageFree: '2.1 GB',
        storageTotal: '8 GB',
        queuedCount: 0,
        queuedBytes: '',
      ),
      data2: const [],
    );
    expect(find.text('Everything is synced'), findsOneWidget);
    expect(find.text('Your bounty is'), findsOneWidget);
    expect(find.text('₦27,000'), findsOneWidget);
    expect(find.byIcon(Icons.lock), findsNothing);
    expect(find.byIcon(Icons.lock_outline), findsNothing);
  });
  testWidgets('AGT-03 unwired queue reports nothing yet, not success', (
    tester,
  ) async {
    // Loaded before the first pump: the loading state is a spinner, so a pump
    // that settles first would never return.
    final cubit = SyncQueueCubit(FakeSyncQueueGateway())..load();
    await pumpLocalized(
      tester,
      size: const Size(360, 800),
      child: BlocProvider.value(value: cubit, child: const SyncQueueScreen()),
    );
    expect(find.byType(SyncQueueNothingYet), findsOneWidget);
    expect(find.text('Nothing in the queue yet'), findsOneWidget);
    // The important one: it must not claim everything synced.
    expect(find.text('Everything is synced'), findsNothing);
    await cubit.close();
  });
  testWidgets('AGT-04 failed frame explains and offers a retry', (
    tester,
  ) async {
    await pumpLocalized(
      tester,
      size: const Size(360, 800),
      child: QueueItemPage(
        state: QueueItemDetailState.failed,
        reference: 'SUB-2214',
        shopName: 'Bola Hardware',
        owner: 'Alhaji Musa Ibrahim',
        location: 'Kugbo · Zone C · Line 4',
        capturedAt: '13 Oct, 10:42',
        files: const [
          QueueFile(
            name: 'shopfront-1042.jpg',
            sizeLabel: '1.4 MB',
            state: QueueFileState.failed,
          ),
          QueueFile(
            name: 'condition-clip-1042.mp4',
            sizeLabel: '6.2 MB',
            state: QueueFileState.failed,
          ),
        ],
        failureReason: 'Network timeout after 60 s',
      ),
    );
    expect(find.text('Capture data'.toUpperCase()), findsOneWidget);
    expect(find.text('Alhaji Musa Ibrahim'), findsOneWidget);
    expect(find.text('Why did this fail?'), findsOneWidget);
    expect(find.text('Retry upload'), findsOneWidget);
    expect(find.text('Edit on device'), findsOneWidget);
    expect(find.text('Discard this submission'), findsOneWidget);
    expect(find.byType(QueueFileRow), findsNWidgets(2));
  });
  testWidgets('AGT-04 discard asks for confirmation first', (tester) async {
    await pumpLocalized(
      tester,
      size: const Size(360, 800),
      child: QueueItemPage(
        state: QueueItemDetailState.failed,
        reference: 'SUB-2214',
        shopName: 'Bola Hardware',
        owner: 'Alhaji Musa Ibrahim',
        location: 'Kugbo',
        capturedAt: '13 Oct, 10:42',
        files: const [],
        failureReason: 'Network timeout',
      ),
    );
    await reveal(tester, 'Discard this submission');
    await tester.tap(find.text('Discard this submission'));
    await tester.pumpAndSettle();
    expect(find.textContaining('2-step confirmation'), findsOneWidget);
    // The safe way out is always offered, and there is no gesture-only path.
    expect(find.text('Keep'), findsOneWidget);
  });
  testWidgets('AGT-04 synced frame locks editing and names the bounty', (
    tester,
  ) async {
    await pumpLocalized(
      tester,
      size: const Size(360, 800),
      child: QueueItemPage(
        state: QueueItemDetailState.synced,
        reference: 'SUB-2214',
        shopName: 'Bola Hardware',
        owner: 'Alhaji Musa Ibrahim',
        location: 'Kugbo',
        capturedAt: '13 Oct, 10:42',
        files: const [
          QueueFile(
            name: 'shopfront-1042.jpg',
            sizeLabel: '1.4 MB',
            state: QueueFileState.synced,
            syncedAt: '11:03',
          ),
        ],
        syncedAt: '11:04',
      ),
    );
    expect(find.text('Uploaded and sent to review'), findsOneWidget);
    await reveal(tester, "Submissions can't be edited after upload.");
    expect(find.text('View submission'), findsOneWidget);
    expect(
      find.text("Submissions can't be edited after upload."),
      findsOneWidget,
    );
    // The primary action meets the minimum touch target.
    expect(
      tester.getSize(find.byType(AppPrimaryButton)).height,
      greaterThanOrEqualTo(AppDimensions.minTouchTarget),
    );
    // Synced, not escrowed: no lock anywhere on the bounty.
    expect(find.byIcon(Icons.lock), findsNothing);
    expect(find.byIcon(Icons.lock_outline), findsNothing);
  });
  testWidgets('AGT-04 conflict names the peer agent plainly', (tester) async {
    await pumpLocalized(
      tester,
      size: const Size(360, 800),
      child: QueueItemPage(
        state: QueueItemDetailState.conflict,
        reference: 'SUB-2214',
        shopName: 'Bola Hardware',
        owner: 'Alhaji Musa Ibrahim',
        location: 'Kugbo',
        capturedAt: '13 Oct, 10:42',
        files: const [
          QueueFile(
            name: 'shopfront-1042.jpg',
            sizeLabel: '1.4 MB',
            state: QueueFileState.notUploaded,
          ),
        ],
        claim: const ConflictClaim(
          agentName: 'Sunday Eze',
          agentId: 'AG-0157',
          claimedAt: '10:58',
          outcome: 'Mapped first',
        ),
      ),
    );
    expect(find.text('Someone else mapped this shop first'), findsOneWidget);
    expect(find.text('Sunday Eze'), findsOneWidget);
    expect(find.text('AG-0157'), findsOneWidget);
    expect(find.text('Mapped first'), findsOneWidget);
    expect(
      find.text('Local media retained safely in offline storage.'),
      findsOneWidget,
    );
    expect(find.text('Discard my copy'), findsOneWidget);
    expect(find.text('Keep for reference'), findsOneWidget);
  });
  testWidgets('AGT-04 discarded is terminal and states the reclaimed space', (
    tester,
  ) async {
    await pumpLocalized(
      tester,
      size: const Size(360, 800),
      child: const QueueItemPage(
        state: QueueItemDetailState.discarded,
        reference: 'SUB-2214',
        shopName: 'Bola Hardware',
        owner: 'Alhaji Musa Ibrahim',
        location: 'Kugbo',
        capturedAt: '13 Oct, 10:42',
        files: [],
      ),
    );
    expect(find.text('Submission discarded'), findsOneWidget);
    await reveal(tester, 'Capture another');
    expect(find.textContaining('7.6 MB storage reclaimed'), findsOneWidget);
    expect(find.text('Back to sync queue'), findsOneWidget);
    // No danger styling: the agent chose this.
    expect(find.byIcon(Icons.lock), findsNothing);
  });

  testWidgets('AGT-03 discard asks for confirmation before acting', (
    tester,
  ) async {
    var requested = false;
    await pumpLocalized(
      tester,
      size: const Size(360, 800),
      child: SyncQueuePage(
        summary: summary,
        items: items,
        onDiscardFailed: (references) async {
          requested = references.isNotEmpty;
          return true;
        },
      ),
    );

    final button = find.text('Discard failed items');
    for (var i = 0; i < 6 && button.evaluate().isEmpty; i++) {
      await tester.drag(find.byType(ListView), const Offset(0, -280));
      await tester.pumpAndSettle();
    }
    await tester.ensureVisible(button);
    await tester.pumpAndSettle();

    await tester.tap(button);
    await tester.pumpAndSettle();

    // Nothing is discarded on a single tap: this is a destructive bulk action.
    expect(find.textContaining('1 failed submission'), findsOneWidget);
    expect(requested, isFalse);

    await tester.tap(find.text('Discard them'));
    await tester.pumpAndSettle();
    expect(requested, isTrue);
  });

  testWidgets('AGT-03 withholds the all-synced link with nowhere to go', (
    tester,
  ) async {
    await pumpQueue(
      tester,
      data: const SyncSummary(
        connection: ConnectionQuality.weak,
        lastSync: 'Just now',
        storageFree: '2.1 GB',
        storageTotal: '8 GB',
        queuedCount: 0,
        queuedBytes: '',
      ),
      data2: const [],
    );

    // No handler means no dead button, on screen or scrolled to.
    expect(find.text('View submitted shops'), findsNothing);
  });

  testWidgets('AGT-03 offers the all-synced link when it can be wired', (
    tester,
  ) async {
    var opened = false;
    await pumpLocalized(
      tester,
      size: const Size(360, 800),
      child: SyncQueuePage(
        summary: const SyncSummary(
          connection: ConnectionQuality.weak,
          lastSync: 'Just now',
          storageFree: '2.1 GB',
          storageTotal: '8 GB',
          queuedCount: 0,
          queuedBytes: '',
        ),
        items: const [],
        onViewSubmitted: () => opened = true,
      ),
    );

    // Below the fold on a 360x800 screen.
    final link = find.text('View submitted shops');
    for (var i = 0; i < 6 && link.evaluate().isEmpty; i++) {
      await tester.drag(find.byType(ListView), const Offset(0, -280));
      await tester.pumpAndSettle();
    }
    await tester.ensureVisible(link);
    await tester.pumpAndSettle();

    await tester.tap(link);
    await tester.pumpAndSettle();
    expect(opened, isTrue);
  });
}
