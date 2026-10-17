import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';

/// The tick or hollow circle that marks a shot as captured.
class FilmShotTick extends StatelessWidget {
  const FilmShotTick({required this.done, super.key});

  final bool done;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return SizedBox.square(
      dimension: AppSpacing.md,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: done ? scheme.primaryContainer : scheme.surface,
          shape: BoxShape.circle,
          border: Border.all(
            color: done ? scheme.primary : context.semanticColors.border,
          ),
        ),
        child: done
            ? Icon(
                Icons.check,
                size: AppDimensions.iconSm - 4,
                color: scheme.primary,
              )
            : null,
      ),
    );
  }
}
