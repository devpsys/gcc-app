import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';

/// The borderless reference list on the terminal screen.
class SubmissionDetailList extends StatelessWidget {
  const SubmissionDetailList({
    required this.reference,
    required this.captured,
    required this.assets,
    required this.media,
    required this.bounty,
    required this.queued,
    super.key,
  });

  final String reference;
  final String captured;
  final String assets;
  final String media;
  final String bounty;
  final bool queued;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;

    Widget row(String label, String value, {bool mono = false}) => Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium
                  ?.copyWith(color: scheme.onSurfaceVariant),
            ),
          ),
          Text(
            value,
            style: mono
                ? AppTextStyles.mono(
                    Theme.of(context).textTheme.bodyMedium!
                        .copyWith(color: scheme.onSurface),
                  )
                : Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: scheme.onSurface,
                    fontWeight: FontWeight.w500,
                  ),
          ),
        ],
      ),
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: colors.border),
        borderRadius: BorderRadius.circular(AppRadii.dialog),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            row(l10n.queuedLabelReference, reference, mono: true),
            row(l10n.queuedLabelCaptured, captured, mono: true),
            row(l10n.queuedLabelAssets, assets),
            row(l10n.queuedLabelMedia, media, mono: true),
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.xxs),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      l10n.queuedLabelBounty,
                      style: Theme.of(context).textTheme.bodyMedium
                          ?.copyWith(color: scheme.onSurfaceVariant),
                    ),
                  ),
                  Text(
                    bounty,
                    style: AppTextStyles.tabular(
                      Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: scheme.onSurface,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Pending is a warning wash with no lock: the bounty is not held.
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.xs,
                  vertical: AppSpacing.xxs / 2,
                ),
                decoration: BoxDecoration(
                  color: colors.warningContainer,
                  borderRadius: BorderRadius.circular(AppRadii.input),
                ),
                child: Text(
                  l10n.queuedPendingVerification,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: colors.warning,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            if (queued) ...[
              const SizedBox(height: AppSpacing.xs),
              Text(
                l10n.compressDraftSynced('SUB-2204'),
                style: AppTextStyles.mono(
                  Theme.of(context).textTheme.labelSmall!
                      .copyWith(color: scheme.onSurfaceVariant),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
