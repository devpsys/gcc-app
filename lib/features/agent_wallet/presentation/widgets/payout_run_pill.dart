import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';

/// The paid/open pill on a run. Never carries a lock: a run is a schedule, not
/// an escrow.
class PayoutRunPill extends StatelessWidget {
  const PayoutRunPill({required this.open, super.key});

  final bool open;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.semanticColors;
    final (label, tone) = open
        ? (l10n.walletRunOpen, colors.info)
        : (l10n.walletRunPaid, colors.success);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xs,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: open ? colors.infoContainer : colors.successContainer,
        borderRadius: BorderRadius.circular(AppRadii.pill),
        border: Border.all(color: tone),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall
            ?.copyWith(color: tone, fontWeight: FontWeight.w700),
      ),
    );
  }
}
