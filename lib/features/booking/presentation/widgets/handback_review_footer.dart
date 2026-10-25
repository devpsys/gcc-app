import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/app_neutral_button.dart';
import 'package:gcc_app/core/widgets/app_primary_button.dart';

class HandbackReviewFooter extends StatelessWidget {
  const HandbackReviewFooter({
    required this.canApprove,
    required this.approving,
    required this.onSomethingWrong,
    required this.onApprove,
    super.key,
  });

  final bool canApprove;
  final bool approving;
  final VoidCallback onSomethingWrong;
  final VoidCallback onApprove;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.semanticColors;
    final scheme = Theme.of(context).colorScheme;
    final unavailable = l10n.dashboardActionUnavailable;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surface,
        border: Border(top: BorderSide(color: colors.border)),
      ),
      child: SafeArea(
        top: false,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.sizeOf(context).height * 0.35,
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md,
              AppSpacing.xs,
              AppSpacing.md,
              AppSpacing.xs,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Tooltip(
                    message: unavailable,
                    child: Text(
                      l10n.handbackCompareCheckout,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: colors.muted,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.xxs),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: AppNeutralButton(
                        label: l10n.handbackSomethingWrong,
                        onPressed: onSomethingWrong,
                        expand: true,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Expanded(
                      flex: 3,
                      child: AppPrimaryButton(
                        label: l10n.handbackApproveRelease,
                        onPressed: canApprove && !approving ? onApprove : null,
                        disabledReason: canApprove
                            ? null
                            : l10n.handbackApproveHint,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
