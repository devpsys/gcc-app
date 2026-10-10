import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/router/route_paths.dart';
import 'package:gcc_app/core/widgets/app_loading_indicator.dart';
import 'package:gcc_app/core/widgets/app_shell.dart';
import 'package:gcc_app/core/widgets/shell_destination.dart';
import 'package:gcc_app/features/home/presentation/bloc/home_cubit.dart';
import 'package:gcc_app/features/home/presentation/bloc/home_state.dart';
import 'package:gcc_app/features/home/presentation/widgets/home_failure_content.dart';
import 'package:gcc_app/features/home/presentation/widgets/home_ready_content.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AppShell(
      title: l10n.appTitle,
      menuLabel: l10n.openNavigationMenu,
      selectedLocation: RoutePaths.home,
      destinations: [
        ShellDestination(
          label: l10n.homeTitle,
          icon: Icons.home_outlined,
          selectedIcon: Icons.home,
          location: RoutePaths.home,
        ),
      ],
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return switch (state) {
            HomeLoading() => const AppLoadingIndicator(),
            HomeReady(
              :final themeMode,
              :final environment,
              :final apiConfigured,
            ) =>
              HomeReadyContent(
                themeMode: themeMode,
                environment: environment,
                apiConfigured: apiConfigured,
              ),
            HomeSaveFailed(
              :final themeMode,
              :final environment,
              :final apiConfigured,
            ) =>
              HomeReadyContent(
                themeMode: themeMode,
                environment: environment,
                apiConfigured: apiConfigured,
                errorMessage: l10n.themeSaveFailed,
              ),
            HomeFailure() => const HomeFailureContent(),
          };
        },
      ),
    );
  }
}
