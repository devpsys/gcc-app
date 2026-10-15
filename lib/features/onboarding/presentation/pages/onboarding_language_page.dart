import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/router/route_paths.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/app_primary_button.dart';
import 'package:gcc_app/core/widgets/language_catalog.dart';
import 'package:gcc_app/features/onboarding/presentation/bloc/onboarding_cubit.dart';
import 'package:gcc_app/features/onboarding/presentation/bloc/onboarding_state.dart';
import 'package:gcc_app/features/onboarding/presentation/onboarding_language.dart';
import 'package:gcc_app/features/onboarding/presentation/widgets/first_run_scaffold.dart';
import 'package:gcc_app/features/onboarding/presentation/widgets/onboarding_language_row.dart';
import 'package:go_router/go_router.dart';

class OnboardingLanguagePage extends StatelessWidget {
  const OnboardingLanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        final selected = state.language?.name;
        final canContinue = state.language?.isAvailable ?? false;
        final options = gccLanguageOptions(l10n);
        final scheme = Theme.of(context).colorScheme;
        return FirstRunScaffold(
          step: 0,
          centerHeader: true,
          showBrandMark: true,
          title: l10n.onboardingChooseLanguage,
          subtitle: l10n.onboardingChangeAnytime,
          footer: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppPrimaryButton(
                label: l10n.onboardingContinue,
                onPressed: canContinue
                    ? () => context.go(RoutePaths.onboardingRole)
                    : null,
                disabledReason: l10n.onboardingContinueNeedsLanguage,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                l10n.onboardingTranslationsReviewed,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          body: DecoratedBox(
            decoration: BoxDecoration(
              color: scheme.surface,
              borderRadius: BorderRadius.circular(AppRadii.dialog),
              border: Border.all(color: context.semanticColors.border),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppRadii.dialog),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (var index = 0; index < options.length; index++) ...[
                    if (index > 0)
                      ColoredBox(
                        color: scheme.surfaceContainerHighest,
                        child: const SizedBox(
                          height: AppDimensions.borderWidth,
                        ),
                      ),
                    OnboardingLanguageRow(
                      option: options[index],
                      selected: options[index].id == selected,
                      unavailableReason: l10n.authLanguageUnavailable,
                      onTap: () =>
                          context.read<OnboardingCubit>().selectLanguage(
                            OnboardingLanguage.values.byName(options[index].id),
                          ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
