import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/agent_profile.dart';

/// The agent's identity card.
///
/// Shows tenure and verification rate together, because an agent's track record
/// is the thing a supervisor looks for. No money here — the profile design says
/// so outright.
class ProfileHeader extends StatelessWidget {
  const ProfileHeader({required this.profile, super.key});

  final AgentProfile profile;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.infoContainer,
        borderRadius: BorderRadius.circular(AppRadii.cardLarge),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: scheme.primary,
                    shape: BoxShape.circle,
                  ),
                  child: SizedBox.square(
                    dimension: AppSpacing.xxxl,
                    child: Icon(
                      Icons.person,
                      color: scheme.onPrimary,
                      size: AppDimensions.iconLg,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        profile.name,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      Text(
                        l10n.profileAgentRole(profile.agentId),
                        style: AppTextStyles.mono(
                          Theme.of(context).textTheme.bodySmall!
                              .copyWith(color: scheme.onSurfaceVariant),
                        ),
                      ),
                      Text(
                        profile.base,
                        style: Theme.of(context).textTheme.bodySmall
                            ?.copyWith(color: scheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              // Generated parameters are alphabetical: (submissions,
              // tenure, verified).
              l10n.profileTenure(
                profile.submissionCount.toString(),
                profile.since,
                profile.verifiedCount.toString(),
              ),
              style: Theme.of(context).textTheme.bodySmall
                  ?.copyWith(color: scheme.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}
