import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';

// A hairline rule used between the filter bar and the list.
class ShopListDivider extends StatelessWidget {
  const ShopListDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSpacing.xxs,
      child: ColoredBox(color: context.semanticColors.border),
    );
  }
}
