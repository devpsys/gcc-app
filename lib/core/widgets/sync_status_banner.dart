import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';

enum SyncBannerKind { offline, syncing, failed, synced }

class SyncStatusBanner extends StatelessWidget {
  const SyncStatusBanner({
    required this.kind,
    required this.message,
    this.detail,
    this.progress,
    this.actionLabel,
    this.onAction,
    this.inline = false,
    super.key,
  });

  final SyncBannerKind kind;
  final String message;
  final String? detail;
  final double? progress;
  final String? actionLabel;
  final VoidCallback? onAction;
  final bool inline;

  @override
  Widget build(BuildContext context) {
    final colors = context.semanticColors;
    final treatment = switch (kind) {
      SyncBannerKind.offline => (
        colors.warning,
        colors.warningContainer,
        Icons.wifi_off,
      ),
      SyncBannerKind.syncing => (colors.info, colors.infoContainer, Icons.sync),
      SyncBannerKind.failed => (
        colors.danger,
        colors.dangerContainer,
        Icons.error_outline,
      ),
      SyncBannerKind.synced => (
        colors.success,
        colors.successContainer,
        Icons.cloud_done_outlined,
      ),
    };
    final detailText = detail;
    final action = actionLabel;
    final value = progress;
    if (inline) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: treatment.$2,
          border: Border(bottom: BorderSide(color: treatment.$1)),
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: AppDimensions.minTouchTarget,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            child: Row(
              children: [
                Icon(
                  treatment.$3,
                  size: AppDimensions.iconSm,
                  color: treatment.$1,
                ),
                const SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: Text(
                    message,
                    style: Theme.of(context).textTheme.bodySmall
                        ?.copyWith(fontWeight: FontWeight.w500),
                  ),
                ),
                if (detailText != null) ...[
                  const SizedBox(width: AppSpacing.xs),
                  Flexible(
                    child: Text(
                      detailText,
                      textAlign: TextAlign.end,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.mono(
                        Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ),
                ],
                Icon(
                  Icons.chevron_right,
                  size: AppDimensions.iconSm,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ),
      );
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        color: treatment.$2,
        borderRadius: BorderRadius.circular(AppRadii.card),
        border: Border.all(color: treatment.$1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  treatment.$3,
                  size: AppDimensions.iconMd,
                  color: treatment.$1,
                ),
                const SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: Text(
                    message,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: treatment.$1,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                if (action != null)
                  TextButton(onPressed: onAction, child: Text(action)),
              ],
            ),
            if (detailText != null) ...[
              const SizedBox(height: AppSpacing.xxs),
              Text(detailText, style: Theme.of(context).textTheme.bodySmall),
            ],
            if (kind == SyncBannerKind.syncing && value != null) ...[
              const SizedBox(height: AppSpacing.xs),
              ClipRRect(
                borderRadius: BorderRadius.circular(AppRadii.pill),
                child: LinearProgressIndicator(
                  value: value,
                  minHeight: AppDimensions.syncProgressHeight,
                  color: treatment.$1,
                  backgroundColor: treatment.$2,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
