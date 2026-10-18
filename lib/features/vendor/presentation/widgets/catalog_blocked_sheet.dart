import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/core/widgets/app_primary_button.dart';
import 'package:gcc_app/core/widgets/app_secondary_button.dart';
import 'package:gcc_app/features/vendor/domain/vendor_booking_hold.dart';
import 'package:gcc_app/features/vendor/presentation/widgets/catalog_block_choice.dart';

class CatalogBlockedSheet extends StatefulWidget {
  const CatalogBlockedSheet({required this.hold, super.key});

  final VendorBookingHold hold;

  @override
  State<CatalogBlockedSheet> createState() => _CatalogBlockedSheetState();
}

class _CatalogBlockedSheetState extends State<CatalogBlockedSheet> {
  CatalogBlockChoice _choice = CatalogBlockChoice.afterReturn;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    final hold = widget.hold;
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        0,
        AppSpacing.md,
        AppSpacing.md,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: colors.warningContainer,
              borderRadius: BorderRadius.circular(AppRadii.card),
              border: Border.all(
                color: colors.heldFunds.withValues(alpha: 0.3),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.sm),
              child: Row(
                children: [
                  Icon(
                    Icons.warning_amber_outlined,
                    color: colors.heldFunds,
                    size: AppDimensions.iconMd,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Expanded(
                    child: Text(
                      l10n.catalogBlockedAffected(1),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: colors.heldFunds,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          DecoratedBox(
            decoration: BoxDecoration(
              color: scheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(AppRadii.card),
              border: Border.all(color: colors.border),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${hold.reference} · ${hold.lessee}',
                          style: AppTextStyles.mono(
                            Theme.of(context).textTheme.bodyMedium!,
                          ),
                        ),
                      ),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: colors.infoContainer,
                          borderRadius: BorderRadius.circular(AppRadii.input),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.xxs,
                            vertical: AppSpacing.xxs,
                          ),
                          child: Text(
                            l10n.catalogBlockedActive,
                            style: AppTextStyles.mono(
                              Theme.of(context).textTheme.labelSmall!.copyWith(
                                color: colors.info,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    l10n.catalogReturns(hold.returnsAt),
                    style: AppTextStyles.mono(
                      Theme.of(context).textTheme.bodySmall!
                          .copyWith(color: scheme.onSurfaceVariant),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          _option(
            context,
            choice: CatalogBlockChoice.afterReturn,
            title: l10n.catalogSetAfterReturn,
            detail: l10n.catalogSetAfterReturnDetail(hold.changesAt),
            recommended: l10n.catalogRecommended,
          ),
          const SizedBox(height: AppSpacing.xs),
          _option(
            context,
            choice: CatalogBlockChoice.now,
            title: l10n.catalogSetNow,
            detail: l10n.catalogSetNowDetail(hold.bookableUntil),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            l10n.catalogBuyersNotTold,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall
                ?.copyWith(color: scheme.onSurfaceVariant),
          ),
          const SizedBox(height: AppSpacing.md),
          DecoratedBox(
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: colors.border)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: AppSpacing.md),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: AppSecondaryButton(
                      label: l10n.catalogCancel,
                      expand: false,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    flex: 3,
                    child: AppPrimaryButton(
                      label: _choice == CatalogBlockChoice.afterReturn
                          ? l10n.catalogSetAfterReturn
                          : l10n.catalogSetNow,
                      expand: false,
                      onPressed: () => Navigator.of(context).pop(_choice),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _option(
    BuildContext context, {
    required CatalogBlockChoice choice,
    required String title,
    required String detail,
    String? recommended,
  }) {
    final scheme = Theme.of(context).colorScheme;
    final selected = _choice == choice;
    final badge = recommended;
    return Material(
      color: selected ? scheme.secondaryContainer : scheme.surface,
      borderRadius: BorderRadius.circular(AppRadii.card),
      child: InkWell(
        onTap: () => setState(() => _choice = choice),
        borderRadius: BorderRadius.circular(AppRadii.card),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadii.card),
            border: Border.all(
              color: selected ? scheme.primary : context.semanticColors.border,
              width: selected
                  ? AppDimensions.borderWidth * 2
                  : AppDimensions.borderWidth,
            ),
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: AppDimensions.minTouchTarget,
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.sm),
              child: Row(
                children: [
                  Icon(
                    selected
                        ? Icons.radio_button_checked
                        : Icons.radio_button_unchecked,
                    color: selected ? scheme.primary : scheme.outline,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: AppSpacing.xs,
                          children: [
                            Text(
                              title,
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                            if (badge != null)
                              DecoratedBox(
                                decoration: BoxDecoration(
                                  color: scheme.primary,
                                  borderRadius: BorderRadius.circular(
                                    AppRadii.input,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: AppSpacing.xs,
                                    vertical: AppSpacing.xxs,
                                  ),
                                  child: Text(
                                    badge,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        ?.copyWith(
                                          color: scheme.onPrimary,
                                          fontWeight: FontWeight.w700,
                                        ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        Text(
                          detail,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: selected
                                    ? scheme.onSecondaryContainer
                                    : scheme.onSurfaceVariant,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
