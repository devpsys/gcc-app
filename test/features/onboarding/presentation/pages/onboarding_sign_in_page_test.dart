import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/features/onboarding/presentation/bloc/onboarding_cubit.dart';
import 'package:gcc_app/features/onboarding/presentation/onboarding_language.dart';
import 'package:gcc_app/features/onboarding/presentation/onboarding_role.dart';
import 'package:gcc_app/features/onboarding/presentation/pages/onboarding_sign_in_page.dart';

import '../../../../helpers/pump_app.dart';
import '../../fake_onboarding_gateway.dart';

void main() {
  testWidgets('keeps send code disabled until 11 digits', (tester) async {
    final cubit = OnboardingCubit(FakeOnboardingGateway())
      ..selectLanguage(OnboardingLanguage.english)
      ..selectRole(OnboardingRole.rent);
    await pumpLocalized(
      tester,
      size: const Size(360, 800),
      child: BlocProvider.value(
        value: cubit,
        child: const OnboardingSignInPage(),
      ),
    );

    expect(find.text('+234'), findsOneWidget);
    expect(find.text('Enter your mobile number to continue.'), findsOneWidget);

    await tester.enterText(find.byType(TextField).first, '08031234567');
    await tester.pump();

    final prefix = tester.getRect(find.text('+234'));
    final number = tester.getRect(find.text('08031234567'));
    expect((number.center.dy - prefix.center.dy).abs(), lessThan(1));

    final button = tester.widget<FilledButton>(
      find.widgetWithText(FilledButton, 'Send code'),
    );
    expect(button.onPressed, isNotNull);

    await tester.tap(find.widgetWithText(FilledButton, 'Send code'));
    await tester.pump();
    await tester.pump();

    final verify = tester.widget<FilledButton>(
      find.widgetWithText(FilledButton, 'Verify'),
    );
    expect(verify.onPressed, isNull);
    expect(find.text('Enter all 6 digits to continue.'), findsOneWidget);

    await tester.enterText(find.byType(TextField).last, '12345');
    await tester.pump();

    expect(
      tester
          .widget<FilledButton>(find.widgetWithText(FilledButton, 'Verify'))
          .onPressed,
      isNull,
    );

    await tester.tap(find.text('Sign in with your email instead.'));
    await tester.pump();
    expect(tester.takeException(), isNull);
  });
}
