import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';

/// Banner shown when the agent tries to append an incomplete asset.
///
/// Matches the validation banner the shop step uses, so the two steps read the
/// same way when something is wrong.
class AssetIssueBanner extends StatelessWidget {
  const AssetIssueBanner({required this.count, super.key});

  final int count;

  @override
  Widget build(BuildContext context) {
    final colors = context.semanticColors;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.dangerContainer,
        borderRadius: BorderRadius.circular(AppRadii.input),
        border: Border.all(color: colors.dangerBorder),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.tight,
        ),
        child: Row(
          children: [
            Icon(
              Icons.error_outline,
              size: AppDimensions.iconSm,
              color: colors.danger,
            ),
            const SizedBox(width: AppSpacing.xs),
            Expanded(
              child: Text(
                context.l10n.captureValidationBanner(count),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: colors.danger,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
