import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/features/agent_capture/presentation/bloc/media_pipeline.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/pipeline_step_row.dart';

/// The grouped list of pipeline steps the design draws as one bordered card.
class PipelineStepList extends StatelessWidget {
  const PipelineStepList({required this.steps, super.key});

  final List<PipelineStep> steps;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadii.dialog),
        border: Border.all(color: context.semanticColors.border),
      ),
      child: Column(
        children: [for (final step in steps) PipelineStepRow(step: step)],
      ),
    );
  }
}
