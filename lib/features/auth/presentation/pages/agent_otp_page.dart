import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/router/route_paths.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/app_primary_button.dart';
import 'package:gcc_app/features/auth/presentation/bloc/agent_auth_cubit.dart';
import 'package:gcc_app/features/auth/presentation/bloc/agent_auth_state.dart';
import 'package:gcc_app/features/auth/presentation/widgets/auth_screen_scaffold.dart';
import 'package:gcc_app/features/auth/presentation/widgets/auth_session_footer.dart';
import 'package:gcc_app/features/auth/presentation/widgets/masked_phone_line.dart';
import 'package:gcc_app/features/auth/presentation/widgets/otp_code_field.dart';
import 'package:gcc_app/features/auth/presentation/widgets/security_note.dart';
import 'package:go_router/go_router.dart';

class AgentOtpPage extends StatelessWidget {
  const AgentOtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocListener<AgentAuthCubit, AgentAuthState>(
      listenWhen: (previous, current) =>
          current is AgentAuthVerified && previous is! AgentAuthVerified,
      listener: (context, state) {
        GoRouter.maybeOf(context)?.go(RoutePaths.agentToday);
      },
      child: BlocBuilder<AgentAuthCubit, AgentAuthState>(
        builder: (context, state) {
          final cubit = context.read<AgentAuthCubit>();
          final busy =
              state is AgentAuthVerifying || state is AgentAuthValidating;
          final incorrect =
              state is AgentAuthFailed &&
              state.kind == AgentAuthFailureKind.verification;
          final complete = state.code.length == OtpCodeField.length;
          final scheme = Theme.of(context).colorScheme;
          return AuthScreenScaffold(
            title: l10n.authEnterCodeTitle,
            subtitle: MaskedPhoneLine(
              message: l10n.authCodeSentTo(state.maskedPhone),
              phone: state.maskedPhone,
            ),
            onBack: busy
                ? null
                : () {
                    cubit.editIdentifier();
                    final router = GoRouter.maybeOf(context);
                    if (router != null && router.canPop()) {
                      context.pop();
                    }
                  },
            backLabel: l10n.authBack,
            belowCard: DecoratedBox(
              decoration: BoxDecoration(
                color: scheme.surface,
                borderRadius: BorderRadius.circular(AppRadii.dialog),
                border: Border.all(color: context.semanticColors.border),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: AppDimensions.minTouchTarget,
                    child: Center(
                      child: TextButton(
                        onPressed: busy ? null : cubit.resendCode,
                        child: Text(
                          '${l10n.authDidntGetCode} · ${l10n.authResendCode}',
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    height: AppDimensions.borderWidth,
                    thickness: AppDimensions.borderWidth,
                    color: scheme.surfaceContainerHighest,
                  ),
                  SizedBox(
                    height: AppDimensions.minTouchTarget,
                    child: Center(
                      child: TextButton(
                        onPressed: busy
                            ? null
                            : () {
                                cubit.editIdentifier();
                                final router = GoRouter.maybeOf(context);
                                if (router != null && router.canPop()) {
                                  context.pop();
                                }
                              },
                        child: Text(
                          l10n.authUseDifferentNumber,
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: scheme.primary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            footer: const AuthSessionFooter(),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SecurityNote(message: l10n.authSecurityNote),
                const SizedBox(height: AppSpacing.md),
                OtpCodeField(
                  label: l10n.authOtpFieldLabel,
                  autofocus: true,
                  enabled: !busy,
                  errorText: incorrect ? l10n.authOtpIncorrect : null,
                  onChanged: cubit.codeChanged,
                  onCompleted: (_) => cubit.verify(),
                ),
                const SizedBox(height: AppSpacing.md),
                AppPrimaryButton(
                  label: l10n.authVerify,
                  busy: busy,
                  onPressed: complete && !busy ? cubit.verify : null,
                  disabledReason: l10n.authOtpIncompleteReason,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
