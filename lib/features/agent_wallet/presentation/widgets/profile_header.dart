import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/agent_profile.dart';

/// The agent's identity card.
///
/// Shows tenure and verification together, because an agent's track record is
/// what a supervisor looks for. No money here.
class ProfileHeader extends StatelessWidget {
  const ProfileHeader({required this.profile, super.key});

  final AgentProfile profile;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    final verified = profile.verifiedCount > 0;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(AppRadii.dialog),
        border: Border.all(color: colors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: scheme.primaryContainer,
                shape: BoxShape.circle,
                border: Border.all(
                  color: scheme.primary.withValues(alpha: 0.2),
                ),
              ),
              child: SizedBox.square(
                dimension: AppSpacing.max,
                child: Center(
                  child: Text(
                    _initials(profile.name),
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: scheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    profile.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Row(
                    children: [
                      Text(
                        '${profile.base} · ',
                        style: Theme.of(context).textTheme.bodyMedium
                            ?.copyWith(color: scheme.onSurfaceVariant),
                      ),
                      Flexible(
                        child: Text(
                          l10n.profileAgentRole(profile.agentId),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.mono(
                            Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: scheme.onSurface,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Wrap(
                    spacing: AppSpacing.xs,
                    runSpacing: AppSpacing.xxs,
                    children: [
                      if (verified)
                        _chip(
                          context,
                          label: l10n.profileVerifiedBadge,
                          foreground: colors.success,
                          background: colors.successContainer,
                          icon: Icons.check,
                        ),
                      _chip(
                        context,
                        label: l10n.profileAgentKind,
                        foreground: scheme.onSurfaceVariant,
                        background: scheme.surfaceContainerHighest,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.tight),
                  Text(
                    // Generated parameters are alphabetical: (submissions,
                    // tenure, verified).
                    l10n.profileTenure(
                      profile.submissionCount.toString(),
                      profile.since,
                      profile.verifiedCount.toString(),
                    ),
                    style: AppTextStyles.mono(
                      Theme.of(context).textTheme.labelMedium!
                          .copyWith(color: scheme.onSurfaceVariant),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _chip(
    BuildContext context, {
    required String label,
    required Color foreground,
    required Color background,
    IconData? icon,
  }) {
    final glyph = icon;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppRadii.input),
        border: Border.all(color: foreground.withValues(alpha: 0.2)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xs,
          vertical: AppSpacing.xxs,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (glyph != null) ...[
              Icon(glyph, size: AppSpacing.sm, color: foreground),
              const SizedBox(width: AppSpacing.xxs),
            ],
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: foreground,
                fontWeight: FontWeight.w600,
                letterSpacing: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String _initials(String name) {
  final parts = name
      .split(RegExp(r'\s+'))
      .where((part) => part.isNotEmpty)
      .take(2);
  return parts.map((part) => part[0]).join().toUpperCase();
}
