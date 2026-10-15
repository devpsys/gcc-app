import 'package:flutter/material.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';

/// The `Scan` text action on the serial field.
///
/// Tapping it emits the intent to scan a serial barcode. No scanner
/// dependency is wired up yet, so the action is rendered but inert — the same
/// boundary the plan puts on camera, GPS and compression.
class AssetScanAction extends StatelessWidget {
  const AssetScanAction({required this.label, this.onPressed, super.key});

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelMedium
              ?.copyWith(color: scheme.primary, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
