import 'package:flutter/material.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';

/// A titled group of settings rows.
///
/// One section per group, so the screen reads as a checklist rather than a wall
/// of rows.
class SettingsSection extends StatelessWidget {
  const SettingsSection({
    required this.title,
    required this.children,
    super.key,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.xs),
          child: Text(
            title.toUpperCase(),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: scheme.onSurfaceVariant,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        for (final child in children) child,
        const SizedBox(height: AppSpacing.sm),
      ],
    );
  }
}
