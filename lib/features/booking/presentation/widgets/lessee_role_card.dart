import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';

/// Dual-role switcher with Lessee selected (MOB-LSE-17).
class LesseeRoleCard extends StatelessWidget {
  const LesseeRoleCard({
    required this.eyebrow,
    required this.body,
    required this.lesseeLabel,
    required this.vendorLabel,
    required this.switchLabel,
    required this.onAskSwitch,
    super.key,
  });

  final String eyebrow;
  final String body;
  final String lesseeLabel;
  final String vendorLabel;
  final String switchLabel;
  final VoidCallback onAskSwitch;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(AppRadii.card),
        border: Border.all(color: colors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              eyebrow.toUpperCase(),
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: scheme.onSurfaceVariant,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              body,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: scheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            DecoratedBox(
              decoration: BoxDecoration(
                color: scheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(AppRadii.button),
                border: Border.all(color: colors.border),
              ),
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.xxs),
                child: Row(
                  children: [
                    Expanded(
                      child: _segment(
                        context,
                        label: lesseeLabel,
                        selected: true,
                        onTap: null,
                      ),
                    ),
                    Expanded(
                      child: _segment(
                        context,
                        label: vendorLabel,
                        selected: false,
                        onTap: onAskSwitch,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: onAskSwitch,
                child: Text(switchLabel),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _segment(
    BuildContext context, {
    required String label,
    required bool selected,
    required VoidCallback? onTap,
  }) {
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: selected ? scheme.primary : scheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(AppRadii.input),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadii.input),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: AppDimensions.minTouchTarget,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
            child: Center(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: selected
                        ? scheme.onPrimary
                        : scheme.onSurfaceVariant,
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
