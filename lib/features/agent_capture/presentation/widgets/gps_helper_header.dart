import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';

/// Header shared by every view in the GPS helper: a close action, a centred
/// title and a matching spacer so the title stays optically centred.
class GpsHelperHeader extends StatelessWidget {
  const GpsHelperHeader({
    required this.title,
    required this.onClose,
    super.key,
  });

  final String title;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          bottom: BorderSide(color: context.semanticColors.border),
        ),
      ),
      child: SizedBox(
        height: AppDimensions.topBarHeight,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
          child: Row(
            children: [
              IconButton(
                tooltip: l10n.gpsHelperClose,
                onPressed: onClose,
                icon: const Icon(Icons.close),
                iconSize: AppDimensions.iconLg,
              ),
              Expanded(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(width: AppDimensions.minTouchTarget),
            ],
          ),
        ),
      ),
    );
  }
}
