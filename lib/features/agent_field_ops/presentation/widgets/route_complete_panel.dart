import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/core/widgets/app_primary_button.dart';
import 'package:gcc_app/core/widgets/app_secondary_button.dart';

// The end-of-route panel shown once every stop is captured.
///
/// States plainly what is still uploading and what the day's work cost in
/// distance and time. No bounty figure: the design puts money in the wallet
/// only, and this is a work list.
class RouteCompletePanel extends StatelessWidget {
  const RouteCompletePanel({
    required this.stopCount,
    required this.uploadedCount,
    required this.pendingCount,
    required this.routeDistance,
    required this.elapsed,
    required this.loadNextLabel,
    required this.viewSubmissionsLabel,
    this.onLoadNext,
    this.onViewSubmissions,
    super.key,
  });

  /// Stops on the finished route.
  final int stopCount;

  /// How many of those have finished uploading.
  final int uploadedCount;

  /// How many are still on the device.
  final int pendingCount;

  /// e.g. `18.4 km`.
  final String routeDistance;

  /// e.g. `3 h 20 m`.
  final String elapsed;
  final String loadNextLabel;
  final String viewSubmissionsLabel;
  final VoidCallback? onLoadNext;
  final VoidCallback? onViewSubmissions;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: colors.successContainer,
              shape: BoxShape.circle,
            ),
            child: SizedBox.square(
              dimension: AppDimensions.emptyStateIcon,
              child: Icon(
                Icons.check_rounded,
                size: AppDimensions.iconLg * 1.5,
                color: colors.success,
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          l10n.shopsAllDoneTitle(stopCount),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineSmall
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          l10n.shopsAllDoneBody(
            routeDistance,
            elapsed,
            pendingCount,
            uploadedCount,
          ),
          textAlign: TextAlign.center,
          style: AppTextStyles.mono(
            Theme.of(context).textTheme.bodyMedium!
                .copyWith(color: scheme.onSurfaceVariant),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        AppPrimaryButton(
          label: loadNextLabel,
          expand: true,
          onPressed: onLoadNext,
        ),
        const SizedBox(height: AppSpacing.xs),
        AppSecondaryButton(
          label: viewSubmissionsLabel,
          expand: true,
          onPressed: onViewSubmissions,
        ),
      ],
    );
  }
}
