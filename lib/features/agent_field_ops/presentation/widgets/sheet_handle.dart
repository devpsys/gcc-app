import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/map_sheet_detent.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';

/// The drag handle, which is also the detent control.
///
/// Made wide enough to hit with one thumb in the field, and labelled so the
/// gesture is discoverable rather than a hidden drag.
class SheetHandle extends StatelessWidget {
  const SheetHandle({required this.detent, this.onTap, super.key});

  final MapSheetDetent detent;
  final ValueChanged<MapSheetDetent>? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final other = detent == MapSheetDetent.half
        ? MapSheetDetent.full
        : MapSheetDetent.half;

    return Semantics(
      button: true,
      label: context.l10n.mapLegend,
      child: InkWell(
        onTap: onTap == null ? null : () => onTap!(other),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
          child: Center(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: scheme.outlineVariant,
                borderRadius: BorderRadius.circular(AppRadii.micro),
              ),
              child: const SizedBox(
                width: AppDimensions.sheetHandleWidth,
                height: AppDimensions.sheetHandleHeight,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
