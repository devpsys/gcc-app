import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';

/// The `2/5 ready` counter beside the checklist header.
///
/// Turns brand-coloured once every shot is captured.
class FilmCountChip extends StatelessWidget {
  const FilmCountChip({required this.done, required this.total, super.key});

  final int done;
  final int total;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final complete = done == total;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.tight,
        vertical: AppSpacing.xxs / 2,
      ),
      decoration: BoxDecoration(
        color: complete
            ? scheme.primaryContainer
            : scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppRadii.input),
      ),
      child: Text(
        context.l10n.captureWhatToFilmReady(done, total),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: complete ? scheme.primary : scheme.onSurfaceVariant,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
