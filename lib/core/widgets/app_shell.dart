import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_breakpoints.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/shell_destination.dart';
import 'package:go_router/go_router.dart';

class AppShell extends StatelessWidget {
  const AppShell({
    required this.title,
    required this.menuLabel,
    required this.destinations,
    required this.selectedLocation,
    required this.child,
    super.key,
  });

  final String title;
  final String menuLabel;
  final List<ShellDestination> destinations;
  final String selectedLocation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    assert(destinations.isNotEmpty, 'AppShell requires a destination.');
    return LayoutBuilder(
      builder: (context, constraints) {
        final selectedIndex = _selectedIndex();
        return switch (AppBreakpoints.sizeFor(constraints.maxWidth)) {
          AppWindowSize.compact => _compact(context, selectedIndex),
          AppWindowSize.medium => _medium(context, selectedIndex),
          AppWindowSize.expanded ||
          AppWindowSize.large => _expanded(context, selectedIndex),
        };
      },
    );
  }

  Widget _compact(BuildContext context, int selectedIndex) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false, title: Text(title)),
      body: child,
      bottomNavigationBar: destinations.length < 2
          ? null
          : DecoratedBox(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: context.semanticColors.border),
                ),
              ),
              child: NavigationBar(
                selectedIndex: selectedIndex,
                onDestinationSelected: (index) => _go(context, index),
                destinations: [
                  for (final destination in destinations)
                    NavigationDestination(
                      icon: Icon(destination.icon),
                      selectedIcon: Icon(destination.selectedIcon),
                      label: destination.label,
                    ),
                ],
              ),
            ),
    );
  }

  Widget _medium(BuildContext context, int selectedIndex) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: Builder(
          builder: (context) {
            return IconButton(
              tooltip: menuLabel,
              icon: const Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openDrawer(),
            );
          },
        ),
      ),
      drawer: Drawer(
        width: AppDimensions.navigationRailWidth,
        child: SafeArea(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              for (var index = 0; index < destinations.length; index++)
                ListTile(
                  selected: index == selectedIndex,
                  leading: Icon(
                    index == selectedIndex
                        ? destinations[index].selectedIcon
                        : destinations[index].icon,
                  ),
                  title: Text(destinations[index].label),
                  onTap: () {
                    final navigator = Navigator.of(context);
                    if (navigator.canPop()) {
                      navigator.pop();
                    }
                    _go(context, index);
                  },
                ),
            ],
          ),
        ),
      ),
      body: child,
    );
  }

  Widget _expanded(BuildContext context, int selectedIndex) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            extended: true,
            minExtendedWidth: AppDimensions.navigationRailWidth,
            selectedIndex: selectedIndex,
            groupAlignment: -1,
            onDestinationSelected: (index) => _go(context, index),
            labelType: NavigationRailLabelType.none,
            leading: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            ),
            destinations: [
              for (final destination in destinations)
                NavigationRailDestination(
                  icon: Icon(destination.icon),
                  selectedIcon: Icon(destination.selectedIcon),
                  label: Text(destination.label),
                ),
            ],
          ),
          const VerticalDivider(width: AppDimensions.borderWidth),
          Expanded(
            child: Column(
              children: [
                AppBar(automaticallyImplyLeading: false, title: Text(title)),
                Expanded(child: child),
              ],
            ),
          ),
        ],
      ),
    );
  }

  int _selectedIndex() {
    final index = destinations.indexWhere(
      (destination) => destination.location == selectedLocation,
    );
    return index < 0 ? 0 : index;
  }

  void _go(BuildContext context, int index) {
    final location = destinations[index].location;
    if (location == selectedLocation) {
      return;
    }
    context.go(location);
  }
}
