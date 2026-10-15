import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';

class CategoryChipRow extends StatelessWidget {
  const CategoryChipRow({
    required this.categories,
    required this.disabledReason,
    super.key,
  });

  final List<({String label, IconData icon})> categories;
  final String disabledReason;

  @override
  Widget build(BuildContext context) {
    final tile = MediaQuery.textScalerOf(context)
        .scale(AppDimensions.skeletonThumb);
    return SizedBox(
      height: tile,
      child: ListView.separated(
        primary: false,
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (context, index) =>
            const SizedBox(width: AppSpacing.xs),
        itemBuilder: (context, index) {
          final category = categories[index];
          final selected = index == 0;
          final scheme = Theme.of(context).colorScheme;
          final foreground = selected ? scheme.primary : scheme.onSurface;
          return Tooltip(
            message: disabledReason,
            child: SizedBox(
              width: tile,
              height: tile,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: selected ? scheme.primaryContainer : scheme.surface,
                  borderRadius: BorderRadius.circular(AppRadii.input),
                  border: selected
                      ? null
                      : Border.all(color: context.semanticColors.border),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.xxs),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        category.icon,
                        size: AppDimensions.iconMd,
                        color: foreground,
                      ),
                      const SizedBox(height: AppSpacing.xxs),
                      Text(
                        category.label,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.labelSmall
                            ?.copyWith(color: foreground, letterSpacing: 0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
