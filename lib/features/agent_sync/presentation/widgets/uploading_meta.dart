import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/features/agent_sync/presentation/bloc/queue_item.dart';

/// The determinate progress line shown on the uploading card.
class UploadingMeta extends StatelessWidget {
  const UploadingMeta({required this.item, super.key});
  final QueueItem item;
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.semanticColors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          l10n.syncItemUploading(
            item.doneBytes ?? '',
            (item.progress * 100).round(),
            item.totalBytes ?? '',
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.mono(
            Theme.of(context).textTheme.labelSmall!
                .copyWith(color: colors.warning, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(height: AppSpacing.xxs),
        ClipRRect(
          borderRadius: BorderRadius.circular(AppRadii.pill),
          child: SizedBox(
            height: AppSpacing.xxs,
            child: LinearProgressIndicator(
              value: item.progress,
              backgroundColor: colors.border,
              valueColor: AlwaysStoppedAnimation<Color>(colors.warning),
            ),
          ),
        ),
      ],
    );
  }
}
