import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/di/injection.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_theme.dart';
import 'package:gcc_app/core/widgets/app_scroll_behavior.dart';
import 'package:gcc_app/features/home/presentation/bloc/home_cubit.dart';
import 'package:gcc_app/features/home/presentation/bloc/home_state.dart';
import 'package:gcc_app/features/home/presentation/theme_mode_mapper.dart';
import 'package:gcc_app/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class GccApp extends StatelessWidget {
  const GccApp({super.key, this.homeCubit, this.router});

  final HomeCubit? homeCubit;
  final GoRouter? router;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = homeCubit ?? getIt<HomeCubit>();
        unawaited(cubit.load());
        return cubit;
      },
      child: BlocBuilder<HomeCubit, HomeState>(
        buildWhen: (previous, current) =>
            previous.themeMode != current.themeMode,
        builder: (context, state) {
          return MaterialApp.router(
            onGenerateTitle: (context) => context.l10n.appTitle,
            theme: AppTheme.light(),
            darkTheme: AppTheme.dark(),
            themeMode: themeModeFromPreference(state.themeMode),
            scrollBehavior: const AppScrollBehavior(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            routerConfig: router ?? getIt<GoRouter>(),
          );
        },
      ),
    );
  }
}
