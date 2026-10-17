import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/features/agent_capture/presentation/bloc/media_pipeline.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/compression_option_row.dart';

/// The three compression targets the agent can pick between.
///
/// Defaulting to the smallest option is deliberate: it is the only one that
/// finishes on a field connection, and the design marks it `Recommended`.
class CompressionQualitySelector extends StatelessWidget {
  const CompressionQualitySelector({
    required this.selected,
    this.onChanged,
    super.key,
  });

  final CompressionQuality selected;
  final ValueChanged<CompressionQuality>? onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final options = <CompressionOption>[
      CompressionOption(
        quality: CompressionQuality.smallest,
        sizeLabel: '5.2 MB',
        durationLabel: l10n.compressApproxOn3g('1 min 40 s'),
        recommended: true,
      ),
      CompressionOption(
        quality: CompressionQuality.balanced,
        sizeLabel: '8.0 MB',
        durationLabel: l10n.compressApproxOn3g('2 min 50 s'),
      ),
      CompressionOption(
        quality: CompressionQuality.original,
        sizeLabel: '30.4 MB',
        durationLabel: l10n.compressApproxOn3g('10 min'),
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.compressQualityHeading.toUpperCase(),
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSpacing.tight),
        DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(AppRadii.dialog),
            border: Border.all(color: context.semanticColors.border),
          ),
          child: Column(
            children: [
              for (var index = 0; index < options.length; index++) ...[
                if (index > 0)
                  Divider(
                    height: AppDimensions.borderWidth,
                    color: context.semanticColors.border,
                  ),
                CompressionOptionRow(
                  option: options[index],
                  selected: options[index].quality == selected,
                  onTap: () => onChanged?.call(options[index].quality),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
