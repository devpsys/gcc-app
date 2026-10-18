import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_colors.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/features/vendor/domain/vendor_asset.dart';
import 'package:gcc_app/features/vendor/domain/vendor_asset_status.dart';
import 'package:gcc_app/features/vendor/presentation/widgets/catalog_deposit_line.dart';
import 'package:gcc_app/features/vendor/presentation/widgets/catalog_status_control.dart';

class CatalogAssetCard extends StatelessWidget {
  const CatalogAssetCard({
    required this.asset,
    required this.perDay,
    required this.depositCaption,
    required this.readyLabel,
    required this.rentedLabel,
    required this.maintenanceLabel,
    required this.pendingNote,
    required this.onStatus,
    this.undoLabel,
    this.undoHint,
    this.onUndo,
    super.key,
  });

  final VendorAsset asset;
  final String perDay;
  final String depositCaption;
  final String readyLabel;
  final String rentedLabel;
  final String maintenanceLabel;
  final String pendingNote;
  final ValueChanged<VendorAssetStatus> onStatus;
  final String? undoLabel;
  final String? undoHint;
  final VoidCallback? onUndo;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    final deposit = asset.deposit;
    final line = asset.statusLine;
    final note = asset.scheduledNote;
    final pending = asset.status == VendorAssetStatus.pending;
    final undo = onUndo;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(AppRadii.card),
        border: Border.all(color: colors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _thumb(context, asset.mark),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              asset.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          Flexible(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: AlignmentDirectional.topEnd,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    asset.ratePerDay,
                                    style: AppTextStyles.tabular(
                                      Theme.of(context).textTheme.bodyMedium!
                                          .copyWith(
                                            fontWeight: FontWeight.w700,
                                          ),
                                    ),
                                  ),
                                  Text(
                                    perDay,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        ?.copyWith(
                                          color: scheme.onSurfaceVariant,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '${asset.reference} · ${asset.place}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.mono(
                          Theme.of(context).textTheme.bodySmall!
                              .copyWith(color: scheme.onSurfaceVariant),
                        ),
                      ),
                      Text(
                        asset.specification,
                        style: Theme.of(context).textTheme.bodySmall
                            ?.copyWith(color: scheme.onSurfaceVariant),
                      ),
                      if (deposit != null) ...[
                        const SizedBox(height: AppSpacing.xxs),
                        CatalogDepositLine(
                          amount: deposit,
                          caption: depositCaption,
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            if (line != null) ...[
              const SizedBox(height: AppSpacing.xs),
              Text(line, style: Theme.of(context).textTheme.bodySmall),
            ],
            if (asset.bookingActive && asset.hold != null) ...[
              const SizedBox(height: AppSpacing.xxs),
              Text(
                context.l10n.catalogLocked(asset.hold!.reference),
                style: Theme.of(context).textTheme.bodySmall
                    ?.copyWith(color: colors.heldFunds),
              ),
            ],
            if (note != null) ...[
              const SizedBox(height: AppSpacing.xs),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: colors.successContainer,
                  borderRadius: BorderRadius.circular(AppRadii.input),
                  border: Border.all(
                    color: colors.success.withValues(alpha: 0.3),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xs,
                    vertical: AppSpacing.xxs,
                  ),
                  child: Text(
                    context.l10n.catalogScheduled(note),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: colors.success,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
            if (pending) ...[
              const SizedBox(height: AppSpacing.xs),
              Text(
                context.l10n.catalogPendingReview,
                style: Theme.of(context).textTheme.bodySmall
                    ?.copyWith(color: scheme.onSurfaceVariant),
              ),
            ],
            const SizedBox(height: AppSpacing.xs),
            CatalogStatusControl(
              status: asset.status,
              readyLabel: readyLabel,
              rentedLabel: rentedLabel,
              maintenanceLabel: maintenanceLabel,
              enabled: !pending,
              onSelected: pending ? null : onStatus,
            ),
            if (pending) ...[
              const SizedBox(height: AppSpacing.xs),
              Text(
                pendingNote,
                style: Theme.of(context).textTheme.bodySmall
                    ?.copyWith(color: scheme.onSurfaceVariant),
              ),
            ],
            if (undo != null && undoLabel != null && undoHint != null) ...[
              const SizedBox(height: AppSpacing.xs),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      undoHint!,
                      style: Theme.of(context).textTheme.labelSmall
                          ?.copyWith(color: scheme.onSurfaceVariant),
                    ),
                  ),
                  TextButton(onPressed: undo, child: Text(undoLabel!)),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _thumb(BuildContext context, String? mark) {
    return DecoratedBox(
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
                child: ColoredBox(
                  color: AppColors.ink950.withValues(alpha: 0.9),
                  child: SizedBox(
                    width: AppDimensions.skeletonThumb,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.xxs,
                      ),
                      child: Text(
                        mark,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.mono(
                          Theme.of(context).textTheme.labelSmall!.copyWith(
                            color: context.semanticColors.heldFunds,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
