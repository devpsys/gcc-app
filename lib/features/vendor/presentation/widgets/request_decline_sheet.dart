import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/app_destructive_button.dart';
import 'package:gcc_app/core/widgets/app_secondary_button.dart';
import 'package:gcc_app/features/vendor/domain/decline_request_ready.dart';
import 'package:gcc_app/features/vendor/domain/vendor_decline_reason.dart';

typedef RequestDeclineResult = ({VendorDeclineReason reason, String note});

class RequestDeclineSheet extends StatefulWidget {
  const RequestDeclineSheet({super.key});

  @override
  State<RequestDeclineSheet> createState() => _RequestDeclineSheetState();
}

class _RequestDeclineSheetState extends State<RequestDeclineSheet> {
  VendorDeclineReason? _reason;
  String _note = '';

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final ready = declineRequestReady(reason: _reason, note: _note);
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        0,
        AppSpacing.md,
        AppSpacing.md,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.requestDeclineReason,
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const SizedBox(height: AppSpacing.xs),
          Wrap(
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            children: [
              for (final reason in VendorDeclineReason.values)
                ChoiceChip(
                  label: Text(_label(context, reason)),
                  selected: _reason == reason,
                  onSelected: (_) => setState(() => _reason = reason),
                  showCheckmark: false,
                  selectedColor: scheme.primaryContainer,
                  labelStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: _reason == reason
                        ? scheme.primary
                        : scheme.onSurface,
                  ),
                  side: BorderSide(
                    color: _reason == reason ? scheme.primary : scheme.outline,
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          TextField(
            minLines: 3,
            maxLines: 3,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              labelText: l10n.requestReasonNote,
              helperText: l10n.requestReasonNoteHint,
            ),
            onChanged: (value) => setState(() => _note = value),
          ),
          const SizedBox(height: AppSpacing.sm),
          DecoratedBox(
            decoration: BoxDecoration(
              color: scheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(AppRadii.card),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.sm),
              child: Text(
                l10n.requestDeclineNotice,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: AppSecondaryButton(
                  label: l10n.catalogCancel,
                  expand: false,
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: AppDestructiveButton(
                  label: l10n.requestDecline,
                  expand: false,
                  filled: true,
                  disabledReason: l10n.requestChooseReason,
                  onPressed: ready
                      ? () =>
                            Navigator.of(context)
                                .pop((reason: _reason!, note: _note.trim()))
                      : null,
                ),
              ),
            ],
          ),
          if (!ready) ...[
            const SizedBox(height: AppSpacing.xxs),
            Text(
              l10n.requestChooseReason,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelSmall
                  ?.copyWith(color: scheme.onSurfaceVariant),
            ),
          ],
        ],
      ),
    );
  }

  String _label(BuildContext context, VendorDeclineReason reason) {
    final l10n = context.l10n;
    return switch (reason) {
      VendorDeclineReason.unavailable => l10n.requestReasonUnavailable,
      VendorDeclineReason.rate => l10n.requestReasonRate,
      VendorDeclineReason.area => l10n.requestReasonArea,
      VendorDeclineReason.maintenance => l10n.requestReasonMaintenance,
      VendorDeclineReason.other => l10n.requestReasonOther,
    };
  }
}
