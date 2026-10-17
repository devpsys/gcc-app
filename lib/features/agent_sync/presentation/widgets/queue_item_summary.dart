import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/features/agent_sync/presentation/widgets/queue_detail_card.dart';
import 'package:gcc_app/features/agent_sync/presentation/widgets/queue_field_row.dart';

/// The fields a queued capture actually has.
///
/// Used when the submission is still on the device and has not failed, so the
/// failed and conflict frames — which talk about timeouts and duplicate shops —
/// would be claiming something that has not happened.
class QueueItemSummary extends StatelessWidget {
  const QueueItemSummary({
    required this.reference,
    required this.shopName,
    required this.owner,
    required this.location,
    required this.capturedAt,
    super.key,
  });

  final String reference;
  final String shopName;
  final String owner;
  final String location;
  final String capturedAt;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: Text(reference), backgroundColor: scheme.surface),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          Text(
            l10n.itemTitle,
            style: Theme.of(context).textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: AppSpacing.md),
          QueueDetailCard(
            title: l10n.itemCaptureData,
            children: [
              QueueFieldRow(label: l10n.itemLabelShop, value: shopName),
              if (owner.isNotEmpty)
                QueueFieldRow(label: l10n.itemLabelOwner, value: owner),
              if (location.isNotEmpty)
                QueueFieldRow(label: l10n.itemLabelLocation, value: location),
              QueueFieldRow(label: l10n.itemLabelCaptured, value: capturedAt),
            ],
          ),
        ],
      ),
    );
  }
}
