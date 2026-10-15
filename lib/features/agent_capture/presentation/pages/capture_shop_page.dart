import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/router/route_paths.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/features/agent_capture/presentation/bloc/capture_cubit.dart';
import 'package:gcc_app/features/agent_capture/presentation/bloc/capture_draft.dart';
import 'package:gcc_app/features/agent_capture/presentation/bloc/capture_state.dart';
import 'package:gcc_app/core/widgets/wizard_step_badge.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/capture_wizard_scaffold.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/shop_category_chips.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/shop_identity_fields.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/shop_type_field.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/whatsapp_optional_field.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/wizard_action_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class CaptureShopPage extends StatelessWidget {
  const CaptureShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CaptureCubit, CaptureState>(
      builder: (context, state) {
        final draft = state.draft;
        final l10n = context.l10n;
        final cubit = context.read<CaptureCubit>();
        final showErrors = draft.shopAttempted && !draft.shopIsValid;
        final identityAlert =
            showErrors &&
            (draft.shopName.trim().isEmpty ||
                draft.ownerName.trim().isEmpty ||
                draft.shopType == null);
        final contactAlert =
            showErrors && draft.phone.length != CaptureDraft.phoneLength;
        final categoryAlert = showErrors && draft.categories.isEmpty;
        final pristine = _blocksContinue(draft);
        final savedAt = draft.savedAt;
        final savedClock = savedAt == null
            ? null
            : DateFormat.jm(Localizations.localeOf(context).toString())
                  .format(savedAt);
        final badgeStyle = showErrors
            ? WizardStepBadge.attention
            : pristine
            ? WizardStepBadge.start
            : WizardStepBadge.active;
        return CaptureWizardScaffold(
          title: l10n.captureShopTitle,
          stepLabels: [
            l10n.captureStepShop,
            l10n.captureStepLocation,
            l10n.captureStepAssets,
            l10n.captureStepMedia,
          ],
          currentIndex: 0,
          stepEyebrow: l10n.captureStepEyebrow(1, 4, l10n.captureShopDetails),
          stepBadge: switch (badgeStyle) {
            WizardStepBadge.start => l10n.captureStepStart,
            WizardStepBadge.attention => l10n.captureStepAttention,
            WizardStepBadge.active => l10n.captureStepActive(1, 4),
          },
          stepBadgeStyle: badgeStyle,
          autosaveLabel: savedClock == null
              ? null
              : showErrors
              ? l10n.captureAutosavedIncomplete(
                  savedClock,
                  draft.shopIssueCount,
                )
              : l10n.captureAutosaved(savedClock),
          statusLabel: showErrors ? l10n.captureActionNeeded : null,
          statusAlert: showErrors,
          actionBar: WizardActionBar(
            secondaryLabel: l10n.captureSaveDraft,
            primaryLabel: l10n.captureContinue,
            onSecondary: cubit.rememberDraft,
            onPrimary: _blocksContinue(draft)
                ? null
                : () {
                    if (cubit.attemptShopContinue()) {
                      GoRouter.maybeOf(context)
                          ?.push(RoutePaths.captureLocation);
                    }
                  },
            primaryDisabledReason: _blocksContinue(draft)
                ? l10n.captureContinueNeedsIdentity
                : null,
          ),
          children: [
            if (showErrors) ...[
              _banner(
                context,
                l10n.captureValidationBanner(draft.shopIssueCount),
              ),
              const SizedBox(height: AppSpacing.md),
            ],
            _panel(
              context,
              title: l10n.captureShopDetails,
              alert: identityAlert,
              trailing: Text(
                showErrors ? l10n.captureIncomplete : l10n.captureRequiredMark,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: showErrors
                      ? context.semanticColors.danger
                      : Theme.of(context).colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
              ),
              child: ShopIdentityFields(
                shopName: draft.shopName,
                ownerName: draft.ownerName,
                onShopNameChanged: cubit.editShopName,
                onOwnerNameChanged: cubit.editOwnerName,
                shopNameError: showErrors && draft.shopName.trim().isEmpty
                    ? l10n.captureShopNameRequired
                    : null,
                ownerNameError: showErrors && draft.ownerName.trim().isEmpty
                    ? l10n.captureOwnerNameRequired
                    : null,
                middle: ShopTypeField(
                  selected: draft.shopType,
                  onChanged: cubit.selectShopType,
                  errorText: showErrors && draft.shopType == null
                      ? l10n.captureShopTypeRequired
                      : null,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            _panel(
              context,
              title: l10n.captureContactHeading,
              compactTitle: true,
              alert: contactAlert,
              trailing: Text(
                l10n.captureNigeriaPrefix,
                style: AppTextStyles.mono(
                  Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              child: WhatsAppOptionalField(
                phone: draft.phone,
                sameAsPhone: draft.whatsAppSameAsPhone,
                whatsApp: draft.whatsApp,
                onPhoneChanged: cubit.editPhone,
                onSameChanged: (same) =>
                    cubit.setWhatsAppSameAsPhone(same: same),
                onWhatsAppChanged: cubit.editWhatsApp,
                phoneError:
                    showErrors && draft.phone.length != CaptureDraft.phoneLength
                    ? l10n.capturePhoneRequired
                    : null,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            _panel(
              context,
              title: l10n.captureWhatTheySell,
              alert: categoryAlert,
              trailing: draft.categories.isEmpty
                  ? null
                  : _countChip(
                      context,
                      l10n.captureCategoriesSelected(draft.categories.length),
                    ),
              child: ShopCategoryChips(
                selected: draft.categories,
                onToggled: cubit.toggleCategory,
                errorText: showErrors && draft.categories.isEmpty
                    ? l10n.captureCategoryRequired
                    : null,
              ),
            ),
          ],
        );
      },
    );
  }

  bool _blocksContinue(CaptureDraft draft) {
    return !draft.shopAttempted &&
        draft.shopName.trim().isEmpty &&
        draft.ownerName.trim().isEmpty &&
        draft.phone.isEmpty &&
        draft.shopType == null &&
        draft.categories.isEmpty;
  }

  Widget _banner(BuildContext context, String message) {
    final colors = context.semanticColors;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.dangerContainer,
        borderRadius: BorderRadius.circular(AppRadii.input),
        border: Border.all(color: colors.dangerBorder),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        child: Row(
          children: [
            Icon(Icons.error_outline, color: colors.danger),
            const SizedBox(width: AppSpacing.xs),
            Expanded(
              child: Text(
                message,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: colors.danger,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _countChip(BuildContext context, String label) {
    final scheme = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.secondaryContainer,
        borderRadius: BorderRadius.circular(AppRadii.input),
        border: Border.all(color: scheme.primaryContainer),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xs,
          vertical: AppSpacing.xxs / 2,
        ),
        child: Text(
          label,
          style: AppTextStyles.mono(
            Theme.of(context).textTheme.labelSmall!
                .copyWith(color: scheme.secondary, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  Widget _panel(
    BuildContext context, {
    required String title,
    required Widget child,
    Widget? trailing,
    bool compactTitle = false,
    bool alert = false,
  }) {
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    final titleStyle = compactTitle
        ? Theme.of(context).textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.w700,
            letterSpacing: AppTextStyles.eyebrowLetterSpacing,
            color: scheme.onSurface,
          )
        : Theme.of(context).textTheme.titleLarge
              ?.copyWith(fontWeight: FontWeight.w600);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(AppRadii.dialog),
        border: Border.all(color: alert ? colors.dangerBorder : colors.border),
        boxShadow: alert
            ? [
                BoxShadow(
                  color: colors.danger.withValues(alpha: 0.2),
                  spreadRadius: AppDimensions.borderWidth,
                ),
              ]
            : null,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: context.semanticColors.border),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        compactTitle ? title.toUpperCase() : title,
                        style: titleStyle,
                      ),
                    ),
                    ?trailing,
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            child,
          ],
        ),
      ),
    );
  }
}
