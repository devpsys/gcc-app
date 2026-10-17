import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/shell_center_action.dart';
import 'package:gcc_app/core/widgets/shell_destination.dart';

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({
    required this.destinations,
    required this.selectedIndex,
    required this.onDestinationSelected,
    this.centerAction,
    super.key,
  });

  final List<ShellDestination> destinations;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final ShellCenterAction? centerAction;

  @override
  Widget build(BuildContext context) {
    final center = centerAction;
    final barHeight = MediaQuery.textScalerOf(context)
        .scale(AppDimensions.navigationBarHeight);
    final height = barHeight < AppDimensions.navigationBarHeight
        ? AppDimensions.navigationBarHeight
        : barHeight;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(top: BorderSide(color: context.semanticColors.border)),
      ),
      child: SafeArea(
        top: false,
        child: center == null
            ? NavigationBar(
                height: height,
                selectedIndex: selectedIndex,
                onDestinationSelected: (index) {
                  if (!destinations[index].available) {
                    return;
                  }
                  onDestinationSelected(index);
                },
                destinations: [
                  for (final destination in destinations)
                    NavigationDestination(
                      icon: _badgedIcon(context, destination, destination.icon),
                      selectedIcon: _badgedIcon(
                        context,
                        destination,
                        destination.selectedIcon,
                      ),
                      label: destination.label,
                      enabled: destination.available,
                      tooltip: destination.available
                          ? null
                          : destination.unavailableReason,
                    ),
                ],
              )
            : _splitBar(context, center, height),
      ),
    );
  }

  Widget _splitBar(
    BuildContext context,
    ShellCenterAction center,
    double height,
  ) {
    final midpoint = destinations.length ~/ 2;
    final scheme = Theme.of(context).colorScheme;
    return SizedBox(
      height: height,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var index = 0; index < midpoint; index++)
                Expanded(child: _item(context, index)),
              const SizedBox(width: AppDimensions.navigationCenterAction),
              for (var index = midpoint; index < destinations.length; index++)
                Expanded(child: _item(context, index)),
            ],
          ),
          Positioned(
            top: -AppSpacing.sm,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [_centerButton(context, center, scheme)],
            ),
          ),
        ],
      ),
    );
  }

  Widget _badgedIcon(
    BuildContext context,
    ShellDestination destination,
    IconData icon, {
    Color? color,
    double? size,
  }) {
    final glyph = Icon(icon, color: color, size: size);
    if (destination.badgeCount <= 0) {
      return glyph;
    }
    return Badge(
      label: Text('${destination.badgeCount}'),
      backgroundColor: context.semanticColors.warning,
      child: glyph,
    );
  }

  Widget _item(BuildContext context, int index) {
    final destination = destinations[index];
    final selected = index == selectedIndex && destination.available;
    final scheme = Theme.of(context).colorScheme;
    final color = !destination.available
        ? scheme.outline
        : selected
        ? scheme.primary
        : scheme.onSurfaceVariant;
    final reason = destination.unavailableReason;
    final item = InkWell(
      onTap: destination.available ? () => onDestinationSelected(index) : null,
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (selected)
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: AppDimensions.borderWidth * 2,
                margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                decoration: BoxDecoration(
                  color: scheme.primary,
                  borderRadius: BorderRadius.circular(AppRadii.pill),
                ),
              ),
            ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              _badgedIcon(
                context,
                destination,
                selected ? destination.selectedIcon : destination.icon,
                color: color,
                size: AppDimensions.iconMd,
              ),
              Text(
                destination.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: color,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
    if (destination.available || reason == null) {
      return item;
    }
    return Tooltip(message: reason, child: item);
  }

  Widget _centerButton(
    BuildContext context,
    ShellCenterAction center,
    ColorScheme scheme,
  ) {
    final enabled = center.onPressed != null;
    final reason = center.disabledReason;
    final ring = CircleBorder(
      side: BorderSide(color: scheme.surface, width: AppSpacing.xxs),
    );
    final button = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox.square(
          dimension: AppDimensions.navigationCenterAction,
          child: Material(
            color: enabled ? scheme.primary : scheme.surfaceContainerHighest,
            shape: ring,
            elevation: 0,
            child: InkWell(
              customBorder: ring,
              onTap: center.onPressed,
              child: Icon(
                center.icon,
                color: enabled ? scheme.onPrimary : scheme.outline,
                size: AppDimensions.iconLg,
              ),
            ),
          ),
        ),
        Text(
          center.label,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: enabled ? scheme.primary : scheme.outline,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
    final labeled = Semantics(
      button: true,
      enabled: enabled,
      label: center.label,
      hint: enabled ? null : reason,
      child: button,
    );
    if (enabled || reason == null) {
      return labeled;
    }
    return Tooltip(message: reason, child: labeled);
  }
}
