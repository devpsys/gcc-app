import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';

class HandbackWatchGate extends StatelessWidget {
  const HandbackWatchGate({
    required this.durationSeconds,
    required this.videoWatched,
    required this.confirmed,
    required this.onChanged,
    super.key,
  });

  final int durationSeconds;
  final bool videoWatched;
  final bool confirmed;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.semanticColors;
    final scheme = Theme.of(context).colorScheme;
    final active = videoWatched && confirmed;
    return Material(
      color: active
          ? scheme.primaryContainer.withValues(alpha: 0.55)
          : scheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadii.dialog),
        side: BorderSide(
          color: active
              ? scheme.primary.withValues(alpha: 0.35)
              : colors.border,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: CheckboxListTile(
        value: confirmed,
        onChanged: videoWatched ? (value) => onChanged(value ?? false) : null,
        controlAffinity: ListTileControlAffinity.leading,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xs,
          vertical: AppSpacing.xxs,
        ),
        secondary: videoWatched
            ? null
            : Tooltip(
                message: l10n.handbackWatchBeforeConfirm,
                child: Icon(
                  Icons.info_outline,
                  size: AppDimensions.iconSm,
                  color: colors.muted,
                ),
              ),
        title: Text(
          l10n.handbackWatchConfirm(durationSeconds),
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: active ? scheme.secondary : null,
          ),
        ),
        subtitle: Text(
          l10n.handbackWatchHint,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: active
                ? scheme.secondary.withValues(alpha: 0.8)
                : colors.muted,
          ),
        ),
      ),
    );
  }
}
