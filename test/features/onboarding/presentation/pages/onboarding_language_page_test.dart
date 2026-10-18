import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/features/onboarding/presentation/bloc/onboarding_cubit.dart';
import 'package:gcc_app/features/onboarding/presentation/pages/onboarding_language_page.dart';
import 'package:gcc_app/features/onboarding/presentation/widgets/onboarding_language_row.dart';

import '../../../../helpers/pump_app.dart';
import '../../../auth/fake_session_repository.dart';
import '../../fake_onboarding_gateway.dart';

void main() {
  testWidgets('shows native names and disables untranslated languages', (
    tester,
  ) async {
    final cubit = OnboardingCubit(
      FakeOnboardingGateway(),
      FakeSessionRepository(),
    );
    await pumpLocalized(
      tester,
      size: const Size(360, 800),
      child: BlocProvider.value(
        value: cubit,
        child: const OnboardingLanguagePage(),
      ),
    );

    expect(find.text('Yorùbá'), findsOneWidget);
    expect(find.text('Asụsụ Igbo'), findsOneWidget);
    expect(find.text('Harshen Hausa'), findsOneWidget);
    expect(find.text('Choose a language to continue.'), findsOneWidget);
    expect(
      find.text("This language isn't available in the app yet."),
      findsNWidgets(4),
    );

    await tester.tap(find.byType(OnboardingLanguageRow).first);
    await tester.pump();

    final selected = tester
        .widgetList<OnboardingLanguageRow>(find.byType(OnboardingLanguageRow))
        .where((row) => row.selected);
    expect(selected.length, 1);
    expect(selected.single.option.id, 'english');

    await tester.tap(find.text('Yorùbá'));
    await tester.pump();

    expect(
      tester
          .widgetList<OnboardingLanguageRow>(find.byType(OnboardingLanguageRow))
          .where((row) => row.selected)
          .single
          .option
          .id,
      'english',
    );
    expect(find.text('Choose a language to continue.'), findsNothing);
  });
}
