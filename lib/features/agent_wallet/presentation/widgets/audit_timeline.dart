import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/audit_event.dart';
import 'package:gcc_app/features/agent_wallet/presentation/widgets/audit_timeline_row.dart';

/// A submission's audit trail.
///
/// Every step keeps its row even when it has not happened, because an agent
/// chasing a delay needs to see what is still outstanding. A rejected step and
/// a not-applicable step look different on purpose: one is a failure, the other
/// never will apply.
class AuditTimeline extends StatelessWidget {
  const AuditTimeline({required this.events, super.key});

  final List<AuditEvent> events;

  @override
  Widget build(BuildContext context) {
    final colors = context.semanticColors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.bountyAuditTimeline.toUpperCase(),
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        for (var i = 0; i < events.length; i++)
          AuditTimelineRow(
            event: events[i],
            isFirst: i == 0,
            isLast: i == events.length - 1,
            connectorColor: colors.border,
          ),
      ],
    );
  }
}
