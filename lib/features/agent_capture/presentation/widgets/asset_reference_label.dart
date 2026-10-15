import 'package:flutter/material.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';

/// Monospace reference shown beside the in-progress asset, e.g. `AST-0912`.
class AssetReferenceLabel extends StatelessWidget {
  const AssetReferenceLabel({required this.reference, super.key});

  final String reference;

  @override
  Widget build(BuildContext context) {
    return Text(
      reference,
      style: AppTextStyles.mono(
        Theme.of(context).textTheme.labelSmall!
            .copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
      ),
    );
  }
}
