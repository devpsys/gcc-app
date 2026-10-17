import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';

/// The banner shown over the stage when a clip stops short of 30 seconds.
///
/// States both the failure and its consequence, so the agent understands why
/// a 12 second clip will not be accepted rather than just seeing it rejected.
class CameraFailureBanner extends StatelessWidget {
  const CameraFailureBanner({
    required this.seconds,
    required this.onRerecord,
    required this.onUseAnyway,
    super.key,
  });

  /// Length of the clip that was cut short.
  final int seconds;
  final VoidCallback onRerecord;
  final VoidCallback onUseAnyway;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.semanticColors;
    final scheme = Theme.of(context).colorScheme;
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: colors.dangerContainer,
            borderRadius: BorderRadius.circular(AppRadii.input),
            border: Border.all(color: colors.dangerBorder),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.sm),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.captureIncompleteClipBadge,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: colors.danger,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: AppSpacing.xxs),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.warning_amber_outlined,
                      size: AppDimensions.iconSm,
                      color: colors.danger,
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Expanded(
                      child: Text(
                        l10n.captureClipTooShort(seconds),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colors.danger,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  l10n.captureClipTooShortWhy,
                  style: Theme.of(context).textTheme.bodySmall
                      ?.copyWith(color: scheme.onSurfaceVariant),
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    Expanded(
                      child: FilledButton(
                        onPressed: onRerecord,
                        style: FilledButton.styleFrom(
                          minimumSize: const Size(0, AppDimensions.inputHeight),
                        ),
                        child: Text(l10n.captureRerecord),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: onUseAnyway,
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(0, AppDimensions.inputHeight),
                        ),
                        child: Text(
                          l10n.captureUseWhatWeHave(seconds),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
