import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/core/widgets/status_chip.dart';
import 'package:gcc_app/features/dashboard/presentation/bloc/dashboard_snapshot.dart';

class SubmissionStatusRow extends StatelessWidget {
  const SubmissionStatusRow({
    required this.submission,
    required this.disabledReason,
    super.key,
  });

  final DashboardSubmission submission;
  final String disabledReason;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final amount = submission.amount;
    final status = switch (submission.status) {
      'synced' => l10n.dashboardSubmissionSynced,
      'approved' =>
        amount == null
            ? l10n.dashboardSubmissionApproved
            : l10n.dashboardSubmissionApprovedAmount(amount),
      _ => l10n.dashboardSubmissionQueued,
    };
    final tone = switch (submission.status) {
      'synced' || 'approved' => StatusTone.success,
      _ => StatusTone.info,
    };
    return Tooltip(
      message: disabledReason,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minHeight: AppDimensions.navigationBarHeight,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.xs,
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      submission.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      submission.detail,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.mono(
                        Theme.of(context).textTheme.bodySmall!
                            .copyWith(color: scheme.onSurfaceVariant),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              StatusChip(label: status, tone: tone),
            ],
          ),
        ),
      ),
    );
  }
}
