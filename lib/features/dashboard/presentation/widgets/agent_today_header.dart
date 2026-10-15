import 'package:flutter/material.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_gradients.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';

class AgentTodayHeader extends StatelessWidget {
  const AgentTodayHeader({
    required this.dateLabel,
    required this.greeting,
    required this.assignment,
    required this.agentId,
    required this.installLabel,
    required this.disabledReason,
    super.key,
  });

  final String dateLabel;
  final String greeting;
  final String? assignment;
  final String? agentId;
  final String installLabel;
  final String disabledReason;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final onHeader = scheme.onPrimary;
    final place = assignment;
    final identifier = agentId;
    return DecoratedBox(
      decoration: const BoxDecoration(gradient: AppGradients.agentHeaderWash),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.md,
            AppSpacing.xs,
            AppSpacing.md,
            AppSpacing.xl,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      dateLabel.toUpperCase(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.labelSmall
                          ?.copyWith(color: onHeader.withValues(alpha: 0.7)),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Flexible(child: _installChip(context, onHeader)),
                ],
              ),
              const SizedBox(height: AppSpacing.xs),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          greeting,
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(color: onHeader),
                        ),
                        if (place != null)
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                size: AppDimensions.iconSm,
                                color: onHeader.withValues(alpha: 0.7),
                              ),
                              const SizedBox(width: AppSpacing.xxs),
                              Expanded(
                                child: Text(
                                  place,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(
                                        color: onHeader.withValues(alpha: 0.8),
                                      ),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                  if (identifier != null) ...[
                    const SizedBox(width: AppSpacing.xs),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: onHeader.withValues(alpha: 0.16),
                        borderRadius: BorderRadius.circular(AppRadii.pill),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.xs,
                          vertical: AppSpacing.xxs,
                        ),
                        child: Text(
                          identifier,
                          style: AppTextStyles.mono(
                            Theme.of(context).textTheme.labelMedium!.copyWith(
                              color: onHeader.withValues(alpha: 0.9),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _installChip(BuildContext context, Color onHeader) {
    return Tooltip(
      message: disabledReason,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: onHeader.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(AppRadii.pill),
          border: Border.all(color: onHeader.withValues(alpha: 0.1)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xs,
            vertical: AppSpacing.xxs,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.add, size: AppDimensions.iconSm, color: onHeader),
              const SizedBox(width: AppSpacing.xxs),
              Flexible(
                child: Text(
                  installLabel,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelSmall
                      ?.copyWith(color: onHeader, letterSpacing: 0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
