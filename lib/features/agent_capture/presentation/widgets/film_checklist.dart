import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/features/agent_capture/presentation/bloc/film_checklist_item.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/film_checklist_row.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/film_count_chip.dart';

/// The collapsible "What to film" list.
///
/// Collapsed it shows the header, a `2/5 ready` counter and the first two
/// shots, which is what the design's first frame draws. Expanding reveals the
/// rest — an agent filming on a phone should not have to scroll a list before
/// they can start recording.
class FilmChecklist extends StatelessWidget {
  const FilmChecklist({
    required this.items,
    required this.expanded,
    required this.onToggle,
    super.key,
  });

  final List<FilmChecklistItem> items;
  final bool expanded;
  final VoidCallback onToggle;

  /// How many shots the collapsed view reveals.
  static const int collapsedCount = 2;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final done = items.where((item) => item.done).length;
    final visible = expanded ? items : items.take(collapsedCount).toList();

    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surface,
        border: Border(
          bottom: BorderSide(color: context.semanticColors.border),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: scheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(AppRadii.dialog),
            border: Border.all(color: context.semanticColors.border),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.tight),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: onToggle,
                  child: Row(
                    children: [
                      // The title gives way first so the counter and the
                      // expand affordance always stay reachable.
                      Expanded(
                        child: Row(
                          children: [
                            Flexible(
                              child: Text(
                                l10n.captureWhatToFilm,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.labelMedium
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                            ),
                            const SizedBox(width: AppSpacing.xs),
                            FilmCountChip(done: done, total: items.length),
                          ],
                        ),
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Icon(
                        expanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        size: AppDimensions.iconSm,
                        color: scheme.primary,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                for (final item in visible)
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.tight),
                    child: FilmChecklistRow(item: item),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
