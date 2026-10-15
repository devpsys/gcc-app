import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/router/route_paths.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/features/onboarding/presentation/bloc/onboarding_cubit.dart';
import 'package:gcc_app/features/onboarding/presentation/bloc/onboarding_state.dart';
import 'package:gcc_app/features/onboarding/presentation/onboarding_role.dart';
import 'package:gcc_app/features/onboarding/presentation/widgets/first_run_scaffold.dart';
import 'package:gcc_app/features/onboarding/presentation/widgets/onboarding_account_note.dart';
import 'package:gcc_app/features/onboarding/presentation/widgets/onboarding_code_field.dart';
import 'package:gcc_app/features/onboarding/presentation/widgets/onboarding_sign_in_action.dart';
import 'package:gcc_app/features/onboarding/presentation/widgets/phone_number_field.dart';
import 'package:go_router/go_router.dart';

class OnboardingSignInPage extends StatelessWidget {
  const OnboardingSignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocListener<OnboardingCubit, OnboardingState>(
      listenWhen: (previous, current) =>
          current is OnboardingCompleted && previous is! OnboardingCompleted,
      listener: (context, state) {
        final role = state.role == OnboardingRole.list ? 'vendor' : 'lessee';
        GoRouter.maybeOf(context)?.go('${RoutePaths.home}?role=$role');
      },
      child: BlocBuilder<OnboardingCubit, OnboardingState>(
        builder: (context, state) {
          final cubit = context.read<OnboardingCubit>();
          final busy = state is OnboardingSubmitting;
          final awaitingCode =
              state is OnboardingCodeRequested ||
              (state is OnboardingSubmitting && state.code.isNotEmpty) ||
              (state is OnboardingFailed && state.code.isNotEmpty);
          final verificationFailed =
              state is OnboardingFailed && state.code.isNotEmpty;
          final codeComplete = state.code.length == OnboardingCubit.codeLength;
          final phoneReady = state.phone.length == OnboardingCubit.phoneLength;
          return FirstRunScaffold(
            step: 2,
            title: l10n.onboardingSignInTitle,
            subtitle: l10n.onboardingSignInSubtitle,
            footer: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                OnboardingSignInAction(
                  busy: busy,
                  awaitingCode: awaitingCode,
                  verificationFailed: verificationFailed,
                  codeComplete: codeComplete,
                  phoneReady: phoneReady,
                  phoneEmpty: state.phone.isEmpty,
                  onSendCode: cubit.requestCode,
                  onVerify: () => cubit.verifyCode(state.code),
                ),
                TextButton(
                  onPressed: busy ? null : cubit.clearPhone,
                  child: Text(l10n.authUseDifferentNumber),
                ),
                const SizedBox(height: AppSpacing.xs),
                OnboardingAccountNote(
                  onSignIn: () =>
                      GoRouter.maybeOf(context)?.push(RoutePaths.agentSignIn),
                ),
              ],
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                PhoneNumberField(
                  label: l10n.onboardingMobileLabel,
                  prefix: l10n.onboardingPhonePrefix,
                  value: state.phone,
                  complete: phoneReady,
                  onChanged: cubit.phoneChanged,
                  onSubmitted: (_) => cubit.requestCode(),
                ),
                const SizedBox(height: AppSpacing.sm),
                OnboardingCodeField(
                  label: l10n.authOtpFieldLabel,
                  helper: l10n.onboardingCodeHelp,
                  value: state.code,
                  enabled: awaitingCode && !busy,
                  errorText: state is OnboardingFailed
                      ? l10n.onboardingGenericFailure
                      : null,
                  onChanged: cubit.codeChanged,
                  onCompleted: cubit.verifyCode,
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  l10n.onboardingNewAccount,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
