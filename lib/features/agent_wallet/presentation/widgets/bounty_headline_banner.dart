import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/bounty_status.dart';

/// The status line under the shop name.
class BountyHeadlineBanner extends StatelessWidget {
  const BountyHeadlineBanner({
    required this.status,
    required this.message,
    super.key,
  });

  final BountyStatus status;
  final String message;

  @override
  Widget build(BuildContext context) {
    final colors = context.semanticColors;
    final (tone, background) = switch (status) {
      BountyStatus.awaitingVerification => (
        colors.warning,
        colors.warningContainer,
      ),
      BountyStatus.verified => (colors.success, colors.successContainer),
      BountyStatus.rejected => (colors.danger, colors.dangerContainer),
    };

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppRadii.input),
      ),
      child: Row(
        children: [
          Icon(
            switch (status) {
              BountyStatus.awaitingVerification => Icons.schedule,
              BountyStatus.verified => Icons.verified_outlined,
              BountyStatus.rejected => Icons.report_gmailerrorred_outlined,
            },
            size: AppSpacing.md,
            color: tone,
          ),
          const SizedBox(width: AppSpacing.xs),
          Expanded(
            child: Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium
                  ?.copyWith(color: tone, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
