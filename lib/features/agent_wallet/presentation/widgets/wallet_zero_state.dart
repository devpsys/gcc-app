import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/core/widgets/app_primary_button.dart';

/// The new-agent frame: nothing verified yet.
class WalletZeroState extends StatelessWidget {
  const WalletZeroState({this.onStartCapturing, super.key});

  final VoidCallback? onStartCapturing;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l10n.walletZeroTitle,
          style: Theme.of(context).textTheme.titleMedium
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: AppSpacing.xxs),
        Text(
          l10n.walletZeroSubtitle,
          style: Theme.of(context).textTheme.titleMedium
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: AppSpacing.xxs),
        Text(
          l10n.walletZeroBody('₦5,000'),
          style: Theme.of(context).textTheme.bodyMedium
              ?.copyWith(color: scheme.onSurfaceVariant),
        ),
        const SizedBox(height: AppSpacing.md),
        AppPrimaryButton(
          label: l10n.walletZeroCta,
          expand: true,
          onPressed: onStartCapturing,
        ),
        const SizedBox(height: AppSpacing.sm),
        DecoratedBox(
          decoration: BoxDecoration(
            color: colors.infoContainer,
            borderRadius: BorderRadius.circular(AppRadii.cardLarge),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.sm),
            child: Row(
              children: [
                Icon(
                  Icons.insights_outlined,
                  size: AppSpacing.md,
                  color: colors.info,
                ),
                const SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: Text(
                    l10n.walletZeroBenchmark('₦21,500'),
                    style: Theme.of(context).textTheme.bodySmall
                        ?.copyWith(color: colors.info),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          l10n.walletNoRunsYet,
          style: Theme.of(context).textTheme.titleSmall
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: AppSpacing.xxs),
        Text(
          l10n.walletNextRun('Mon 12 Oct · 09:00'),
          style: AppTextStyles.mono(
            Theme.of(context).textTheme.labelSmall!
                .copyWith(color: scheme.onSurfaceVariant),
          ),
        ),
      ],
    );
  }
}
