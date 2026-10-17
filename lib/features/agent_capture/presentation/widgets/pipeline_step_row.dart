import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/features/agent_capture/presentation/bloc/media_pipeline.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/compression_size_pair.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/pipeline_step_glyph.dart';

/// One row in the media pipeline's status list.
///
/// The design's semantics are load-bearing: a done step is success, the running
/// step is **warning** (the work is in flight, not complete), a queued step is
/// **info**, and nothing here ever reads as a money state — a pending bounty is
/// not held funds, so no row may carry a lock glyph.
class PipelineStepRow extends StatelessWidget {
  const PipelineStepRow({required this.step, super.key});

  final PipelineStep step;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    final (tone, glyph) = switch (step.state) {
      PipelineStepState.done => (colors.success, Icons.check),
      PipelineStepState.running => (colors.warning, Icons.sync),
      PipelineStepState.waiting => (colors.info, Icons.schedule),
      PipelineStepState.pending => (colors.muted, null),
    };
    final detail = step.detail;
    final pair = step.sizePair;
    final progress = step.progress;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.sm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              PipelineStepGlyph(state: step.state, tone: tone, glyph: glyph),
              const SizedBox(width: AppSpacing.tight),
              Expanded(
                child: Text(
                  step.label,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: step.state == PipelineStepState.pending
                        ? scheme.onSurfaceVariant
                        : scheme.onSurface,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              if (pair != null)
                CompressionSizePair(before: pair.$1, after: pair.$2)
              else if (detail != null)
                Text(
                  detail,
                  style: Theme.of(context).textTheme.bodySmall
                      ?.copyWith(color: tone, fontWeight: FontWeight.w700),
                ),
            ],
          ),
          if (progress != null) ...[
            const SizedBox(height: AppSpacing.xxs),
            ClipRRect(
              borderRadius: BorderRadius.circular(AppRadii.pill),
              child: SizedBox(
                height: AppSpacing.xxs,
                child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor: colors.border,
                  valueColor: AlwaysStoppedAnimation<Color>(tone),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
