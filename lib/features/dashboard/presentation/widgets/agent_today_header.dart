import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_gradients.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';

class AgentTodayHeader extends StatelessWidget {
  const AgentTodayHeader({
    this.onOpenProfile,
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

  /// Opens the profile. The profile is not one of the five agent tabs, so this
  /// is how an agent reaches it — an avatar is the discoverable convention.
  final VoidCallback? onOpenProfile;
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
              _identityRow(context, onHeader),
              const SizedBox(height: AppSpacing.sm),
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

  /// Date on the left, the install prompt and profile on the right.
  ///
  /// The prompt keeps its full label. Only the date gives up space. At a
  /// larger text scale the row wraps instead of overflowing.
  Widget _identityRow(BuildContext context, Color onHeader) {
    final date = Text(
      dateLabel.toUpperCase(),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.labelSmall
          ?.copyWith(color: onHeader.withValues(alpha: 0.7)),
    );
    final crowded = MediaQuery.textScalerOf(context).scale(1) > 1;
    if (crowded) {
      return OverflowBar(
        spacing: AppSpacing.xs,
        overflowSpacing: AppSpacing.xs,
        alignment: MainAxisAlignment.spaceBetween,
        children: [
          date,
          _installChip(context, onHeader, shrink: true),
          _avatarButton(context, onHeader),
        ],
      );
    }
    return Row(
      children: [
        Expanded(child: date),
        _installChip(context, onHeader, shrink: false),
        const SizedBox(width: AppSpacing.xs),
        _avatarButton(context, onHeader),
      ],
    );
  }

  Widget _installChip(
    BuildContext context,
    Color onHeader, {
    required bool shrink,
  }) {
    final label = Text(
      installLabel,
      maxLines: 1,
      softWrap: false,
      overflow: shrink ? TextOverflow.ellipsis : TextOverflow.clip,
      style: Theme.of(context).textTheme.labelSmall?.copyWith(
        color: onHeader.withValues(alpha: 0.95),
        fontWeight: FontWeight.w500,
        letterSpacing: 0,
      ),
    );
    return Tooltip(
      message: disabledReason,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: onHeader.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(AppRadii.pill),
          border: Border.all(color: onHeader.withValues(alpha: 0.1)),
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: AppSpacing.xxl),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.add,
                  size: AppDimensions.iconSm,
                  color: onHeader.withValues(alpha: 0.9),
                ),
                const SizedBox(width: AppSpacing.xxs),
                if (shrink) Flexible(child: label) else label,
                const SizedBox(width: AppSpacing.xxs),
                Icon(
                  Icons.close,
                  size: AppSpacing.sm,
                  color: onHeader.withValues(alpha: 0.6),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _avatarButton(BuildContext context, Color onHeader) {
    return Semantics(
      button: onOpenProfile != null,
      label: context.l10n.profileTitle,
      child: Material(
        type: MaterialType.transparency,
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onOpenProfile,
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: onHeader.withValues(alpha: 0.5)),
            ),
            child: SizedBox.square(
              dimension: AppSpacing.xxl,
              child: Icon(
                Icons.person_outline,
                size: AppSpacing.xl,
                color: onHeader,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
