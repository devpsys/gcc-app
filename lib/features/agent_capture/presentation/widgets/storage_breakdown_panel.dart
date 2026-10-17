import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/features/agent_capture/presentation/bloc/storage_usage.dart';

/// Explains why an upload cannot be staged and what is holding the space.
///
/// This is the design's only danger state in the media pipeline, and it is
/// danger because the upload genuinely cannot proceed — not because money is
/// at stake.
class StorageBreakdownPanel extends StatelessWidget {
  const StorageBreakdownPanel({
    required this.requiredLabel,
    required this.freeLabel,
    required this.usages,
    this.onClear,
    super.key,
  });

  /// Clears one storage category.
  ///
  /// Null - the default - withholds the per-row clear affordance entirely,
  /// because there is no storage backend yet. A button that cannot act is a
  /// dead end, so it is not drawn.
  final void Function(String labelKey)? onClear;

  static const List<StorageUsage> defaultUsages = [
    StorageUsage(labelKey: 'history', sizeLabel: '1.4 GB', clearable: true),
    StorageUsage(labelKey: 'photos', sizeLabel: '420 MB'),
    StorageUsage(labelKey: 'maps', sizeLabel: '180 MB'),
  ];

  final String requiredLabel;
  final String freeLabel;
  final List<StorageUsage> usages;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.dangerContainer,
        borderRadius: BorderRadius.circular(AppRadii.dialog),
        border: Border.all(color: colors.dangerBorder),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.compressStorageTitle,
              style: Theme.of(context).textTheme.bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: AppSpacing.xxs),
            Text(
              l10n.compressStorageReason('1.4 GB', freeLabel, requiredLabel),
              style: Theme.of(context).textTheme.bodySmall
                  ?.copyWith(color: colors.danger),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              l10n.compressStorageHeading,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: scheme.onSurfaceVariant,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: AppSpacing.xxs),
            for (final usage in usages)
              Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.xxs),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(switch (usage.labelKey) {
                        'history' => l10n.compressSpaceHistory,
                        'photos' => l10n.compressSpacePhotos,
                        _ => l10n.compressSpaceMaps,
                      }, style: Theme.of(context).textTheme.bodySmall),
                    ),
                    Text(
                      usage.sizeLabel,
                      style: AppTextStyles.mono(
                        Theme.of(context).textTheme.labelSmall!
                            .copyWith(color: scheme.onSurface),
                      ),
                    ),
                    // Per-row clearing needs a storage backend. Withholding the
                    // affordance beats offering a button that cannot act.
                    if (usage.clearable && onClear != null) ...[
                      const SizedBox(width: AppSpacing.xs),
                      SizedBox(
                        height: AppDimensions.buttonHeightCompact,
                        child: TextButton(
                          onPressed: () => onClear!(usage.labelKey),
                          style: TextButton.styleFrom(
                            foregroundColor: colors.danger,
                            minimumSize: const Size(0, 0),
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.xs,
                            ),
                          ),
                          child: Text(
                            context.l10n.compressClear,
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(
                                  color: colors.danger,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
