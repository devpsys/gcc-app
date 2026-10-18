import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_colors.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/core/widgets/app_primary_button.dart';
import 'package:gcc_app/core/widgets/app_secondary_button.dart';
import 'package:gcc_app/core/widgets/app_toggle_switch.dart';
import 'package:gcc_app/features/vendor/domain/naira_amount.dart';
import 'package:gcc_app/features/vendor/domain/vendor_asset_status.dart';
import 'package:gcc_app/features/vendor/domain/vendor_charge_basis.dart';
import 'package:gcc_app/features/vendor/presentation/bloc/vendor_asset_edit_cubit.dart';
import 'package:gcc_app/features/vendor/presentation/bloc/vendor_asset_edit_state.dart';
import 'package:gcc_app/features/vendor/presentation/widgets/edit_money_field.dart';
import 'package:gcc_app/features/vendor/presentation/widgets/edit_quote_card.dart';

class VendorAssetEditPage extends StatelessWidget {
  const VendorAssetEditPage({required this.state, super.key});

  final VendorAssetEditReady state;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<VendorAssetEditCubit>();
    final l10n = context.l10n;
    final quote = state.quote;
    final gaps = state.gaps;
    final savedAt = state.original.savedAt;
    final project = state.basis == VendorChargeBasis.project;
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.md),
            children: [
              if (savedAt != null)
                Text(
                  gaps.clear
                      ? l10n.editAutosaved(savedAt)
                      : gaps.count == 1
                      ? l10n.editAutosavedOneIncomplete(savedAt)
                      : l10n.editAutosavedIncomplete(savedAt, gaps.count),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: gaps.clear
                        ? Theme.of(context).colorScheme.onSurfaceVariant
                        : Theme.of(context).colorScheme.error,
                  ),
                ),
              if (!gaps.clear) ...[
                const SizedBox(height: AppSpacing.xs),
                Text(
                  gaps.count == 1
                      ? l10n.editOneFieldNeedsAttention
                      : l10n.editFieldsNeedAttention(gaps.count),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.error,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
              const SizedBox(height: AppSpacing.sm),
              _identity(context),
              const SizedBox(height: AppSpacing.md),
              Text(
                l10n.editHowYouCharge,
                style: Theme.of(context).textTheme.labelLarge
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: AppSpacing.xs),
              _basis(context, cubit),
              const SizedBox(height: AppSpacing.md),
              if (project)
                EditMoneyField(
                  label: l10n.editProjectRate,
                  value: state.projectText,
                  generation: state.revision,
                  suffix: l10n.editProject,
                  errorText: gaps.rate ? l10n.editProjectError : null,
                  onChanged: cubit.projectChanged,
                )
              else
                EditMoneyField(
                  label: l10n.editRatePerDay,
                  value: state.dailyText,
                  generation: state.revision,
                  suffix: l10n.editPerDay,
                  errorText: gaps.rate ? l10n.editRateError : null,
                  onChanged: cubit.dailyChanged,
                ),
              if (quote != null && !project) ...[
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  l10n.editCommission,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  state.basis == VendorChargeBasis.hourly
                      ? l10n.editHourlySet(fullNaira(quote.hourly))
                      : l10n.editWeeklySet(fullNaira(quote.weekly)),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
              if (project) ...[
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  l10n.editProjectHelper,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
              const SizedBox(height: AppSpacing.md),
              EditMoneyField(
                label: l10n.editDeposit,
                value: state.depositText,
                generation: state.revision,
                suffix: l10n.editDepositSuffix,
                held: !gaps.deposit,
                errorText: gaps.deposit ? l10n.editDepositError : null,
                onChanged: cubit.depositChanged,
              ),
              if (!gaps.deposit) ...[
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  l10n.editDepositHeld,
                  style: Theme.of(context).textTheme.bodySmall
                      ?.copyWith(color: context.semanticColors.heldFunds),
                ),
              ],
              const SizedBox(height: AppSpacing.sm),
              AppToggleSwitch(
                label: l10n.editAssignOperator,
                value: state.assignOperator,
                onChanged: cubit.operatorChanged,
              ),
              if (state.assignOperator) ...[
                const SizedBox(height: AppSpacing.xs),
                EditMoneyField(
                  label: l10n.editOperatorFee,
                  value: state.operatorText,
                  generation: state.revision,
                  suffix: l10n.editPerDay,
                  onChanged: cubit.operatorFeeChanged,
                ),
              ],
              const SizedBox(height: AppSpacing.md),
              if (quote != null)
                EditQuoteCard(quote: quote)
              else
                _paused(context),
              const SizedBox(height: AppSpacing.md),
              _media(context),
            ],
          ),
        ),
        Material(
          color: Theme.of(context).colorScheme.surface,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: AppSecondaryButton(
                        label: l10n.editDiscard,
                        expand: false,
                        onPressed: cubit.discard,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: AppPrimaryButton(
                        label: l10n.editSave,
                        expand: false,
                        onPressed: gaps.clear ? cubit.save : null,
                      ),
                    ),
                  ],
                ),
                if (!gaps.clear) ...[
                  const SizedBox(height: AppSpacing.xxs),
                  Text(
                    gaps.count == 1
                        ? l10n.editSaveBlockedOne
                        : l10n.editSaveBlocked(gaps.count),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelSmall
                        ?.copyWith(color: Theme.of(context).colorScheme.error),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _identity(BuildContext context) {
    final draft = state.original;
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    final mark = draft.mark;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.ink900,
            borderRadius: BorderRadius.circular(AppRadii.input),
          ),
          child: SizedBox.square(
            dimension: AppDimensions.skeletonThumb,
            child: mark == null
                ? null
                : Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      mark,
                      style: AppTextStyles.mono(
                        Theme.of(context).textTheme.labelSmall!.copyWith(
                          color: colors.heldFunds,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                draft.name,
                style: Theme.of(context).textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              Text(
                draft.place,
                style: Theme.of(context).textTheme.bodySmall
                    ?.copyWith(color: scheme.onSurfaceVariant),
              ),
              const SizedBox(height: AppSpacing.xxs),
              Text(
                _status(context, draft.status),
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: colors.success,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _basis(BuildContext context, VendorAssetEditCubit cubit) {
    final l10n = context.l10n;
    return Column(
      children: [
        Row(
          children: [
            _choice(context, cubit, VendorChargeBasis.hourly, l10n.editHourly),
            const SizedBox(width: AppSpacing.xs),
            _choice(context, cubit, VendorChargeBasis.daily, l10n.editDaily),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        Row(
          children: [
            _choice(context, cubit, VendorChargeBasis.weekly, l10n.editWeekly),
            const SizedBox(width: AppSpacing.xs),
            _choice(
              context,
              cubit,
              VendorChargeBasis.project,
              l10n.editProject,
            ),
          ],
        ),
      ],
    );
  }

  Widget _choice(
    BuildContext context,
    VendorAssetEditCubit cubit,
    VendorChargeBasis basis,
    String label,
  ) {
    final scheme = Theme.of(context).colorScheme;
    final selected = state.basis == basis;
    return Expanded(
      child: Material(
        color: selected ? scheme.primary : scheme.surface,
        borderRadius: BorderRadius.circular(AppRadii.button),
        child: InkWell(
          onTap: () => cubit.selectBasis(basis),
          borderRadius: BorderRadius.circular(AppRadii.button),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: AppDimensions.minTouchTarget,
            ),
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadii.button),
                border: selected ? null : Border.all(color: scheme.outline),
              ),
              child: Center(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: selected ? scheme.onPrimary : scheme.onSurface,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _paused(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppRadii.card),
        border: Border.all(color: context.semanticColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.editPausedTitle,
              style: Theme.of(context).textTheme.bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: AppSpacing.xxs),
            Text(
              l10n.editPausedBody,
              style: Theme.of(context).textTheme.bodySmall
                  ?.copyWith(color: scheme.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }

  Widget _media(BuildContext context) {
    final l10n = context.l10n;
    final draft = state.original;
    final scheme = Theme.of(context).colorScheme;
    final when = draft.videoWhen;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.editPhotos, style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: AppSpacing.xs),
        Wrap(
          spacing: AppSpacing.xs,
          runSpacing: AppSpacing.xs,
          children: [
            for (var index = 0; index < draft.photos.length; index++)
              _photo(context, draft.photos[index], '${index + 1}'),
          ],
        ),
        if (when != null) ...[
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l10n.editVideo(when)),
                    if (draft.videoDetail != null)
                      Text(
                        draft.videoDetail!,
                        style: AppTextStyles.mono(
                          Theme.of(context).textTheme.bodySmall!
                              .copyWith(color: scheme.onSurfaceVariant),
                        ),
                      ),
                  ],
                ),
              ),
              Tooltip(
                message: l10n.dashboardActionUnavailable,
                child: TextButton(
                  onPressed: null,
                  child: Text(l10n.editReplace),
                ),
              ),
            ],
          ),
          Text(
            l10n.editVideoNote,
            style: Theme.of(context).textTheme.bodySmall
                ?.copyWith(color: scheme.onSurfaceVariant),
          ),
        ],
      ],
    );
  }

  Widget _photo(BuildContext context, String label, String index) {
    final scheme = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.ink900,
        borderRadius: BorderRadius.circular(AppRadii.input),
      ),
      child: SizedBox(
        width: AppDimensions.previewThumb,
        height: AppDimensions.previewThumb,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              label,
              style: AppTextStyles.mono(
                Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: context.semanticColors.heldFunds,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Text(
              index,
              style: Theme.of(context).textTheme.labelSmall
                  ?.copyWith(color: scheme.surface),
            ),
          ],
        ),
      ),
    );
  }

  String _status(BuildContext context, VendorAssetStatus status) {
    final l10n = context.l10n;
    return switch (status) {
      VendorAssetStatus.ready => l10n.catalogStatusReady,
      VendorAssetStatus.rented => l10n.catalogStatusRented,
      VendorAssetStatus.maintenance => l10n.catalogStatusMaintenance,
      VendorAssetStatus.pending => l10n.catalogStatusPending,
    };
  }
}
