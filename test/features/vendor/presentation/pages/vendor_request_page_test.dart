import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/features/vendor/domain/vendor_booking_request.dart';
import 'package:gcc_app/features/vendor/presentation/bloc/vendor_request_cubit.dart';
import 'package:gcc_app/features/vendor/presentation/gateway/mock_vendor_request_gateway.dart';
import 'package:gcc_app/features/vendor/presentation/gateway/vendor_request_gateway.dart';
import 'package:gcc_app/features/vendor/presentation/pages/vendor_request_screen.dart';
import 'package:gcc_app/features/vendor/presentation/widgets/request_accept_dialog.dart';

import '../../../../helpers/pump_app.dart';

void main() {
  testWidgets('shows the active request without locking the payout', (
    tester,
  ) async {
    await _pump(tester, const MockVendorRequestGateway());

    expect(find.textContaining('BK-24817'), findsWidgets);
    await tester.scrollUntilVisible(
      find.text('₦99,900'),
      400,
      scrollable: find.byType(Scrollable).last,
    );
    expect(find.text('₦99,900'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.byIcon(Icons.lock),
      200,
      scrollable: find.byType(Scrollable).last,
    );
    expect(find.textContaining('₦50,000'), findsOneWidget);
    expect(find.byIcon(Icons.lock), findsOneWidget);
    expect(find.text('Accept booking'), findsOneWidget);
    expect(find.text('Reject'), findsOneWidget);
  });

  testWidgets('accepting confirms the collection window', (tester) async {
    await _pump(tester, const MockVendorRequestGateway());

    await tester.tap(find.text('Accept booking'));
    await tester.pumpAndSettle();
    expect(find.text('Accept BK-24817?'), findsOneWidget);

    await tester.tap(
      find.descendant(
        of: find.byType(RequestAcceptDialog),
        matching: find.text('Accept booking'),
      ),
    );
    await tester.pumpAndSettle();

    expect(
      find.text('Collection confirmed for 14 Oct, 08:00 – 09:00'),
      findsWidgets,
    );
    expect(find.text('Accepted by SMS'), findsNothing);
  });

  testWidgets('declining requires a reason and a note', (tester) async {
    await _pump(tester, const MockVendorRequestGateway());

    await tester.tap(find.text('Reject'));
    await tester.pumpAndSettle();

    final decline = tester.widget<FilledButton>(
      find.widgetWithText(FilledButton, 'Decline request'),
    );
    expect(decline.onPressed, isNull);

    await tester.tap(find.text('Asset unavailable'));
    await tester.enterText(find.byType(TextField), 'The yard is closed');
    await tester.pumpAndSettle();
    await tester.tap(find.text('Decline request'));
    await tester.pumpAndSettle();

    expect(find.text('Request declined'), findsOneWidget);
    expect(find.text('The yard is closed'), findsOneWidget);
  });

  testWidgets('an SMS acceptance shows the audit trail', (tester) async {
    await _pump(tester, const _SmsGateway());

    expect(find.text('Accepted by SMS'), findsWidgets);
    expect(find.text('Request received'), findsOneWidget);
    expect(find.text('Collection at yard'), findsOneWidget);
    expect(find.byIcon(Icons.lock), findsOneWidget);
  });

  testWidgets('request lays out at 320×640 with text scale 2', (tester) async {
    await _pump(
      tester,
      const MockVendorRequestGateway(),
      size: const Size(320, 640),
      scale: 2,
    );
    expect(tester.takeException(), isNull);
  });
}

Future<void> _pump(
  WidgetTester tester,
  VendorRequestGateway gateway, {
  Size size = const Size(360, 800),
  double scale = 1,
}) async {
  final cubit = VendorRequestCubit(gateway);
  await cubit.load();
  addTearDown(cubit.close);
  await pumpLocalized(
    tester,
    size: size,
    textScaler: TextScaler.linear(scale),
    child: BlocProvider.value(value: cubit, child: const VendorRequestScreen()),
  );
}

final class _SmsGateway implements VendorRequestGateway {
  const _SmsGateway();

  @override
  Future<VendorBookingRequest?> loadRequest() async =>
      MockVendorRequestGateway.smsHandled;

  @override
  Future<int> loadRequestsWaiting() async => 3;
}
