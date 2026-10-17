import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';

/// The offline banner on the review screen.
///
/// Info, not warning: submitting offline is a supported path, not a problem.
/// The design keeps `Submit` enabled and explains that the capture queues.
class OfflineSubmitBanner extends StatelessWidget {
  const OfflineSubmitBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.semanticColors;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.infoContainer,
        borderRadius: BorderRadius.circular(AppRadii.dialog),
        border: Border.all(color: colors.info.withValues(alpha: 0.25)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Row(
          children: [
            Icon(
              Icons.cloud_off_outlined,
              size: AppDimensions.iconMd,
              color: colors.info,
            ),
            const SizedBox(width: AppSpacing.xs),
            Expanded(
              child: Text(
                l10n.reviewOfflineReason,
                style: Theme.of(context).textTheme.bodySmall
                    ?.copyWith(color: colors.info),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
