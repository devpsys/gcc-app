import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/core/widgets/app_primary_button.dart';
import 'package:gcc_app/core/widgets/app_secondary_button.dart';
import 'package:gcc_app/core/widgets/destructive_confirm_dialog.dart';
import 'package:gcc_app/features/agent_sync/presentation/bloc/conflict_claim.dart';
import 'package:gcc_app/features/agent_sync/presentation/bloc/queue_file.dart';
import 'package:gcc_app/features/agent_sync/presentation/bloc/queue_item_detail_state.dart';
import 'package:gcc_app/features/agent_sync/presentation/widgets/conflict_claim_card.dart';
import 'package:gcc_app/features/agent_sync/presentation/widgets/discarded_submission_frame.dart';
import 'package:gcc_app/features/agent_sync/presentation/widgets/failure_explanation.dart';
import 'package:gcc_app/features/agent_sync/presentation/widgets/queue_detail_card.dart';
import 'package:gcc_app/features/agent_sync/presentation/widgets/queue_field_row.dart';
import 'package:gcc_app/features/agent_sync/presentation/widgets/queue_file_row.dart';
import 'package:gcc_app/features/agent_sync/presentation/widgets/synced_submission_note.dart';

/// Detail for one submission in the offline queue.
///
/// Four frames: failed, synced, duplicate conflict, and the terminal discarded
/// state. Discard is always a two-step confirmation behind an explicit button —
/// the design forbids swipe gestures on destructive actions, and so does the
/// offline-first promise of never losing an agent's work by accident.
class QueueItemPage extends StatelessWidget {
  const QueueItemPage({
    required this.state,
    required this.reference,
    required this.shopName,
    required this.location,
    required this.owner,
    required this.capturedAt,
    required this.files,
    this.failureReason,
    this.syncedAt,
    this.claim,
    this.onRetry,
    super.key,
  });
  final QueueItemDetailState state;
  final String reference;
  final String shopName;
  final String location;
  final String owner;
  final String capturedAt;
  final List<QueueFile> files;
  final String? failureReason;
  final String? syncedAt;
  final ConflictClaim? claim;
  final VoidCallback? onRetry;
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    if (state == QueueItemDetailState.discarded) {
      return DiscardedSubmissionFrame(shopName: shopName, bounty: '₦5,000');
    }
    return Scaffold(
      appBar: AppBar(title: Text(reference), backgroundColor: scheme.surface),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            _headline(context),
            const SizedBox(height: AppSpacing.md),
            QueueDetailCard(
              title: l10n.itemCaptureData,
              trailing: Text(
                l10n.itemProgressLabel('1', '2'),
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: scheme.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
              ),
              children: [
                QueueFieldRow(label: l10n.itemLabelShop, value: shopName),
                QueueFieldRow(label: l10n.itemLabelOwner, value: owner),
                QueueFieldRow(label: l10n.itemLabelLocation, value: location),
                QueueFieldRow(
                  label: l10n.itemLabelGps,
                  value: l10n.itemGpsAtCapture('±12 m'),
                  mono: true,
                ),
                QueueFieldRow(
                  label: l10n.itemLabelCaptured,
                  value: capturedAt,
                  mono: true,
                ),
                QueueFieldRow(
                  label: l10n.itemLabelDevice,
                  value: 'Samsung Galaxy A12 · Android 12',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            if (claim != null) ...[
              ConflictClaimCard(claim: claim!),
              const SizedBox(height: AppSpacing.md),
            ],
            QueueDetailCard(
              title: l10n.itemFiles,
              children: [
                for (final file in files) QueueFileRow(file: file),
                Text(
                  l10n.reviewMediaCompressed('30.4 MB'),
                  style: AppTextStyles.mono(
                    Theme.of(context).textTheme.labelSmall!
                        .copyWith(color: scheme.onSurfaceVariant),
                  ),
                ),
              ],
            ),
            if (state == QueueItemDetailState.failed) ...[
              const SizedBox(height: AppSpacing.sm),
              FailureExplanation(reason: failureReason ?? '', onExpand: () {}),
            ],
            if (state == QueueItemDetailState.synced)
              SyncedSubmissionNote(bounty: '₦5,000'),
            const SizedBox(height: AppSpacing.lg),
            _actions(context),
          ],
        ),
      ),
    );
  }

  Widget _headline(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.semanticColors;
    return switch (state) {
      QueueItemDetailState.failed => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.error_outline,
            color: colors.danger,
            size: AppDimensions.iconLg,
          ),
          const SizedBox(width: AppSpacing.xs),
          Expanded(
            child: Text(
              l10n.itemFailedHeadline(l10n.syncItemFailedReason(60)),
              style: Theme.of(context).textTheme.bodyMedium
                  ?.copyWith(color: colors.danger, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
      QueueItemDetailState.synced => Row(
        children: [
          Icon(
            Icons.check_circle_outline,
            color: colors.success,
            size: AppDimensions.iconLg,
          ),
          const SizedBox(width: AppSpacing.xs),
          Expanded(
            child: Text(
              l10n.itemSyncedHeadline(syncedAt ?? '11:04'),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: colors.success,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            l10n.itemVerifiedHeadline,
            style: Theme.of(context).textTheme.labelSmall
                ?.copyWith(color: colors.success, fontWeight: FontWeight.w700),
          ),
        ],
      ),
      _ => Text(
        l10n.itemTitle,
        style: Theme.of(context).textTheme.titleMedium
            ?.copyWith(fontWeight: FontWeight.w700),
      ),
    };
  }

  Widget _actions(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.semanticColors;
    return switch (state) {
      QueueItemDetailState.failed => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppPrimaryButton(
            label: l10n.itemRetryUpload,
            expand: true,
            onPressed: onRetry,
          ),
          const SizedBox(height: AppSpacing.xs),
          AppSecondaryButton(
            label: l10n.itemEditOnDevice,
            expand: true,
            onPressed: onRetry,
          ),
          const SizedBox(height: AppSpacing.xs),
          _destructive(
            context,
            l10n.itemDiscard,
            () => showDestructiveConfirmDialog(
              context: context,
              title: l10n.itemDiscard,
              message: l10n.itemDiscardConfirm,
              safeLabel: l10n.itemKeep,
              destructiveLabel: l10n.itemDiscard,
            ),
          ),
        ],
      ),
      QueueItemDetailState.synced => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppPrimaryButton(
            label: l10n.itemViewSubmission,
            expand: true,
            onPressed: onRetry,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            l10n.itemEditLocked,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall
                ?.copyWith(color: colors.muted),
          ),
        ],
      ),
      _ => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.itemConflictRetained,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall
                ?.copyWith(color: colors.muted),
          ),
          const SizedBox(height: AppSpacing.sm),
          _destructive(
            context,
            l10n.itemDiscardMyCopy,
            () => showDestructiveConfirmDialog(
              context: context,
              title: l10n.itemDiscardMyCopy,
              message: l10n.itemDiscardConfirm,
              safeLabel: l10n.itemKeepForReference,
              destructiveLabel: l10n.itemDiscardMyCopy,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          AppSecondaryButton(
            label: l10n.itemKeepForReference,
            expand: true,
            onPressed: onRetry,
          ),
        ],
      ),
    };
  }

  /// A destructive action rendered as a full-width danger row.
  ///
  /// Deliberately a button rather than a swipe: the design forbids gesture-only
  /// destructive actions.
  Widget _destructive(
    BuildContext context,
    String label,
    VoidCallback onPressed,
  ) {
    final colors = context.semanticColors;
    return SizedBox(
      height: AppDimensions.inputHeight,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: colors.danger,
          side: BorderSide(color: colors.dangerBorder),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadii.button),
          ),
        ),
        child: Text(label),
      ),
    );
  }
}
