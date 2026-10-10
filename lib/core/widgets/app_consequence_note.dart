import 'package:flutter/material.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';

class AppConsequenceNote extends StatelessWidget {
  const AppConsequenceNote({
    required this.eyebrow,
    required this.title,
    required this.message,
    this.icon = Icons.shield_outlined,
    super.key,
  });

  final String eyebrow;
  final String title;
  final String message;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final tone = scheme.onPrimaryContainer;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.secondaryContainer,
        borderRadius: BorderRadius.circular(AppRadii.card),
        border: Border.all(color: scheme.primaryContainer),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: AppDimensions.iconMd, color: scheme.primary),
            const SizedBox(width: AppSpacing.xs),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    eyebrow,
                    style: textTheme.labelSmall?.copyWith(color: tone),
                  ),
                  const SizedBox(height: AppSpacing.xxs),
                  Text(
                    title,
                    style: textTheme.bodyMedium?.copyWith(
                      color: tone,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxs),
                  Text(
                    message,
                    style: textTheme.bodySmall?.copyWith(color: tone),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
