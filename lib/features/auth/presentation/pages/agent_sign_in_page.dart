import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/network/online_status_cubit.dart';
import 'package:gcc_app/core/network/online_status_state.dart';
import 'package:gcc_app/core/router/route_paths.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/core/widgets/app_primary_button.dart';
import 'package:gcc_app/core/widgets/language_catalog.dart';
import 'package:gcc_app/core/widgets/language_picker_sheet.dart';
import 'package:gcc_app/features/auth/domain/auth_role.dart';
import 'package:gcc_app/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:gcc_app/features/auth/presentation/bloc/auth_identifier_validator.dart';
import 'package:gcc_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:gcc_app/features/auth/presentation/widgets/auth_floating_id_field.dart';
import 'package:gcc_app/features/auth/presentation/widgets/auth_gcc_mark.dart';
import 'package:gcc_app/features/auth/presentation/widgets/auth_offline_banner.dart';
import 'package:gcc_app/features/auth/presentation/widgets/auth_offline_session_link.dart';
import 'package:gcc_app/features/auth/presentation/widgets/auth_role_switcher.dart';
import 'package:gcc_app/features/auth/presentation/widgets/auth_scan_qr_button.dart';
import 'package:gcc_app/features/auth/presentation/widgets/auth_suite_wordmark.dart';
import 'package:gcc_app/features/auth/presentation/widgets/auth_unknown_id_recovery.dart';
import 'package:gcc_app/features/auth/presentation/widgets/auth_utility_row.dart';
import 'package:gcc_app/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class AgentSignInPage extends StatelessWidget {
  const AgentSignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          current is AuthCodeRequested &&
          previous is! AuthCodeRequested &&
          ModalRoute.of(context)?.isCurrent != false,
      listener: (context, state) {
        if (ModalRoute.of(context)?.isCurrent ?? true) {
          context.push(RoutePaths.authVerify);
        }
      },
      child: BlocBuilder<OnlineStatusCubit, OnlineStatusState>(
        builder: (context, online) {
          return BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              final cubit = context.read<AuthCubit>();
              final valid = AuthIdentifierValidator.isValidForRole(
                state.identifier,
                state.entryRole,
              );
              final busy = state is AuthValidating;
              final unknown =
                  state is AuthFailed &&
                  state.kind == AuthFailureKind.unknownIdentifier;
              final language = gccLanguageOptions(l10n)
                  .where((option) => option.id == state.languageId)
                  .firstOrNull;
              final scheme = Theme.of(context).colorScheme;
              final fieldInvalid = _fieldInvalid(state);

              return Scaffold(
                backgroundColor: scheme.surface,
                body: SafeArea(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 480),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return SingleChildScrollView(
                            padding: const EdgeInsets.fromLTRB(
                              AppSpacing.md,
                              AppSpacing.sm,
                              AppSpacing.md,
                              AppSpacing.md,
                            ),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                minHeight:
                                    constraints.maxHeight - AppSpacing.md,
                              ),
                              child: IntrinsicHeight(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    if (online.isOffline) ...[
                                      AuthOfflineBanner(
                                        onRetry: () => context
                                            .read<OnlineStatusCubit>()
                                            .refresh(),
                                      ),
                                      const SizedBox(height: AppSpacing.md),
                                    ],
                                    if (unknown) ...[
                                      Row(
                                        children: [
                                          const AuthGccMark(),
                                          const Spacer(),
                                          DecoratedBox(
                                            decoration: BoxDecoration(
                                              color: scheme.errorContainer,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                    AppDimensions.iconSm / 2,
                                                  ),
                                              border: Border.all(
                                                color: scheme.error.withValues(
                                                  alpha: 0.35,
                                                ),
                                              ),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: AppSpacing.xs,
                                                    vertical: AppSpacing.xxs,
                                                  ),
                                              child: Text(
                                                l10n.authSessionRetry,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelSmall
                                                    ?.copyWith(
                                                      color: scheme.error,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: AppSpacing.sm),
                                    ] else
                                      const AuthSuiteWordmark(),
                                    const SizedBox(height: AppSpacing.md),
                                    Text(
                                      _title(l10n, state.entryRole),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall
                                          ?.copyWith(
                                            fontWeight: FontWeight.w900,
                                            letterSpacing: -0.3,
                                          ),
                                    ),
                                    if (!unknown) ...[
                                      const SizedBox(height: AppSpacing.xxs),
                                      Text(
                                        _subtitle(l10n, state.entryRole),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                              color: scheme.onSurfaceVariant,
                                            ),
                                      ),
                                      const SizedBox(height: AppSpacing.md),
                                      AuthRoleSwitcher(
                                        selected: state.entryRole,
                                        onSelected: cubit.selectEntryRole,
                                      ),
                                      const SizedBox(height: AppSpacing.md),
                                    ] else
                                      const SizedBox(height: AppSpacing.md),
                                    AuthFloatingIdField(
                                      key: ValueKey(state.entryRole),
                                      label: _idLabel(l10n, state.entryRole),
                                      hint: AuthIdentifierValidator.hintForRole(
                                        state.entryRole,
                                      ),
                                      enabled: !busy,
                                      hasError: unknown || fieldInvalid,
                                      errorText: unknown
                                          ? null
                                          : _identifierError(context, state),
                                      onChanged: cubit.identifierChanged,
                                      onUnfocused: cubit.identifierBlurred,
                                      onClear: cubit.clearIdentifier,
                                      onSubmitted: (_) =>
                                          cubit.submitIdentifier(),
                                    ),
                                    const SizedBox(height: AppSpacing.sm),
                                    if (unknown)
                                      AuthUnknownIdRecovery(
                                        identifier: state.identifier,
                                        onTryAgain: cubit.submitIdentifier,
                                        onDifferentId: cubit.clearIdentifier,
                                        onScanQr: () => _unavailable(context),
                                        scanDisabledReason:
                                            l10n.dashboardActionUnavailable,
                                        onCallCoordinator: () =>
                                            _unavailable(context),
                                        onWhatsApp: () => _unavailable(context),
                                      )
                                    else ...[
                                      AuthScanQrButton(
                                        label: l10n.authScanQr,
                                        onPressed: () => _unavailable(context),
                                      ),
                                      const SizedBox(height: AppSpacing.md),
                                      AppPrimaryButton(
                                        label: l10n.authContinue,
                                        icon: Icons.arrow_forward,
                                        busy: busy,
                                        onPressed: valid && !busy
                                            ? cubit.submitIdentifier
                                            : null,
                                        disabledReason: _continueDisabledReason(
                                          l10n,
                                          identifier: state.identifier,
                                          valid: valid,
                                          fieldInvalid: fieldInvalid,
                                          busy: busy,
                                        ),
                                      ),
                                      const SizedBox(height: AppSpacing.sm),
                                      AuthOfflineSessionLink(
                                        onTap: () => _unavailable(context),
                                      ),
                                    ],
                                    const Spacer(),
                                    const SizedBox(height: AppSpacing.lg),
                                    if (!unknown) ...[
                                      const Divider(height: 1),
                                      const SizedBox(height: AppSpacing.sm),
                                      AuthUtilityRow(
                                        languageName:
                                            language?.englishName ??
                                            l10n.languageEnglishName,
                                        onLanguage: () async {
                                          final selected =
                                              await showAppLanguagePicker(
                                                context: context,
                                                selectedId: state.languageId,
                                              );
                                          if (selected != null &&
                                              context.mounted) {
                                            cubit.selectLanguage(selected);
                                          }
                                        },
                                        onHelp: () => _unavailable(context),
                                      ),
                                      const SizedBox(height: AppSpacing.sm),
                                    ],
                                    Text(
                                      unknown
                                          ? l10n.authEscalationHelpline(
                                              l10n.authSupportPhone,
                                            )
                                          : l10n.authSupportLine(
                                              l10n.authSupportPhone,
                                            ),
                                      textAlign: TextAlign.center,
                                      style: AppTextStyles.mono(
                                        Theme.of(context).textTheme.labelSmall!
                                            .copyWith(
                                              color: scheme.onSurfaceVariant,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _unavailable(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(context.l10n.dashboardActionUnavailable)),
    );
  }

  String? _continueDisabledReason(
    AppLocalizations l10n, {
    required String identifier,
    required bool valid,
    required bool fieldInvalid,
    required bool busy,
  }) {
    if (valid || busy) {
      return null;
    }
    if (AuthIdentifierValidator.isEmpty(identifier)) {
      return l10n.authContinueNeedsIdentifier;
    }
    if (fieldInvalid) {
      return l10n.authContinueNeedsValidIdentifier;
    }
    return null;
  }

  bool _fieldInvalid(AuthState state) {
    if (state is AuthIdle) {
      return state.identifierInvalid;
    }
    if (state is AuthFailed) {
      return state.identifierInvalid;
    }
    return false;
  }

  String? _identifierError(BuildContext context, AuthState state) {
    final l10n = context.l10n;
    if (state is AuthIdle && state.identifierInvalid) {
      return l10n.authIdentifierInvalid;
    }
    if (state is AuthFailed && state.identifierInvalid) {
      return l10n.authIdentifierInvalid;
    }
    if (state is AuthFailed && state.kind == AuthFailureKind.generic) {
      return l10n.authGenericFailure;
    }
    if (state is AuthFailed && state.kind == AuthFailureKind.unassigned) {
      return l10n.authUnassignedMessage;
    }
    return null;
  }

  String _title(AppLocalizations l10n, AuthRole role) {
    return switch (role) {
      AuthRole.agent => l10n.authAgentSignInTitle,
      AuthRole.vendor => l10n.authVendorSignInTitle,
      AuthRole.lessee => l10n.authLesseeSignInTitle,
    };
  }

  String _subtitle(AppLocalizations l10n, AuthRole role) {
    return switch (role) {
      AuthRole.agent => l10n.authAgentSignInSubtitle,
      AuthRole.vendor => l10n.authVendorSignInSubtitle,
      AuthRole.lessee => l10n.authLesseeSignInSubtitle,
    };
  }

  String _idLabel(AppLocalizations l10n, AuthRole role) {
    return switch (role) {
      AuthRole.agent => l10n.authAgentIdLabel,
      AuthRole.vendor => l10n.authVendorIdLabel,
      AuthRole.lessee => l10n.authLesseeIdLabel,
    };
  }
}
