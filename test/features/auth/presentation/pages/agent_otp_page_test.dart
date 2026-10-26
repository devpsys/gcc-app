import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:gcc_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:gcc_app/features/auth/presentation/pages/agent_otp_page.dart';
import 'package:gcc_app/features/auth/presentation/widgets/otp_code_box.dart';

import '../../../../helpers/pump_app.dart';
import '../../fake_agent_auth_gateway.dart';
import '../../fake_session_repository.dart';

void main() {
  testWidgets('uses one code field and auto-verifies at six digits', (
    tester,
  ) async {
    final gateway = FakeAgentAuthGateway();
    final cubit = AuthCubit(gateway, FakeSessionRepository());
    cubit.identifierChanged('AG-0142');
    await cubit.submitIdentifier();

    final semantics = tester.ensureSemantics();

    await pumpLocalized(
      tester,
      size: const Size(360, 800),
      child: BlocProvider.value(value: cubit, child: const AgentOtpPage()),
    );

    expect(find.byType(TextField), findsOneWidget);
    expect(find.text('Enter all 6 digits to continue.'), findsOneWidget);
    expect(find.textContaining('+234 •••• 2290'), findsOneWidget);
    expect(find.textContaining('STEP 2 OF 2'), findsOneWidget);

    await tester.enterText(find.byType(TextField), '123');
    await tester.pump();

    final boxes = tester.widgetList<OtpCodeBox>(find.byType(OtpCodeBox));
    expect(boxes.where((box) => box.filled).length, 3);

    await tester.enterText(find.byType(TextField), '123456');
    await tester.pump();
    await tester.pump();

    expect(cubit.state, isA<AuthVerified>());
    expect(gateway.verifyCount, 1);
    expect(tester.takeException(), isNull);
    semantics.dispose();
  });
}
