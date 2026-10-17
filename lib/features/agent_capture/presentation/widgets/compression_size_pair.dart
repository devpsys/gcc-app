import 'package:flutter/material.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';

/// `30.4 MB → 6.2 MB` with the original struck through.
///
/// The strikethrough is what makes the saving legible at a glance; without it
/// the pair reads as two unrelated numbers.
class CompressionSizePair extends StatelessWidget {
  const CompressionSizePair({
    required this.before,
    required this.after,
    super.key,
  });

  /// Size before compression.
  final String before;

  /// Size after compression.
  final String after;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final small = Theme.of(context).textTheme.labelSmall!;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          before,
          style: AppTextStyles.mono(
            small.copyWith(
              color: scheme.onSurfaceVariant,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        ),
        Text(
          ' → ',
          style: AppTextStyles.mono(
            small.copyWith(color: scheme.onSurfaceVariant),
          ),
        ),
        Text(
          after,
          style: AppTextStyles.mono(
            small.copyWith(
              color: scheme.onSurface,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
