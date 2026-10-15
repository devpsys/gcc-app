import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/asset_reference_label.dart';

/// Heading for one of the asset step's lettered sections.
///
/// The design draws a small uppercase eyebrow over a hairline rule, with an
/// optional monospace reference on the trailing edge.
class AssetSectionHeading extends StatelessWidget {
  const AssetSectionHeading({required this.title, this.reference, super.key});

  final String title;
  final String? reference;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xxs),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: context.semanticColors.border),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.xxs),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title.toUpperCase(),
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: scheme.onSurfaceVariant,
                    fontWeight: FontWeight.w700,
                    letterSpacing: AppTextStyles.eyebrowLetterSpacing,
                  ),
                ),
              ),
              if (reference != null) AssetReferenceLabel(reference: reference!),
            ],
          ),
        ),
      ),
    );
  }
}
