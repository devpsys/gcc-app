import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/bounty_status.dart';

/// The lifecycle pill on a bounty.
///
/// Deliberately never carries a lock: the lock lives on the amount, where it
/// means held funds. Repeating it here would turn a status into money.
class BountyStatePill extends StatelessWidget {
  const BountyStatePill({required this.status, super.key});

  final BountyStatus status;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.semanticColors;
    final (label, foreground, background) = switch (status) {
      BountyStatus.awaitingVerification => (
        l10n.bountyStatePending,
        colors.warning,
        colors.warningContainer,
      ),
      BountyStatus.verified => (
        l10n.bountyStateVerified,
        colors.success,
        colors.successContainer,
      ),
      BountyStatus.rejected => (
        l10n.bountyStateRejected,
        colors.danger,
        colors.dangerContainer,
      ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xs,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppRadii.pill),
        border: Border.all(color: foreground),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            switch (status) {
              BountyStatus.awaitingVerification => Icons.schedule,
              BountyStatus.verified => Icons.check,
              BountyStatus.rejected => Icons.close,
            },
            size: AppSpacing.sm,
            color: foreground,
          ),
          const SizedBox(width: AppSpacing.xxs),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall
                ?.copyWith(color: foreground, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
