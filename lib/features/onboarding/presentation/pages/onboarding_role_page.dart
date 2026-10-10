import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/router/route_paths.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/app_primary_button.dart';
import 'package:gcc_app/features/onboarding/presentation/bloc/onboarding_cubit.dart';
import 'package:gcc_app/features/onboarding/presentation/bloc/onboarding_state.dart';
import 'package:gcc_app/features/onboarding/presentation/onboarding_role.dart';
import 'package:gcc_app/features/onboarding/presentation/widgets/first_run_scaffold.dart';
import 'package:gcc_app/features/onboarding/presentation/widgets/onboarding_role_note.dart';
import 'package:gcc_app/features/onboarding/presentation/widgets/role_option_card.dart';
import 'package:go_router/go_router.dart';

class OnboardingRolePage extends StatelessWidget {
  const OnboardingRolePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        final cubit = context.read<OnboardingCubit>();
        final selected = state.role;
        final canContinue =
            selected == OnboardingRole.rent || selected == OnboardingRole.list;
        return FirstRunScaffold(
          step: 1,
          title: l10n.onboardingRoleTitle,
          subtitle: l10n.onboardingRoleSubtitle,
          footer: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppPrimaryButton(
                label: l10n.onboardingContinue,
                onPressed: canContinue
                    ? () => context.go(RoutePaths.onboardingSignIn)
                    : null,
                disabledReason: l10n.onboardingContinueNeedsRole,
              ),
              TextButton(
                onPressed: () {
                  cubit.selectRole(OnboardingRole.browse);
                  context.go(RoutePaths.onboardingSignIn);
                },
                child: Text(l10n.onboardingJustLooking),
              ),
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              RoleOptionCard(
                title: l10n.onboardingRoleRentTitle,
                description: l10n.onboardingRoleRentBody,
                icon: Icons.shopping_bag_outlined,
                selected: selected == OnboardingRole.rent,
                onTap: () => cubit.selectRole(OnboardingRole.rent),
              ),
              const SizedBox(height: AppSpacing.md),
              RoleOptionCard(
                title: l10n.onboardingRoleListTitle,
                description: l10n.onboardingRoleListBody,
                icon: Icons.warehouse_outlined,
                selected: selected == OnboardingRole.list,
                onTap: () => cubit.selectRole(OnboardingRole.list),
              ),
              const SizedBox(height: AppSpacing.sm),
              OnboardingRoleNote(
                text: l10n.onboardingRoleBoth,
                path: l10n.onboardingRolePath,
              ),
            ],
          ),
        );
      },
    );
  }
}
