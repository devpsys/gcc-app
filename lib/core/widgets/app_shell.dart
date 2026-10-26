import 'package:flutter/material.dart';
import 'package:gcc_app/core/theme/app_breakpoints.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/app_bottom_navigation_bar.dart';
import 'package:gcc_app/core/widgets/shell_app_bar_style.dart';
import 'package:gcc_app/core/widgets/shell_center_action.dart';
import 'package:gcc_app/core/widgets/shell_destination.dart';
import 'package:gcc_app/core/widgets/shell_navigation_style.dart';
import 'package:go_router/go_router.dart';

class AppShell extends StatelessWidget {
  const AppShell({
    required this.title,
    required this.menuLabel,
    required this.destinations,
    required this.selectedLocation,
    required this.child,
    this.actions,
    this.leading,
    this.showAppBar = true,
    this.centerAction,
    this.navigationStyle = ShellNavigationStyle.drawer,
    this.appBarStyle = ShellAppBarStyle.surface,
    super.key,
  });

  final String title;
  final String menuLabel;
  final List<ShellDestination> destinations;
  final String selectedLocation;
  final Widget child;
  final List<Widget>? actions;
  final Widget? leading;
  final bool showAppBar;
  final ShellCenterAction? centerAction;

  /// Medium-breakpoint chrome. App B uses [ShellNavigationStyle.topTabs].
  final ShellNavigationStyle navigationStyle;

  /// Wallet (MOB-LSE-14) uses [ShellAppBarStyle.brand] for the mode chip.
  final ShellAppBarStyle appBarStyle;

  @override
  Widget build(BuildContext context) {
    assert(destinations.isNotEmpty, 'AppShell requires a destination.');
    return LayoutBuilder(
      builder: (context, constraints) {
        final selectedIndex = _selectedIndex();
        return switch (AppBreakpoints.sizeFor(constraints.maxWidth)) {
          AppWindowSize.compact => _compact(context, selectedIndex),
          AppWindowSize.medium => switch (navigationStyle) {
            ShellNavigationStyle.topTabs =>
              _mediumTopTabs(context, selectedIndex),
            ShellNavigationStyle.drawer => _medium(context, selectedIndex),
          },
          AppWindowSize.expanded ||
          AppWindowSize.large => _expanded(context, selectedIndex),
        };
      },
    );
  }

  Widget _compact(BuildContext context, int selectedIndex) {
    return Scaffold(
      appBar: _appBar(context),
      body: child,
      bottomNavigationBar: destinations.length < 2
          ? null
          : AppBottomNavigationBar(
              destinations: destinations,
              selectedIndex: selectedIndex,
              onDestinationSelected: (index) => _go(context, index),
              centerAction: centerAction,
            ),
    );
  }

  PreferredSizeWidget? _appBar(
    BuildContext context, {
    Widget? drawerLeading,
  }) {
    if (!showAppBar) {
      return null;
    }
    final scheme = Theme.of(context).colorScheme;
    final brand = appBarStyle == ShellAppBarStyle.brand;
    final onBrand = scheme.onSecondary;
    return AppBar(
      automaticallyImplyLeading: leading == null && drawerLeading == null,
      leading: leading ?? drawerLeading,
      title: Text(title),
      actions: actions,
      backgroundColor: brand ? scheme.secondary : null,
      foregroundColor: brand ? onBrand : null,
      iconTheme: brand ? IconThemeData(color: onBrand) : null,
      actionsIconTheme: brand ? IconThemeData(color: onBrand) : null,
      titleTextStyle: brand
          ? Theme.of(context).textTheme.titleLarge?.copyWith(
              color: onBrand,
              fontWeight: FontWeight.w700,
            )
          : null,
      shape: brand ? const Border() : null,
      elevation: brand ? 0 : null,
      scrolledUnderElevation: brand ? 0 : null,
    );
  }

  Widget _medium(BuildContext context, int selectedIndex) {
    return Scaffold(
      appBar: _appBar(
        context,
        drawerLeading: Builder(
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
                  enabled: destinations[index].available,
                  selected: index == selectedIndex,
                  leading: Icon(
                    index == selectedIndex
                        ? destinations[index].selectedIcon
                        : destinations[index].icon,
                  ),
                  title: Text(destinations[index].label),
                  subtitle:
                      destinations[index].available ||
                          destinations[index].unavailableReason == null
                      ? null
                      : Text(destinations[index].unavailableReason!),
                  onTap: destinations[index].available
                      ? () {
                          final navigator = Navigator.of(context);
                          if (navigator.canPop()) {
                            navigator.pop();
                          }
                          _go(context, index);
                        }
                      : null,
                ),
            ],
          ),
        ),
      ),
      body: child,
    );
  }

  Widget _mediumTopTabs(BuildContext context, int selectedIndex) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: _appBar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Material(
            color: scheme.surface,
            child: SizedBox(
              height: AppDimensions.topTabBarHeight,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                itemCount: destinations.length,
                separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.lg),
                itemBuilder: (context, index) {
                  final destination = destinations[index];
                  final selected = index == selectedIndex;
                  final label = destination.badgeCount > 0
                      ? '${destination.label} (${destination.badgeCount})'
                      : destination.label;
                  return InkWell(
                    onTap: destination.available
                        ? () => _go(context, index)
                        : null,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: selected
                                ? scheme.primary
                                : scheme.surface,
                            width: selected
                                ? AppDimensions.accentBorderWidth
                                : 0,
                          ),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          label,
                          style: Theme.of(context).textTheme.titleSmall
                              ?.copyWith(
                                color: selected
                                    ? scheme.primary
                                    : (destination.available
                                          ? scheme.onSurfaceVariant
                                          : scheme.onSurface.withValues(
                                              alpha: 0.38,
                                            )),
                                fontWeight: selected
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                              ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const Divider(height: AppDimensions.borderWidth),
          Expanded(child: child),
        ],
      ),
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
                  disabled: !destination.available,
                ),
            ],
          ),
          const VerticalDivider(width: AppDimensions.borderWidth),
          Expanded(
            child: Column(
              children: [
                _appBar(context) ?? const SizedBox.shrink(),
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
    final destination = destinations[index];
    if (!destination.available) {
      return;
    }
    final router = GoRouter.maybeOf(context);
    if (router == null) {
      return;
    }
    final current = GoRouterState.of(context).uri;
    final target = Uri.parse(destination.location);
    if (current.path == target.path && current.query == target.query) {
      return;
    }
    context.go(destination.location);
  }
}
