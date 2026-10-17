import 'package:flutter/material.dart';

import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/features/agent_sync/presentation/bloc/queue_file.dart';
import 'package:gcc_app/features/agent_sync/presentation/bloc/queue_file_state.dart';

/// One attached file with its per-file outcome.
///
/// Failed, synced and not-yet-uploaded are visually distinct because the
/// agent's decision differs for each: retry, ignore, or keep.
class QueueFileRow extends StatelessWidget {
  const QueueFileRow({required this.file, super.key});

  final QueueFile file;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.semanticColors;
    final scheme = Theme.of(context).colorScheme;
    final (icon, tone) = switch (file.state) {
      QueueFileState.failed => (Icons.close, colors.danger),
      QueueFileState.synced => (Icons.check, colors.success),
      QueueFileState.notUploaded => (Icons.remove, scheme.onSurfaceVariant),
    };
    final syncedAt = file.syncedAt;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Row(
        children: [
          Icon(icon, size: AppDimensions.iconSm, color: tone),
          const SizedBox(width: AppSpacing.xs),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  file.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                if (syncedAt != null)
                  Text(
                    l10n.itemFileSyncedAt(syncedAt),
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: colors.success,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                else
                  Text(
                    file.state == QueueFileState.failed
                        ? l10n.itemItemFailedShort
                        : l10n.itemFileNotUploaded,
                    style: Theme.of(context).textTheme.labelSmall
                        ?.copyWith(color: tone, fontWeight: FontWeight.w600),
                  ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
          Text(
            file.sizeLabel,
            style: Theme.of(context).textTheme.labelSmall
                ?.copyWith(color: scheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}
