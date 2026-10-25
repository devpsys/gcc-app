import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/app_choice_chip.dart';
import 'package:gcc_app/core/widgets/app_destructive_button.dart';
import 'package:gcc_app/core/widgets/app_neutral_button.dart';
import 'package:gcc_app/core/widgets/app_sheet.dart';
import 'package:gcc_app/core/widgets/app_text_field.dart';
import 'package:gcc_app/features/booking/domain/handback_issue_reason.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_money.dart';
import 'package:gcc_app/l10n/app_localizations.dart';

class HandbackIssueResult {
  const HandbackIssueResult({
    required this.reason,
    required this.note,
    required this.photoCount,
    required this.claimAmount,
  });

  final HandbackIssueReason reason;
  final String note;
  final int photoCount;
  final int claimAmount;
}

Future<HandbackIssueResult?> showHandbackIssueSheet({
  required BuildContext context,
  required int maxClaim,
}) {
  return showAppSheet<HandbackIssueResult>(
    context: context,
    title: context.l10n.handbackIssueTitle,
    closeLabel: context.l10n.authClose,
    child: HandbackIssueSheet(maxClaim: maxClaim),
  );
}

class HandbackIssueSheet extends StatefulWidget {
  const HandbackIssueSheet({required this.maxClaim, super.key});

  final int maxClaim;

  @override
  State<HandbackIssueSheet> createState() => _HandbackIssueSheetState();
}

class _HandbackIssueSheetState extends State<HandbackIssueSheet> {
  HandbackIssueReason? _reason;
  final _note = TextEditingController();
  final _claim = TextEditingController();
  var _photos = 0;

  @override
  void dispose() {
    _note.dispose();
    _claim.dispose();
    super.dispose();
  }

  bool get _canSubmit =>
      _reason != null && _photos > 0 && _claimAmount <= widget.maxClaim;

  int get _claimAmount => int.tryParse(_claim.text.replaceAll(',', '')) ?? 0;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.semanticColors;
    final scheme = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        0,
        AppSpacing.md,
        AppSpacing.md,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: colors.warningContainer,
              borderRadius: BorderRadius.circular(AppRadii.button),
              border: Border.all(
                color: colors.heldFunds.withValues(alpha: 0.35),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.handbackIssueFreeze(fullNaira(widget.maxClaim)),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: colors.heldFunds,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxs),
                  Text(
                    l10n.handbackIssueFreezeHint,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: colors.heldFunds.withValues(alpha: 0.9),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            l10n.handbackIssueReason,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Wrap(
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            children: [
              for (final reason in HandbackIssueReason.values)
                AppChoiceChip(
                  label: _reasonLabel(l10n, reason),
                  selected: _reason == reason,
                  onSelected: (_) => setState(() => _reason = reason),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            l10n.handbackIssueNote,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          TextField(
            controller: _note,
            maxLines: 4,
            maxLength: 500,
            onChanged: (_) => setState(() {}),
            style: Theme.of(context).textTheme.bodyMedium,
            decoration: InputDecoration(
              hintText: l10n.handbackIssueNoteHint,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            l10n.handbackIssuePhotos,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          AppNeutralButton(
            label: _photos == 0
                ? l10n.handbackIssueAddPhotos
                : l10n.handbackIssuePhotoCount(_photos),
            icon: Icons.photo_camera_outlined,
            onPressed: _photos >= 6
                ? null
                : () => setState(() => _photos += 1),
            disabledReason: _photos >= 6 ? l10n.handbackIssuePhotosMax : null,
          ),
          const SizedBox(height: AppSpacing.xxs),
          Text(
            l10n.handbackIssuePhotosMax,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: colors.muted,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          AppTextField(
            label: l10n.handbackIssueClaim,
            controller: _claim,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            prefix: '₦ ',
            onChanged: (_) => setState(() {}),
            helperText: l10n.handbackIssueClaimHint(fullNaira(widget.maxClaim)),
          ),
          const SizedBox(height: AppSpacing.md),
          DecoratedBox(
            decoration: BoxDecoration(
              color: scheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(AppRadii.button),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.sm),
              child: Text(
                l10n.handbackIssueHonesty,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: colors.muted,
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.32,
                child: AppNeutralButton(
                  label: l10n.handbackIssueCancel,
                  onPressed: () => Navigator.of(context).pop(),
                  expand: true,
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              Expanded(
                child: AppDestructiveButton(
                  label: l10n.handbackIssueSubmit,
                  onPressed: _canSubmit
                      ? () => Navigator.of(context).pop(
                          HandbackIssueResult(
                            reason: _reason!,
                            note: _note.text.trim(),
                            photoCount: _photos,
                            claimAmount: _claimAmount,
                          ),
                        )
                      : null,
                  disabledReason: l10n.handbackIssueSubmitHint,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _reasonLabel(AppLocalizations l10n, HandbackIssueReason reason) {
    return switch (reason) {
      HandbackIssueReason.damageNotShown => l10n.handbackReasonDamageNotShown,
      HandbackIssueReason.damageOmitted => l10n.handbackReasonDamageOmitted,
      HandbackIssueReason.wrongMachine => l10n.handbackReasonWrongMachine,
    };
  }
}
