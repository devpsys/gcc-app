import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/bounty_status.dart';
import 'package:gcc_app/features/agent_wallet/presentation/widgets/bounty_state_pill.dart';
import 'package:gcc_app/features/agent_wallet/presentation/widgets/escrow_hatch.dart';

/// The bounty amount and what has happened to it.
///
/// This is the only place in the app where a lock glyph is correct, and only
/// while funds are held. The lock is derived from [status] rather than passed
/// in, so it cannot appear on the verified or rejected frames by mistake — the
/// designs forbid it there outright.
class BountyAmountPanel extends StatelessWidget {
  const BountyAmountPanel({
    required this.status,
    required this.amount,
    this.note,
    this.disclaimer,
    super.key,
  });

  final BountyStatus status;
  final String amount;

  /// e.g. `Approved 13 Oct`, `Pending`, `Not payable`.
  final String? note;
  final String? disclaimer;

  @override
  Widget build(BuildContext context) {
    final colors = context.semanticColors;
    final escrowed = isEscrowed(status);
    final (background, foreground) = switch (status) {
      BountyStatus.awaitingVerification => (
        colors.warningContainer,
        colors.warning,
      ),
      BountyStatus.verified => (colors.successContainer, colors.success),
      BountyStatus.rejected => (colors.dangerContainer, colors.danger),
    };

    return DecoratedBox(
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppRadii.cardLarge),
        border: Border.all(color: foreground.withValues(alpha: 0.25)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadii.cardLarge),
        child: Stack(
          children: [
            if (escrowed)
              const Positioned.fill(
                child: CustomPaint(painter: EscrowHatchPainter()),
              ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Text(
                        context.l10n.bountyLabel,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: foreground,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Spacer(),
                      BountyStatePill(status: status),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Row(
                    children: [
                      // Only held funds carry the lock.
                      if (escrowed)
                        Padding(
                          padding: const EdgeInsets.only(right: AppSpacing.xs),
                          child: Icon(
                            Icons.lock,
                            size: AppSpacing.xl,
                            color: foreground,
                          ),
                        ),
                      Text(
                        amount,
                        style: AppTextStyles.tabular(
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                            fontWeight: FontWeight.w700,
                            color: foreground,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (note != null) ...[
                    const SizedBox(height: AppSpacing.xxs),
                    Text(
                      note!,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: foreground,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                  if (disclaimer != null) ...[
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      disclaimer!,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
