import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';

enum StatusTone { success, info, held, danger, warning, muted }

class StatusChip extends StatelessWidget {
  const StatusChip({
    required this.label,
    required this.tone,
    this.icon,
    super.key,
  });

  final String label;
  final StatusTone tone;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final colors = context.semanticColors;
    final scheme = Theme.of(context).colorScheme;
    final treatment = switch (tone) {
      StatusTone.success => (colors.success, colors.successContainer),
      StatusTone.info => (colors.info, colors.infoContainer),
      StatusTone.held => (colors.heldFunds, colors.heldFundsContainer),
      StatusTone.danger => (colors.danger, colors.dangerContainer),
      StatusTone.warning => (colors.warning, colors.warningContainer),
      StatusTone.muted => (scheme.onSurface.withValues(alpha: 0.6), null),
    };
    final glyph = tone == StatusTone.held ? Icons.lock : icon;

    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: treatment.$2,
          borderRadius: BorderRadius.circular(AppRadii.input),
          border: Border.all(
            color: tone == StatusTone.muted
                ? scheme.onSurfaceVariant
                : treatment.$1.withValues(
                    alpha: tone == StatusTone.held || tone == StatusTone.warning
                        ? 0.4
                        : 0.3,
                  ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xs,
            vertical: AppSpacing.xxs,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (glyph != null) ...[
                Icon(glyph, size: AppDimensions.iconSm, color: treatment.$1),
                const SizedBox(width: AppSpacing.xxs),
              ],
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: treatment.$1,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
