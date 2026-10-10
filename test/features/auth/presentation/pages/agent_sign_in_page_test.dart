import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/auth/presentation/bloc/agent_auth_cubit.dart';
import 'package:gcc_app/features/auth/presentation/pages/agent_sign_in_page.dart';

import '../../../../helpers/pump_app.dart';
import '../../fake_agent_auth_gateway.dart';

void main() {
  testWidgets('disables continue until the identifier is valid', (
    tester,
  ) async {
    final cubit = AgentAuthCubit(FakeAgentAuthGateway());
    await pumpLocalized(
      tester,
      size: const Size(360, 800),
      child: BlocProvider.value(value: cubit, child: const AgentSignInPage()),
    );

    expect(find.text('OR USE SCANNER'), findsOneWidget);
    expect(find.text('Enter your agent ID to continue.'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'AG-12');
    await tester.pump();

    expect(find.text('Enter an ID like AG-0142 to continue.'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('shows an unknown identifier error once', (tester) async {
    final gateway = FakeAgentAuthGateway()
      ..requestFailure = const ValidationFailure(
        fieldErrors: {'identifier': []},
      );
    final cubit = AgentAuthCubit(gateway);
    await pumpLocalized(
      tester,
      size: const Size(360, 800),
      child: BlocProvider.value(value: cubit, child: const AgentSignInPage()),
    );

    await tester.enterText(find.byType(TextField), 'AG-9999');
    await tester.pump();
    await tester.tap(find.text('Continue'));
    await tester.pump();
    await tester.pump();

    expect(
      find.text(
        "We couldn't find AG-9999. Check the ID, or contact your coordinator.",
      ),
      findsOneWidget,
    );
  });

  testWidgets('opens the language sheet with native names', (tester) async {
    final cubit = AgentAuthCubit(FakeAgentAuthGateway());
    await pumpLocalized(
      tester,
      size: const Size(360, 800),
      child: BlocProvider.value(value: cubit, child: const AgentSignInPage()),
    );

    await tester.tap(find.text('Language'));
    await tester.pumpAndSettle();

    expect(find.text('Èdè Yorùbá'), findsOneWidget);
    expect(find.text('Asụsụ Igbo'), findsOneWidget);
    expect(
      find.text("This language isn't available in the app yet."),
      findsNWidgets(4),
    );
  });

  testWidgets('survives a short viewport and large text', (tester) async {
    final cubit = AgentAuthCubit(FakeAgentAuthGateway());
    await pumpLocalized(
      tester,
      size: const Size(320, 640),
      textScaler: const TextScaler.linear(2),
      child: BlocProvider.value(value: cubit, child: const AgentSignInPage()),
    );

    expect(tester.takeException(), isNull);
  });
}
