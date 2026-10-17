import 'package:flutter/material.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/features/agent_capture/presentation/bloc/film_checklist_item.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/film_shot_tick.dart';

/// One checklist line: a tick circle and its label.
class FilmChecklistRow extends StatelessWidget {
  const FilmChecklistRow({required this.item, super.key});

  final FilmChecklistItem item;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        FilmShotTick(done: item.done),
        const SizedBox(width: AppSpacing.xs),
        Expanded(
          child: Text(
            item.label,
            style: Theme.of(context).textTheme.bodySmall
                ?.copyWith(color: scheme.onSurface),
          ),
        ),
      ],
    );
  }
}
