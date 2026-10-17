import 'package:flutter/material.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';

// The rounded container used for the "all markets / all status" filter row.
class ShopFilterRow extends StatelessWidget {
  const ShopFilterRow({required this.children, super.key});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadii.pill),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.tight),
        child: Row(
          children: [
            for (final child in children) Expanded(child: Center(child: child)),
          ],
        ),
      ),
    );
  }
}
