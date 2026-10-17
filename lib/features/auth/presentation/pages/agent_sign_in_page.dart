import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/router/route_paths.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/app_primary_button.dart';
import 'package:gcc_app/features/auth/presentation/bloc/agent_auth_cubit.dart';
import 'package:gcc_app/features/auth/presentation/bloc/agent_auth_state.dart';
import 'package:gcc_app/features/auth/presentation/bloc/agent_identifier_validator.dart';
import 'package:gcc_app/features/auth/presentation/widgets/agent_identifier_field.dart';
import 'package:gcc_app/features/auth/presentation/widgets/auth_danger_notice.dart';
import 'package:gcc_app/features/auth/presentation/widgets/auth_preference_bar.dart';
import 'package:gcc_app/features/auth/presentation/widgets/auth_screen_scaffold.dart';
import 'package:gcc_app/features/auth/presentation/widgets/auth_session_footer.dart';
import 'package:gcc_app/core/widgets/language_catalog.dart';
import 'package:gcc_app/core/widgets/language_picker_sheet.dart';
import 'package:gcc_app/features/auth/presentation/widgets/scanner_action_row.dart';
import 'package:go_router/go_router.dart';

class AgentSignInPage extends StatelessWidget {
  const AgentSignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocListener<AgentAuthCubit, AgentAuthState>(
      listenWhen: (previous, current) =>
          current is AgentAuthCodeRequested &&
          previous is! AgentAuthCodeRequested &&
          ModalRoute.of(context)?.isCurrent != false,
      listener: (context, state) {
        if (ModalRoute.of(context)?.isCurrent ?? true) {
          context.push(RoutePaths.agentVerify);
        }
      },
      child: BlocBuilder<AgentAuthCubit, AgentAuthState>(
        builder: (context, state) {
          final cubit = context.read<AgentAuthCubit>();
          final valid = AgentIdentifierValidator.isValid(state.identifier);
          final empty = AgentIdentifierValidator.isEmpty(state.identifier);
          final busy = state is AgentAuthValidating;
          final language = gccLanguageOptions(l10n)
              .where((option) => option.id == state.languageId)
              .firstOrNull;
          final canLeave = GoRouter.maybeOf(context)?.canPop() ?? false;
          final scheme = Theme.of(context).colorScheme;
          return AuthScreenScaffold(
            title: l10n.authAgentSignInTitle,
            subtitle: Text(
              l10n.authAgentSignInSubtitle,
              textAlign: TextAlign.center,
            ),
            onBack: canLeave ? () => context.pop() : null,
            backLabel: l10n.authBack,
            belowCard:
                state is AgentAuthFailed &&
                    state.kind == AgentAuthFailureKind.unassigned
                ? null
                : AuthPreferenceBar(
                    languageLabel: l10n.authLanguage,
                    languageValue:
                        language?.englishName ?? l10n.languageEnglishName,
                    onLanguage: () async {
                      final selected = await showAppLanguagePicker(
                        context: context,
                        selectedId: state.languageId,
                      );
                      if (selected != null && context.mounted) {
                        cubit.selectLanguage(selected);
                      }
                    },
                    notificationsLabel: l10n.authNotifications,
                    notificationsValue: l10n.authNotificationsValue,
                  ),
            footer: const AuthSessionFooter(),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: scheme.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(AppRadii.dialog),
                    border: Border.all(color: context.semanticColors.border),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppRadii.dialog),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ColoredBox(
                          color: scheme.surface,
                          child: Padding(
                            padding: const EdgeInsets.all(AppSpacing.sm),
                            child: AgentIdentifierField(
                              label: l10n.authAgentIdLabel,
                              hint: l10n.authAgentIdHint,
                              enabled: !busy,
                              errorText: _identifierError(context, state),
                              onChanged: cubit.identifierChanged,
                              onUnfocused: cubit.identifierBlurred,
                              onSubmitted: (_) => cubit.submitIdentifier(),
                            ),
                          ),
                        ),
                        ScannerActionRow(
                          dividerLabel: l10n.authScannerDivider,
                          actionLabel: l10n.authScanQr,
                          helpText: l10n.authScanQrHelp,
                          disabledReason: l10n.dashboardActionUnavailable,
                        ),
                      ],
                    ),
                  ),
                ),
                if (state is AgentAuthFailed &&
                    state.kind == AgentAuthFailureKind.unassigned) ...[
                  const SizedBox(height: AppSpacing.md),
                  AuthDangerNotice(message: l10n.authUnassignedMessage),
                ],
                const SizedBox(height: AppSpacing.md),
                AppPrimaryButton(
                  label: l10n.authContinue,
                  busy: busy,
                  onPressed: valid && !busy ? cubit.submitIdentifier : null,
                  disabledReason: empty
                      ? l10n.authContinueNeedsIdentifier
                      : l10n.authContinueNeedsValidIdentifier,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String? _identifierError(BuildContext context, AgentAuthState state) {
    final l10n = context.l10n;
    if (state is AgentAuthIdle && state.identifierInvalid) {
      return l10n.authIdentifierInvalid;
    }
    if (state is AgentAuthFailed &&
        state.kind == AgentAuthFailureKind.unknownIdentifier) {
      return l10n.authUnknownIdentifier(state.identifier);
    }
    if (state is AgentAuthFailed && state.identifierInvalid) {
      return l10n.authIdentifierInvalid;
    }
    if (state is AgentAuthFailed &&
        state.kind == AgentAuthFailureKind.generic) {
      return l10n.authGenericFailure;
    }
    return null;
  }
}
