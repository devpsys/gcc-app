import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/core/widgets/app_primary_button.dart';
import 'package:gcc_app/features/dashboard/presentation/bloc/dashboard_snapshot.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/dashboard_text_link.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/dashboard_thumb.dart';

class PendingRequestsCard extends StatelessWidget {
  const PendingRequestsCard({
    required this.requests,
    required this.emptyTitle,
    required this.emptyBody,
    required this.waitingTitle,
    required this.respondWithin,
    required this.expiry,
    required this.respondLabel,
    required this.allRequestsLabel,
    required this.disabledReason,
    this.lastAnswered,
    super.key,
  });

  final DashboardRequests? requests;
  final String emptyTitle;
  final String emptyBody;
  final String waitingTitle;
  final String respondWithin;
  final String expiry;
  final String respondLabel;
  final String allRequestsLabel;
  final String disabledReason;
  final String? lastAnswered;

  @override
  Widget build(BuildContext context) {
    final current = requests;
    if (current == null) {
      return _empty(context);
    }
    return _frame(context, child: _waiting(context, current));
  }

  Widget _empty(BuildContext context) {
    final colors = context.semanticColors;
    final scheme = Theme.of(context).colorScheme;
    final answered = lastAnswered;
    return _frame(
      context,
      color: colors.successContainer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: colors.success,
                  shape: BoxShape.circle,
                ),
                child: SizedBox.square(
                  dimension: AppDimensions.iconLg,
                  child: Icon(
                    Icons.check,
                    size: AppDimensions.iconSm,
                    color: scheme.onPrimary,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              Expanded(
                child: Text(
                  emptyTitle,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(emptyBody, style: Theme.of(context).textTheme.bodyMedium),
          if (answered != null) ...[
            const SizedBox(height: AppSpacing.xs),
            Text(
              answered,
              style: Theme.of(context).textTheme.bodySmall
                  ?.copyWith(color: scheme.onSurfaceVariant),
            ),
          ],
        ],
      ),
    );
  }

  Widget _waiting(BuildContext context, DashboardRequests current) {
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    final countdown = Theme.of(context).textTheme.titleMedium
        ?.copyWith(color: colors.warning, fontWeight: FontWeight.w600);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          waitingTitle.toUpperCase(),
          style: Theme.of(context).textTheme.labelSmall
              ?.copyWith(color: colors.warning),
        ),
        const SizedBox(height: AppSpacing.xs),
        Row(
          children: [
            Flexible(
              child: Text(
                respondWithin,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            Semantics(
              liveRegion: false,
              child: Text(
                current.countdown,
                style: countdown == null ? null : AppTextStyles.mono(countdown),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xxs),
        Text(
          expiry,
          style: Theme.of(context).textTheme.bodySmall
              ?.copyWith(color: scheme.onSurfaceVariant),
        ),
        const SizedBox(height: AppSpacing.sm),
        DecoratedBox(
          decoration: BoxDecoration(
            color: scheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(AppRadii.input),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.sm),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const DashboardThumb(size: AppDimensions.previewThumb),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        current.headline,
                        style: Theme.of(context).textTheme.bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        current.reference,
                        style: AppTextStyles.mono(
                          Theme.of(context).textTheme.labelSmall!.copyWith(
                            letterSpacing: 0,
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                      Text(
                        current.customer,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Flexible(
                  child: Text(
                    current.amount,
                    textAlign: TextAlign.end,
                    style: AppTextStyles.tabular(
                      Theme.of(context).textTheme.bodyMedium!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        AppPrimaryButton(
          label: respondLabel,
          onPressed: null,
          disabledReason: disabledReason,
        ),
        DashboardTextLink(
          label: allRequestsLabel,
          disabledReason: disabledReason,
          chevron: true,
        ),
      ],
    );
  }

  Widget _frame(BuildContext context, {required Widget child, Color? color}) {
    final scheme = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color ?? scheme.surface,
        borderRadius: BorderRadius.circular(AppRadii.card),
        border: Border.all(color: context.semanticColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: child,
      ),
    );
  }
}
