import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_gradients.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:intl/intl.dart';

/// Brand-wash greeting strip for MOB-LSE-17 (date, hello, avatar, install).
class LesseeProfileTopBar extends StatelessWidget {
  const LesseeProfileTopBar({
    required this.greetingName,
    required this.initials,
    required this.installLabel,
    this.onInstall,
    super.key,
  });

  final String greetingName;
  final String initials;
  final String installLabel;
  final VoidCallback? onInstall;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final locale = Localizations.localeOf(context).toString();
    final dateLabel = DateFormat('EEEE, d MMMM', locale).format(DateTime.now());
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: AppGradients.lesseeProfileWash,
        border: Border(
          bottom: BorderSide(color: scheme.primary.withValues(alpha: 0.12)),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.md,
            AppSpacing.sm,
            AppSpacing.md,
            AppSpacing.md,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          dateLabel.toUpperCase(),
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(
                                color: scheme.primary,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.6,
                              ),
                        ),
                        Text(
                          l10n.lesseeProfileGreeting(greetingName),
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: scheme.onSecondaryContainer,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: scheme.surface,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: scheme.primary,
                        width: AppDimensions.emphasisBorderWidth,
                      ),
                    ),
                    child: SizedBox.square(
                      dimension: AppDimensions.minTouchTarget,
                      child: Center(
                        child: FittedBox(
                          child: Text(
                            initials,
                            style: Theme.of(context).textTheme.labelLarge
                                ?.copyWith(
                                  color: scheme.primary,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.sizeOf(context).width - AppSpacing.md * 2,
                ),
                child: Material(
                  color: scheme.surface.withValues(alpha: 0.85),
                  shape: StadiumBorder(
                    side: BorderSide(
                      color: scheme.primary.withValues(alpha: 0.35),
                    ),
                  ),
                  child: InkWell(
                    onTap: onInstall,
                    customBorder: const StadiumBorder(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: AppSpacing.xs,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.download_outlined,
                            size: AppDimensions.iconSm,
                            color: scheme.primary,
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          Flexible(
                            child: Text(
                              installLabel,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.labelSmall
                                  ?.copyWith(
                                    color: scheme.primary,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
