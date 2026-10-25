import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';

class DashboardSearchBar extends StatelessWidget {
  const DashboardSearchBar({
    required this.hint,
    required this.filtersLabel,
    required this.disabledReason,
    this.filterCount = 0,
    this.onOpen,
    this.onFilters,
    super.key,
  });

  final String hint;
  final String filtersLabel;
  final String disabledReason;
  final int filterCount;
  final VoidCallback? onOpen;
  final VoidCallback? onFilters;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: onOpen,
        borderRadius: BorderRadius.circular(AppRadii.input),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: AppDimensions.inputHeight),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadii.input),
              border: Border.all(color: colors.border),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    size: AppDimensions.iconMd,
                    color: scheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Expanded(
                    child: Text(
                      hint,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Tooltip(
                      message: onFilters == null ? disabledReason : '',
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: TextButton.icon(
                          onPressed: onFilters,
                          style: TextButton.styleFrom(
                            foregroundColor: scheme.onSurface,
                            disabledForegroundColor: scheme.onSurface,
                            visualDensity: VisualDensity.compact,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          icon: Icon(Icons.tune, size: AppDimensions.iconSm),
                          label: Badge(
                            isLabelVisible: filterCount > 0,
                            label: Text('$filterCount'),
                            backgroundColor: scheme.primaryContainer,
                            textColor: scheme.onPrimaryContainer,
                            child: Text(filtersLabel),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
