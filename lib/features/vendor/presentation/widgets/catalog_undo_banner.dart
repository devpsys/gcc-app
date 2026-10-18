import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_colors.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';

class CatalogUndoBanner extends StatelessWidget {
  const CatalogUndoBanner({
    required this.message,
    required this.actionLabel,
    required this.onUndo,
    super.key,
  });

  final String message;
  final String actionLabel;
  final VoidCallback onUndo;

  @override
  Widget build(BuildContext context) {
    final colors = context.semanticColors;
    return Material(
      color: AppColors.ink900,
      borderRadius: BorderRadius.circular(AppRadii.card),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        child: Row(
          children: [
            Icon(
              Icons.check,
              size: AppDimensions.iconSm,
              color: colors.success,
            ),
            const SizedBox(width: AppSpacing.xs),
            Expanded(
              child: Text(
                message,
                style: AppTextStyles.mono(
                  Theme.of(context).textTheme.bodySmall!
                      .copyWith(color: AppColors.surface),
                ),
              ),
            ),
            TextButton(
              onPressed: onUndo,
              child: Text(actionLabel, style: TextStyle(color: colors.success)),
            ),
          ],
        ),
      ),
    );
  }
}
