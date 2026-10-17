import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/features/agent_capture/presentation/bloc/media_pipeline.dart';

/// The 20 px status glyph: a filled tick, a spinner, or a hollow ring.
class PipelineStepGlyph extends StatelessWidget {
  const PipelineStepGlyph({
    required this.state,
    required this.tone,
    required this.glyph,
    super.key,
  });

  final PipelineStepState state;
  final Color tone;
  final IconData? glyph;

  @override
  Widget build(BuildContext context) {
    final colors = context.semanticColors;
    final running = state == PipelineStepState.running;
    return SizedBox.square(
      dimension: AppDimensions.iconMd + AppSpacing.xxs,
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: running ? colors.warningContainer : null,
          border: Border.all(
            color: state == PipelineStepState.pending ? colors.border : tone,
          ),
        ),
        child: running
            ? Padding(
                padding: const EdgeInsets.all(AppSpacing.xxs / 2),
                child: Icon(
                  Icons.sync,
                  size: AppDimensions.iconSm,
                  color: tone,
                ),
              )
            : glyph == null
            ? null
            : Icon(glyph, size: AppDimensions.iconSm, color: tone),
      ),
    );
  }
}
