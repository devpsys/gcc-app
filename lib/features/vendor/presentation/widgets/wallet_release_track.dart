import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/features/vendor/domain/vendor_release_step.dart';

/// Condition, check-in, then money into the wallet.
class WalletReleaseTrack extends StatelessWidget {
  const WalletReleaseTrack({
    required this.steps,
    required this.titles,
    required this.pendingLabel,
    required this.note,
    super.key,
  });

  final List<VendorReleaseStep> steps;
  final List<String> titles;
  final String pendingLabel;
  final String note;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppRadii.card),
        border: Border.all(color: colors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var index = 0; index < steps.length; index++)
                  Expanded(
                    child: _step(
                      context,
                      steps[index],
                      index < titles.length ? titles[index] : '',
                    ),
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.xs),
            Divider(height: AppDimensions.borderWidth, color: colors.border),
            const SizedBox(height: AppSpacing.xs),
            Text(
              note,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall
                  ?.copyWith(color: scheme.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }

  Widget _step(BuildContext context, VendorReleaseStep step, String title) {
    final scheme = Theme.of(context).colorScheme;
    final current = step.mark == VendorReleaseMark.current;
    final done = step.mark == VendorReleaseMark.done;
    final color = done || current ? scheme.primary : scheme.outline;
    final when = step.when ?? pendingLabel;
    return Column(
      children: [
        Icon(
          done
              ? Icons.check_circle
              : current
              ? Icons.circle
              : Icons.circle_outlined,
          size: AppDimensions.iconSm,
          color: color,
        ),
        const SizedBox(height: AppSpacing.xxs),
        Text(
          title,
          textAlign: TextAlign.center,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: current ? scheme.primary : scheme.onSurface,
            fontWeight: current ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
        Text(
          when,
          textAlign: TextAlign.center,
          style: AppTextStyles.mono(
            Theme.of(context).textTheme.labelSmall!.copyWith(color: color),
          ),
        ),
      ],
    );
  }
}
