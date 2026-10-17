import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/audit_event.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/audit_event_state.dart';

/// One step in the timeline, with its connector to the next.
class AuditTimelineRow extends StatelessWidget {
  const AuditTimelineRow({
    required this.event,
    required this.isFirst,
    required this.isLast,
    required this.connectorColor,
    super.key,
  });

  final AuditEvent event;
  final bool isFirst;
  final bool isLast;
  final Color connectorColor;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    final (glyph, tone) = switch (event.state) {
      AuditEventState.done => (Icons.check, colors.success),
      AuditEventState.pending => (Icons.more_horiz, scheme.onSurfaceVariant),
      AuditEventState.rejected => (Icons.close, colors.danger),
      AuditEventState.notApplicable => (Icons.remove, scheme.outline),
    };

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: event.state == AuditEventState.pending
                      ? scheme.surfaceContainerHighest
                      : tone,
                  shape: BoxShape.circle,
                ),
                child: SizedBox.square(
                  dimension: AppSpacing.xl,
                  child: Icon(
                    glyph,
                    size: AppSpacing.sm,
                    color: scheme.surface,
                  ),
                ),
              ),
              if (!isLast)
                Expanded(child: Container(width: 2, color: connectorColor)),
            ],
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    event.label,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: event.state == AuditEventState.notApplicable
                          ? scheme.onSurfaceVariant
                          : scheme.onSurface,
                    ),
                  ),
                  Text(
                    event.detail,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: event.state == AuditEventState.rejected
                          ? colors.danger
                          : scheme.onSurfaceVariant,
                    ),
                  ),
                  if (event.at.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(
                        event.at,
                        style: AppTextStyles.mono(
                          Theme.of(context).textTheme.labelSmall!
                              .copyWith(color: scheme.onSurfaceVariant),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
