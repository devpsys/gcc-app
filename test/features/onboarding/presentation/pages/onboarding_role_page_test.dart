import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/features/onboarding/presentation/bloc/onboarding_cubit.dart';
import 'package:gcc_app/features/onboarding/presentation/onboarding_language.dart';
import 'package:gcc_app/features/onboarding/presentation/pages/onboarding_role_page.dart';
import 'package:gcc_app/features/onboarding/presentation/widgets/role_option_card.dart';

import '../../../../helpers/pump_app.dart';
import '../../fake_onboarding_gateway.dart';

void main() {
  testWidgets('shows both roles and the look-around action', (tester) async {
    final cubit = OnboardingCubit(FakeOnboardingGateway())
      ..selectLanguage(OnboardingLanguage.english);
    await pumpLocalized(
      tester,
      size: const Size(360, 800),
      child: BlocProvider.value(
        value: cubit,
        child: const OnboardingRolePage(),
      ),
    );

    expect(
      find.textContaining('Browse generators, sound systems'),
      findsOneWidget,
    );
    expect(find.textContaining('Publish rental listings'), findsOneWidget);
    expect(find.text('I just want to look'), findsOneWidget);

    await tester.tap(find.text('Rent or buy equipment'));
    await tester.pump();

    final cards = tester
        .widgetList<RoleOptionCard>(find.byType(RoleOptionCard))
        .toList();
    expect(cards.first.selected, isTrue);
    expect(cards.last.selected, isFalse);
    expect(tester.takeException(), isNull);
  });
}
