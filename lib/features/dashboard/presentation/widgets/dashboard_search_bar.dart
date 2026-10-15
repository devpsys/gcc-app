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
    super.key,
  });

  final String hint;
  final String filtersLabel;
  final String disabledReason;
  final int filterCount;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    return ConstrainedBox(
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
                child: TextField(
                  enabled: false,
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: InputDecoration(
                    hintText: hint,
                    isCollapsed: true,
                    filled: false,
                    constraints: const BoxConstraints(),
                    contentPadding: EdgeInsets.zero,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                  ),
                ),
              ),
              Flexible(
                child: Tooltip(
                  message: disabledReason,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: TextButton.icon(
                      onPressed: null,
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
    );
  }
}
