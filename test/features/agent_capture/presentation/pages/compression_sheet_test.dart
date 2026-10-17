import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/features/agent_capture/presentation/bloc/media_pipeline.dart';
import 'package:gcc_app/features/agent_capture/presentation/pages/compression_sheet.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/compression_option_row.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/compression_quality_selector.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/compression_size_pair.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/compression_video_preview.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/pipeline_note_panel.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/pipeline_step_list.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/storage_breakdown_panel.dart';

import '../../../../helpers/pump_app.dart';

void main() {
  Future<void> pumpSheet(WidgetTester tester, MediaPipelineStage stage) async {
    await pumpLocalized(
      tester,
      size: const Size(360, 800),
      child: CompressionSheet(stage: stage),
    );
  }

  /// The sheet body scrolls, so later rows only build once dragged into view.
  Future<void> scrollBody(WidgetTester tester) async {
    for (var i = 0; i < 4; i++) {
      await tester.drag(find.byType(Scrollable).first, const Offset(0, -300));
      await tester.pumpAndSettle();
    }
  }

  testWidgets('AGT-10 compressing shows the running step', (tester) async {
    await pumpSheet(tester, MediaPipelineStage.compressing);

    expect(find.byType(CompressionVideoPreview), findsOneWidget);
    expect(find.byType(PipelineStepList), findsOneWidget);
    expect(find.text('Compressed 1080p → optimised'), findsOneWidget);
    // Struck-through original, arrow, then the compressed size. The sizes also
    // appear in the quality rows, so assert on the pair itself.
    final pair = tester.widget<CompressionSizePair>(
      find.byType(CompressionSizePair),
    );
    expect(pair.before, '30.4 MB');
    expect(pair.after, '6.2 MB');
    expect(find.text('Compressing in 8 s…'), findsOneWidget);
    expect(find.text('65%'), findsOneWidget);
    await scrollBody(tester);
    expect(find.text('Uploading when you\'re on data'), findsOneWidget);
  });

  testWidgets('AGT-10 queued reads as waiting, not failed', (tester) async {
    await pumpSheet(tester, MediaPipelineStage.queued);

    expect(find.text('Queued — uploads automatically'), findsOneWidget);
    expect(find.text('Pending 3G'), findsOneWidget);
    expect(find.textContaining('never leaves uncompressed'), findsOneWidget);
  });

  testWidgets('AGT-10 uploading names the network it is using', (tester) async {
    await pumpSheet(tester, MediaPipelineStage.uploading);

    expect(find.text('Uploading · 3.2 MB of 6.2 MB'), findsOneWidget);
    expect(find.textContaining('Kugbo_Fast_WiFi'), findsOneWidget);
    expect(find.text('Wait for the upload to finish'), findsOneWidget);
    expect(find.text('Continue in background'), findsOneWidget);
  });

  testWidgets('AGT-10 low storage is the only danger state', (tester) async {
    await pumpSheet(tester, MediaPipelineStage.storageLow);

    expect(find.byType(StorageBreakdownPanel), findsOneWidget);
    expect(find.text('Not enough storage on this phone'), findsOneWidget);
    expect(find.textContaining('required to upload'), findsOneWidget);
    expect(find.text('Cached upload history'), findsOneWidget);
    expect(find.text('1.4 GB'), findsOneWidget);
    expect(find.text('Free up space'), findsOneWidget);
    expect(find.text('Upload later'), findsOneWidget);
  });

  testWidgets('AGT-10 low battery is a warning, never danger', (tester) async {
    await pumpSheet(tester, MediaPipelineStage.batteryLow);

    expect(find.byType(PipelineNotePanel), findsOneWidget);
    expect(find.text('Paused — waiting for power'), findsOneWidget);
    expect(find.text('Low battery — 8% remaining'), findsOneWidget);
    expect(find.text('Safe'), findsOneWidget);
    // The storage panel is the only danger treatment in this pipeline.
    expect(find.byType(StorageBreakdownPanel), findsNothing);
  });

  testWidgets('AGT-10 never uses a money lock in any stage', (tester) async {
    for (final stage in MediaPipelineStage.values) {
      await pumpSheet(tester, stage);
      expect(
        find.byIcon(Icons.lock_outline),
        findsNothing,
        reason: '$stage must not read as held money',
      );
      expect(find.byIcon(Icons.lock), findsNothing);
    }
  });

  testWidgets('AGT-10 quality selector defaults to the smallest option', (
    tester,
  ) async {
    await pumpSheet(tester, MediaPipelineStage.compressing);

    expect(find.byType(CompressionQualitySelector), findsOneWidget);
    expect(find.text('QUALITY OPTIONS'), findsOneWidget);
    final rows = tester.widgetList<CompressionOptionRow>(
      find.byType(CompressionOptionRow),
    );
    expect(rows, hasLength(3));
    expect(rows.first.selected, isTrue);
    expect(find.text('Recommended'), findsOneWidget);
    // The original is the option the design warns about.
    expect(find.text('Not recommended on 3G'), findsOneWidget);
  });

  testWidgets('AGT-10 keeps every action at least 48px tall', (tester) async {
    await pumpSheet(tester, MediaPipelineStage.compressing);

    expect(
      tester.getSize(find.byType(CompressionOptionRow).first).height,
      greaterThanOrEqualTo(AppDimensions.minTouchTarget),
    );
  });
}
