import 'package:flutter/material.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';

/// Small helper line that follows a control and explains the current choice.
///
/// The condition grade uses [icon] to render the tick the design draws beside
/// a chosen grade; the availability helper passes no icon and is set inside a
/// card instead.
class AssetHelperLine extends StatelessWidget {
  const AssetHelperLine({
    required this.text,
    this.icon,
    this.iconColor,
    super.key,
  });

  final String text;
  final IconData? icon;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final glyph = icon;
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.tight),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (glyph != null) ...[
            Icon(
              glyph,
              size: AppDimensions.iconSm,
              color: iconColor ?? scheme.onSurfaceVariant,
            ),
            const SizedBox(width: AppSpacing.xxs),
          ],
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodySmall
                  ?.copyWith(color: scheme.onSurfaceVariant),
            ),
          ),
        ],
      ),
    );
  }
}
