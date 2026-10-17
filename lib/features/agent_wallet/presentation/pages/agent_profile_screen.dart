import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/router/route_paths.dart';
import 'package:gcc_app/core/widgets/app_empty_state.dart';
import 'package:gcc_app/core/widgets/app_loading_indicator.dart';
import 'package:gcc_app/core/widgets/language_picker_sheet.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/wallet_cubit.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/wallet_state.dart';
import 'package:gcc_app/features/agent_wallet/presentation/pages/profile_page.dart';
import 'package:gcc_app/features/agent_wallet/presentation/widgets/profile_unavailable.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/agent_shell.dart';
import 'package:go_router/go_router.dart';

/// The routed agent profile.
///
/// The profile is not one of the five agent tabs — the designs reach it from
/// the Today header — so no tab is highlighted. It still carries the
/// navigation. The route provides [WalletCubit].
class AgentProfileScreen extends StatelessWidget {
  const AgentProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AgentShell(
      selectedLocation: RoutePaths.agentProfile,
      title: l10n.profileTitle,
      child: Scaffold(
        body: BlocBuilder<WalletCubit, WalletState>(
          builder: (context, state) {
            return switch (state) {
              WalletLoading() => const Center(child: AppLoadingIndicator()),
              WalletProfileReady(:final profile) when profile == null =>
                ProfileUnavailable(
                  onOpenNotifications: () =>
                      GoRouter.maybeOf(context)
                          ?.push(RoutePaths.agentNotifications),
                ),
              WalletProfileReady(:final profile, :final storage) => ProfilePage(
                profile: profile!,
                storageCategories: storage,
                onOpenLanguage: () => showAppLanguagePicker(
                  context: context,
                  selectedId: 'english',
                ),
                onOpenNotifications: () =>
                    GoRouter.maybeOf(context)
                        ?.push(RoutePaths.agentNotifications),
              ),
              WalletFailed() => AppEmptyState(
                icon: Icons.cloud_off,
                title: l10n.walletLoadFailed,
                actionLabel: l10n.dashboardRetry,
                onAction: () => context.read<WalletCubit>().loadProfile(),
              ),
              _ => const Center(child: AppLoadingIndicator()),
            };
          },
        ),
      ),
    );
  }
}
