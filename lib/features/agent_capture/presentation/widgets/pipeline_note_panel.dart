import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/features/agent_capture/presentation/bloc/media_pipeline.dart';

/// The sheet's note card.
///
/// Its tone tracks the stage: a plain informational note while compressing or
/// queued, **warning** while paused on battery, and **info** while the agent is
/// being told which network the bytes are going over.
class PipelineNotePanel extends StatelessWidget {
  const PipelineNotePanel({required this.stage, super.key});

  final MediaPipelineStage stage;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;

    final (text, tone, glyph) = switch (stage) {
      MediaPipelineStage.batteryLow => (
        l10n.compressBatteryReason(8),
        colors.warning,
        Icons.battery_alert_outlined,
      ),
      MediaPipelineStage.uploading => (
        l10n.compressNetworkWarning(l10n.compressNetworkName),
        colors.info,
        Icons.wifi,
      ),
      MediaPipelineStage.storageLow => (
        l10n.compressStorageTitle,
        colors.danger,
        Icons.error_outline,
      ),
      _ => (l10n.compressNote, scheme.onSurfaceVariant, Icons.info_outline),
    };

    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppRadii.dialog),
        border: Border.all(color: context.semanticColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(glyph, size: AppDimensions.iconMd, color: tone),
            const SizedBox(width: AppSpacing.tight),
            Expanded(
              child: Text(
                text,
                style: Theme.of(context).textTheme.bodySmall
                    ?.copyWith(color: tone),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
