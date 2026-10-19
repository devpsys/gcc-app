import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/features/vendor/presentation/bloc/vendor_notice_cubit.dart';
import 'package:gcc_app/features/vendor/presentation/gateway/mock_vendor_notice_gateway.dart';
import 'package:gcc_app/features/vendor/presentation/pages/vendor_notice_screen.dart';
import 'package:gcc_app/features/vendor/presentation/widgets/vendor_notice_filter_bar.dart';
import 'package:gcc_app/features/vendor/presentation/widgets/vendor_notice_row.dart';

import '../../../../helpers/pump_app.dart';

void main() {
  testWidgets('locks only the frozen deposit and marks the unread ones', (
    tester,
  ) async {
    await _pump(tester);

    expect(find.text('All (5)'), findsOneWidget);
    expect(find.text('Booking request for 100kVA Generator'), findsOneWidget);
    expect(find.byIcon(Icons.lock), findsOneWidget);
    expect(find.bySemanticsLabel(RegExp('Unread')), findsNWidgets(3));

    await tester.drag(find.byType(ListView), const Offset(0, -500));
    await tester.pumpAndSettle();
    final release = find.ancestor(
      of: find.textContaining('₦99,900'),
      matching: find.byType(VendorNoticeRow),
    );
    expect(
      find.descendant(of: release, matching: find.byIcon(Icons.lock)),
      findsNothing,
    );
  });

  testWidgets('mark all read clears the unread dots', (tester) async {
    await _pump(tester);

    await tester.tap(find.text('Mark all read'));
    await tester.pumpAndSettle();

    expect(find.bySemanticsLabel(RegExp('Unread')), findsNothing);
    expect(find.text('Booking request for 100kVA Generator'), findsOneWidget);
  });

  testWidgets('requests keeps the decision and withholds the SMS reply', (
    tester,
  ) async {
    await _pump(tester);

    await tester.tap(
      find.descendant(
        of: find.byType(VendorNoticeFilterBar),
        matching: find.text('Requests'),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Requests (2)'), findsOneWidget);
    expect(find.text('1 item needs a decision'), findsOneWidget);
    expect(find.textContaining('18 Oct, 04:40'), findsWidgets);
    expect(find.text('Payout PAY-8841 sent'), findsNothing);
    final reply = tester.widget<OutlinedButton>(
      find.widgetWithText(OutlinedButton, 'Reply 1 · accept booking'),
    );
    expect(reply.onPressed, isNull);
  });

  testWidgets('money locks the caution deposit and not the returned payout', (
    tester,
  ) async {
    await _pump(tester);

    await tester.tap(find.text('Money'));
    await tester.pumpAndSettle();

    expect(find.text('Money (3)'), findsOneWidget);
    expect(find.textContaining('refunded to buyer'), findsOneWidget);
    expect(find.byIcon(Icons.lock), findsNWidgets(2));
    final failed = find.ancestor(
      of: find.text('Payout PAY-8841 failed'),
      matching: find.byType(VendorNoticeRow),
    );
    expect(
      find.descendant(of: failed, matching: find.byIcon(Icons.lock)),
      findsNothing,
    );
    final open = tester.widget<TextButton>(
      find.widgetWithText(TextButton, 'Open Wallet ledger'),
    );
    expect(open.onPressed, isNotNull);
  });

  testWidgets('notifications lay out at 320×640 with text scale 2', (
    tester,
  ) async {
    await _pump(tester, size: const Size(320, 640), scale: 2);
    await tester.drag(find.byType(ListView), const Offset(0, -800));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });
}

Future<void> _pump(
  WidgetTester tester, {
  Size size = const Size(360, 800),
  double scale = 1,
}) async {
  final cubit = VendorNoticeCubit(const MockVendorNoticeGateway());
  await cubit.load();
  addTearDown(cubit.close);
  await pumpLocalized(
    tester,
    size: size,
    textScaler: TextScaler.linear(scale),
    child: BlocProvider.value(value: cubit, child: const VendorNoticeScreen()),
  );
}
