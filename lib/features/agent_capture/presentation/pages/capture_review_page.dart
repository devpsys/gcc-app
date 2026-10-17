import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/router/route_paths.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/wizard_step_badge.dart';
import 'package:gcc_app/features/agent_capture/presentation/bloc/asset_category.dart';
import 'package:gcc_app/features/agent_capture/presentation/bloc/capture_draft.dart';
import 'package:gcc_app/features/agent_capture/presentation/bloc/shop_category.dart';
import 'package:gcc_app/features/agent_capture/presentation/bloc/capture_cubit.dart';
import 'package:gcc_app/features/agent_capture/presentation/bloc/capture_state.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/bounty_expectation_panel.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/capture_wizard_scaffold.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/offline_submit_banner.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/review_section.dart';
import 'package:gcc_app/l10n/app_localizations.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/wizard_action_bar.dart';

/// Terminal review screen of the capture wizard.
///
/// Everything the agent captured, one last look before it is submitted.
///
/// Submitting offline is a first-class path, not a degraded one: the design
/// keeps `Submit` enabled and explains that the capture queues. Only a missing
/// landmark blocks submission, because a shop without one cannot be verified —
/// which is also the one condition this wizard cannot resolve on its own.
class CaptureReviewPage extends StatelessWidget {
  const CaptureReviewPage({this.offline = false, super.key});

  /// Renders the design's offline frame.
  final bool offline;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final cubit = context.read<CaptureCubit>();

    return BlocBuilder<CaptureCubit, CaptureState>(
      builder: (context, state) {
        final draft = state.draft;
        final missingLandmark = draft.landmark.trim().isEmpty;
        final blocked = missingLandmark && draft.shopAttempted;

        return CaptureWizardScaffold(
          title: l10n.reviewTitle,
          stepLabels: [
            l10n.captureStepShop,
            l10n.captureStepLocation,
            l10n.captureStepAssets,
            l10n.captureStepMedia,
          ],
          currentIndex: 3,
          stepEyebrow: l10n.captureStepEyebrow(4, 4, l10n.reviewTitle),
          stepBadge: offline
              ? l10n.reviewOfflineBadge
              : blocked
              ? l10n.reviewNeedsAttention(1)
              : l10n.captureStepActive(4, 4),
          stepBadgeStyle: offline
              ? WizardStepBadge.start
              : blocked
              ? WizardStepBadge.attention
              : WizardStepBadge.active,
          statusLabel: offline ? l10n.reviewOfflineBadge : null,
          statusAlert: false,
          actionBar: WizardActionBar(
            secondaryLabel: l10n.reviewSaveDraft,
            primaryLabel: l10n.reviewSubmit,
            onSecondary: cubit.rememberDraft,
            onPrimary: missingLandmark ? null : () => _submit(context),
            primaryDisabledReason: missingLandmark
                ? l10n.reviewBlockedReason
                : null,
          ),
          children: [
            if (offline) ...[
              const OfflineSubmitBanner(),
              const SizedBox(height: AppSpacing.sm),
            ],
            _shop(context, draft),
            const SizedBox(height: AppSpacing.sm),
            _location(context, draft, blocked),
            const SizedBox(height: AppSpacing.sm),
            _assets(context, draft),
            const SizedBox(height: AppSpacing.sm),
            _media(context),
            const SizedBox(height: AppSpacing.sm),
            BountyExpectationPanel(
              amount: '₦5,000',
              note: l10n.reviewBountyNote(3, '₦15,000'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _submit(BuildContext context) async {
    final cubit = context.read<CaptureCubit>();
    await cubit.submit();
    if (!context.mounted) {
      return;
    }
    await GoRouter.maybeOf(context)?.push(RoutePaths.captureDone);
  }

  Widget _shop(BuildContext context, CaptureDraft draft) {
    final l10n = context.l10n;
    return ReviewSection(
      eyebrow: l10n.reviewSectionShop,
      children: [
        ReviewFieldRow(label: l10n.reviewLabelShopName, value: draft.shopName),
        ReviewFieldRow(label: l10n.reviewLabelOwner, value: draft.ownerName),
        ReviewFieldRow(
          label: l10n.reviewLabelPhone,
          value: '${l10n.capturePhonePrefix} ${draft.phone}',
          mono: true,
        ),
        ReviewFieldRow(
          label: l10n.reviewLabelSells,
          value: draft.categories.isEmpty
              ? l10n.captureNotSet
              : draft.categories.map((c) => _category(l10n, c)).join(' · '),
        ),
      ],
    );
  }

  Widget _location(BuildContext context, CaptureDraft draft, bool blocked) {
    final l10n = context.l10n;
    final missing = draft.landmark.trim().isEmpty;
    return ReviewSection(
      eyebrow: l10n.reviewSectionLocation,
      actionLabel: missing ? l10n.reviewFixNow : l10n.reviewEdit,
      alert: blocked && missing,
      onAction: () => GoRouter.maybeOf(context)?.go(RoutePaths.captureLocation),
      children: [
        if (draft.market.trim().isNotEmpty)
          ReviewFieldRow(label: l10n.reviewLabelMarket, value: draft.market),
        if (draft.zone.trim().isNotEmpty)
          ReviewFieldRow(label: l10n.reviewLabelZone, value: draft.zone),
        if (draft.line.trim().isNotEmpty)
          ReviewFieldRow(label: l10n.reviewLabelLine, value: draft.line),
        ReviewFieldRow(
          label: l10n.reviewLabelLandmark,
          value: missing ? l10n.reviewLandmarkMissing : draft.landmark,
          muted: missing,
        ),
        ReviewFieldRow(
          label: l10n.gpsSignalGood,
          value: l10n.reviewCoordinates('±12 m', '9.0580', '7.4100'),
          mono: true,
        ),
      ],
    );
  }

  Widget _assets(BuildContext context, CaptureDraft draft) {
    final l10n = context.l10n;
    if (draft.assets.isEmpty) {
      return ReviewSection(
        eyebrow: l10n.reviewSectionAssets,
        actionLabel: l10n.reviewEdit,
        onAction: () => GoRouter.maybeOf(context)?.go(RoutePaths.captureAssets),
        children: [
          ReviewFieldRow(
            label: l10n.reviewSectionAssets,
            value: l10n.reviewAssetsCaptured(0),
          ),
        ],
      );
    }
    return ReviewSection(
      eyebrow: l10n.reviewSectionAssets,
      actionLabel: l10n.reviewEdit,
      onAction: () => GoRouter.maybeOf(context)?.go(RoutePaths.captureAssets),
      children: [
        for (final asset in draft.assets)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.xs),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerLow,
                borderRadius: BorderRadius.circular(AppRadii.input),
                border: Border.all(color: context.semanticColors.border),
              ),
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.xs),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      asset.displayReference,
                      style: Theme.of(context).textTheme.bodySmall
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: AppSpacing.xxs),
                    Text(
                      '${_assetCategory(l10n, asset.category)} · '
                      '×${asset.quantity}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        Text(
          l10n.reviewAssetsCaptured(draft.assets.length),
          style: Theme.of(context).textTheme.bodySmall
              ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
        ),
      ],
    );
  }

  Widget _media(BuildContext context) {
    final l10n = context.l10n;
    return ReviewSection(
      eyebrow: l10n.reviewSectionMedia,
      actionLabel: l10n.reviewRetake,
      onAction: () => GoRouter.maybeOf(context)?.go(RoutePaths.captureMedia),
      children: [
        _mediaRow(
          context,
          'JPG',
          l10n.reviewMediaPhoto,
          l10n.reviewMediaPhotoHint,
          '1.4 MB',
        ),
        _mediaRow(
          context,
          '00:30',
          l10n.reviewMediaClip('00:30'),
          l10n.reviewMediaCompressed('30.4 MB'),
          '6.2 MB',
        ),
      ],
    );
  }

  Widget _mediaRow(
    BuildContext context,
    String badge,
    String title,
    String detail,
    String size,
  ) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Row(
        children: [
          SizedBox(
            height: AppDimensions.buttonHeightCompact,
            child: _mediaBadge(context, badge),
          ),
          const SizedBox(width: AppSpacing.xs),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title, style: Theme.of(context).textTheme.bodyMedium),
                Text(
                  detail,
                  style: Theme.of(context).textTheme.bodySmall
                      ?.copyWith(color: scheme.onSurfaceVariant),
                ),
              ],
            ),
          ),
          Text(
            size,
            style: Theme.of(context).textTheme.bodySmall
                ?.copyWith(color: scheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }

  Widget _mediaBadge(BuildContext context, String label) => Container(
    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(AppRadii.input),
    ),
    child: Text(label, style: Theme.of(context).textTheme.labelSmall),
  );

  String _assetCategory(AppLocalizations l10n, AssetCategory? category) =>
      switch (category?.name) {
        'generators' => l10n.captureCategoryGenerators,
        'waterPumps' => l10n.captureCategoryWaterPumps,
        'welding' => l10n.captureCategoryWelding,
        'buildingMaterials' => l10n.captureCategoryBuilding,
        'electrical' => l10n.captureCategoryElectrical,
        'sound' => l10n.captureCategorySound,
        'lighting' => l10n.captureCategoryLighting,
        'compression' => l10n.captureCategoryCompression,
        'catering' => l10n.captureCategoryCatering,
        'beverages' => l10n.captureCategoryBeverages,
        'fertilizer' => l10n.captureCategoryFertilizer,
        _ => '',
      };

  String _category(AppLocalizations l10n, ShopCategory category) =>
      switch (category.name) {
        'generators' => l10n.captureCategoryGenerators,
        'welding' => l10n.captureCategoryWelding,
        'waterPumps' => l10n.captureCategoryWaterPumps,
        'buildingMaterials' => l10n.captureCategoryBuilding,
        'electrical' => l10n.captureCategoryElectrical,
        'catering' => l10n.captureCategoryCatering,
        'sound' => l10n.captureCategorySound,
        'generatorParts' => l10n.captureCategoryParts,
        'beverages' => l10n.captureCategoryBeverages,
        'lighting' => l10n.captureCategoryLighting,
        'compression' => l10n.captureCategoryCompression,
        'fertilizer' => l10n.captureCategoryFertilizer,
        _ => '',
      };
}
