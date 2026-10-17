import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/app_primary_button.dart';

// The sticky "start the next stop" footer.
///
/// Only shown while there is a next stop to walk to — its whole job is to
/// turn the work list into a route.
class NextStopBar extends StatelessWidget {
  const NextStopBar({required this.label, this.onTap, super.key});

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(top: BorderSide(color: context.semanticColors.border)),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.md,
          AppSpacing.sm,
          AppSpacing.md,
          AppSpacing.md,
        ),
        child: SizedBox(
          height: AppDimensions.wizardBarHeight,
          child: AppPrimaryButton(label: label, expand: true, onPressed: onTap),
        ),
      ),
    );
  }
}
