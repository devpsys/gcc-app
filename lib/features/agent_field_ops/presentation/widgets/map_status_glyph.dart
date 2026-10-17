import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';

/// The leading glyph on a map sheet row.
///
/// A tick for verified, the agent's monogram for their own shops, and a hollow
/// ring for a lead. Shape as well as colour, so a scan works without colour.
class MapStatusGlyph extends StatelessWidget {
  const MapStatusGlyph({
    required this.verified,
    required this.lead,
    required this.mine,
    super.key,
  });

  final bool verified;
  final bool lead;
  final bool mine;

  /// The monogram the design puts on an agent's own pins and rows.
  static const String agentMonogram = 'IM';

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: verified
            ? colors.successContainer
            : lead
            ? scheme.surfaceContainerHighest
            : scheme.onSurface,
        shape: BoxShape.circle,
        border: lead ? Border.all(color: scheme.outline) : null,
      ),
      child: SizedBox.square(
        dimension: AppSpacing.xl,
        child: Center(
          child: lead
              ? Icon(
                  Icons.circle_outlined,
                  size: AppSpacing.md,
                  color: scheme.onSurfaceVariant,
                )
              : Text(
                  verified ? '✓' : agentMonogram,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: verified ? colors.success : scheme.surface,
                    fontWeight: FontWeight.w700,
                  ),
                ),
        ),
      ),
    );
  }
}
