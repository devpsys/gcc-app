import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/features/agent_capture/presentation/bloc/media_pipeline.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/compression_radio.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/recommended_chip.dart';

/// One selectable compression target in the quality selector.
///
/// Carries the radio, the name, its hint, and the size and transfer figures the
/// design prints on the trailing edge. The original quality is the one an agent
/// should be talked out of on a field connection, so it carries a warning line.
class CompressionOptionRow extends StatelessWidget {
  const CompressionOptionRow({
    required this.option,
    required this.selected,
    required this.onTap,
    super.key,
  });

  final CompressionOption option;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    final warning = option.warningLabel;

    // The sheet body supplies no Material ancestor, so the row provides its own
    // transparent surface for the ink splash.
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: onTap,
        child: Container(
          constraints: const BoxConstraints(
            minHeight: AppDimensions.inputHeight,
          ),
          color: selected
              ? scheme.primaryContainer.withValues(alpha: 0.4)
              : null,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.sm,
          ),
          child: Row(
            children: [
              CompressionRadio(selected: selected),
              const SizedBox(width: AppSpacing.tight),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Wrap, not Row: at a large text scale the chip drops to
                    // its own line instead of pushing the row off screen.
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: AppSpacing.tight,
                      children: [
                        Text(
                          switch (option.quality) {
                            CompressionQuality.smallest =>
                              l10n.compressQualitySmallest,
                            CompressionQuality.balanced =>
                              l10n.compressQualityBalanced,
                            CompressionQuality.original =>
                              l10n.compressQualityOriginal,
                          },
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: scheme.onSurface,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        if (option.recommended)
                          RecommendedChip(label: l10n.compressRecommended),
                      ],
                    ),
                    Text(
                      switch (option.quality) {
                        CompressionQuality.smallest =>
                          l10n.compressQualitySmallestHint,
                        CompressionQuality.balanced =>
                          l10n.compressQualityBalancedHint,
                        CompressionQuality.original =>
                          l10n.compressQualityOriginalHint,
                      },
                      style: Theme.of(context).textTheme.bodySmall
                          ?.copyWith(color: scheme.onSurfaceVariant),
                    ),
                    if (warning != null)
                      Text(
                        warning,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colors.warning,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    option.sizeLabel,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: scheme.onSurface,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    option.durationLabel,
                    style: Theme.of(context).textTheme.labelSmall
                        ?.copyWith(color: scheme.onSurfaceVariant),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
