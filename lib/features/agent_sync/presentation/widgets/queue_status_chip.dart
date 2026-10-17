import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/features/agent_sync/presentation/bloc/queue_item_status.dart';

/// A status pill on a queue card.
///
/// The design is explicit about the tones: queued is **info**, uploading is
/// **warning**, synced is **success**, failed is **danger**. None of them is
/// ever amber-with-a-lock, because a pending bounty is not held funds.
class QueueStatusChip extends StatelessWidget {
  const QueueStatusChip({required this.label, required this.status, super.key});
  final String label;
  final QueueItemStatus status;
  @override
  Widget build(BuildContext context) {
    final colors = context.semanticColors;
    final (background, foreground) = switch (status) {
      QueueItemStatus.queued => (colors.infoContainer, colors.info),
      QueueItemStatus.uploading => (colors.warningContainer, colors.warning),
      QueueItemStatus.synced => (colors.successContainer, colors.success),
      QueueItemStatus.failed => (colors.dangerContainer, colors.danger),
    };
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.tight + 1,
        vertical: AppSpacing.xxs,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppRadii.input),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall
            ?.copyWith(color: foreground, fontWeight: FontWeight.w600),
      ),
    );
  }
}
