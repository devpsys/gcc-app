import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';

/// Anti-fraud notice shown once a capture holds more than one asset.
///
/// The bounty is paid per shop, not per asset. Stating it here is deliberate —
/// it stops an agent adding redundant assets hoping for more money, which is
/// the abuse the design's notice exists to prevent.
class AssetBountyNotice extends StatelessWidget {
  const AssetBountyNotice({required this.count, super.key});

  final int count;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final style = Theme.of(context).textTheme.bodySmall!
        .copyWith(color: scheme.onSurfaceVariant);
    final countText = context.l10n.captureAssetCountLabel(count);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppRadii.button),
        border: Border.all(color: context.semanticColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Text.rich(
          TextSpan(
            style: style,
            children: [
              TextSpan(
                text: countText,
                style: style.copyWith(fontWeight: FontWeight.w700),
              ),
              TextSpan(text: ' '),
              TextSpan(text: context.l10n.captureAssetBountyAmount),
            ],
          ),
        ),
      ),
    );
  }
}
