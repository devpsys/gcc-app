import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/core/network/controllable_online_checker.dart';
import 'package:gcc_app/core/network/online_status_cubit.dart';
import 'package:gcc_app/core/widgets/language_picker_sheet.dart';
import 'package:gcc_app/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:gcc_app/features/auth/presentation/pages/agent_sign_in_page.dart';
import 'package:gcc_app/features/auth/presentation/widgets/auth_offline_banner.dart';

import '../../../../helpers/pump_app.dart';
import '../../fake_agent_auth_gateway.dart';
import '../../fake_session_repository.dart';

Future<void> _pumpSignIn(
  WidgetTester tester, {
  required AuthCubit auth,
  bool online = true,
  Size size = const Size(360, 800),
  TextScaler textScaler = TextScaler.noScaling,
}) async {
  final checker = ControllableOnlineChecker(isOnline: online);
  addTearDown(checker.dispose);
  await pumpLocalized(
    tester,
    size: size,
    textScaler: textScaler,
    child: MultiBlocProvider(
      providers: [
        BlocProvider.value(value: auth),
        BlocProvider(create: (_) => OnlineStatusCubit(checker)),
      ],
      child: const AgentSignInPage(),
    ),
  );
}

void main() {
  testWidgets('shows Frame 01 chrome with role pills in design order', (
    tester,
  ) async {
    final cubit = AuthCubit(FakeAgentAuthGateway(), FakeSessionRepository());
    await _pumpSignIn(tester, auth: cubit);

    expect(find.textContaining('Agent (AG-)'), findsOneWidget);
    expect(find.textContaining('Vendor (VND-)'), findsOneWidget);
    expect(find.textContaining('Lessee (LSE-)'), findsOneWidget);
    expect(find.text('Scan QR code on your ID card'), findsOneWidget);
    expect(find.text('Continue'), findsOneWidget);
    expect(find.text('Enter your ID to continue.'), findsOneWidget);
    expect(find.byType(AuthOfflineBanner), findsNothing);

    final pills = tester.widgetList<Text>(
      find.textContaining('(AG-)').evaluate().isEmpty
          ? find.textContaining('Agent')
          : find.byWidgetPredicate(
              (widget) =>
                  widget is Text &&
                  (widget.data?.contains('(AG-)') == true ||
                      widget.data?.contains('(VND-)') == true ||
                      widget.data?.contains('(LSE-)') == true),
            ),
    );
    final labels = pills.map((text) => text.data!).toList();
    expect(
      labels.indexOf('Agent (AG-)'),
      lessThan(labels.indexOf('Vendor (VND-)')),
    );
    expect(
      labels.indexOf('Vendor (VND-)'),
      lessThan(labels.indexOf('Lessee (LSE-)')),
    );

    await tester.enterText(find.byType(TextField), 'AG-12');
    await tester.pump();
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump();

    expect(find.textContaining('valid ID'), findsWidgets);
    expect(tester.takeException(), isNull);
  });

  testWidgets('shows offline banner when the device is offline', (
    tester,
  ) async {
    final cubit = AuthCubit(FakeAgentAuthGateway(), FakeSessionRepository());
    await _pumpSignIn(tester, auth: cubit, online: false);

    expect(find.byType(AuthOfflineBanner), findsOneWidget);
    expect(find.text('Offline — using cached session'), findsOneWidget);
    expect(find.text('Retry'), findsOneWidget);
  });

  testWidgets('shows unknown identifier recovery', (tester) async {
    final gateway = FakeAgentAuthGateway()
      ..requestFailure = const ValidationFailure(
        fieldErrors: {'identifier': []},
      );
    final cubit = AuthCubit(gateway, FakeSessionRepository());
    await _pumpSignIn(tester, auth: cubit);

    await tester.enterText(find.byType(TextField), 'AG-9999');
    await tester.pump();
    await tester.tap(find.text('Continue'));
    await tester.pump();
    await tester.pump();

    expect(find.text('ID not recognized'), findsOneWidget);
    expect(find.text('Try Again'), findsOneWidget);
    expect(find.textContaining('AG-9999'), findsWidgets);
  });

  testWidgets('opens the language sheet with native names', (tester) async {
    final cubit = AuthCubit(FakeAgentAuthGateway(), FakeSessionRepository());
    await _pumpSignIn(tester, auth: cubit);

    await tester.tap(find.textContaining('Language:'));
    await tester.pumpAndSettle();

    expect(find.text('Select Language'), findsOneWidget);
    expect(find.text('Èdè Yorùbá'), findsOneWidget);
    expect(find.text('Asụsụ Igbo'), findsOneWidget);

    final unavailable = find.text(
      "This language isn't available in the app yet.",
    );
    final sheetList = find.descendant(
      of: find.byType(LanguagePickerSheet),
      matching: find.byType(ListView),
    );
    for (var i = 0; i < 5 && unavailable.evaluate().length < 4; i++) {
      await tester.drag(sheetList, const Offset(0, -200));
      await tester.pumpAndSettle();
    }
    expect(unavailable, findsNWidgets(4));
  });

  testWidgets('survives a short viewport and large text', (tester) async {
    final cubit = AuthCubit(FakeAgentAuthGateway(), FakeSessionRepository());
    await _pumpSignIn(
      tester,
      auth: cubit,
      size: const Size(320, 640),
      textScaler: const TextScaler.linear(2),
    );

    expect(tester.takeException(), isNull);
  });
}
