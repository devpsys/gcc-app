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
import 'package:gcc_app/features/auth/domain/biometric_capability.dart';
import 'package:gcc_app/features/auth/presentation/biometric_status_copy.dart';
import 'package:gcc_app/features/auth/presentation/bloc/device_lock_cubit.dart';
import 'package:gcc_app/features/auth/presentation/bloc/device_lock_state.dart';
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
        body: BlocListener<DeviceLockCubit, DeviceLockState>(
          listenWhen: (previous, current) => current is DeviceLockRevoked,
          listener: (context, state) {
            if (state is! DeviceLockRevoked) {
              return;
            }
            GoRouter.maybeOf(context)?.go(state.signInLocation);
          },
          child: BlocBuilder<WalletCubit, WalletState>(
            builder: (context, state) {
              return switch (state) {
                WalletLoading() => const Center(child: AppLoadingIndicator()),
                WalletProfileReady(:final profile) when profile == null =>
                  ProfileUnavailable(
                    onOpenNotifications: () =>
                        GoRouter.maybeOf(context)
                            ?.push(RoutePaths.agentNotifications),
                  ),
                WalletProfileReady(
                  :final profile,
                  :final storage,
                  :final channels,
                ) =>
                  BlocBuilder<DeviceLockCubit, DeviceLockState>(
                    builder: (context, lockState) {
                      final copy = biometricStatusCopy(
                        l10n,
                        lockState.snapshot.capability,
                      );
                      final showBiometric = lockState is! DeviceLockLoading;
                      final available =
                          showBiometric &&
                          copy.available &&
                          lockState.snapshot.capability is BiometricAvailable;
                      return ProfilePage(
                        profile: profile!,
                        storageCategories: storage,
                        channels: channels,
                        biometricEnrolled: lockState.snapshot.enrolled,
                        biometricValue: showBiometric ? copy.value : null,
                        biometricDetail: showBiometric ? copy.detail : null,
                        onBiometricChanged: available
                            ? (enabled) {
                                final cubit = context.read<DeviceLockCubit>();
                                if (enabled) {
                                  cubit.enroll();
                                } else {
                                  cubit.disable();
                                }
                              }
                            : null,
                        onOpenLanguage: () => showAppLanguagePicker(
                          context: context,
                          selectedId: 'english',
                        ),
                        onOpenNotifications: () =>
                            GoRouter.maybeOf(context)
                                ?.push(RoutePaths.agentNotifications),
                        onSignOut: () =>
                            context.read<DeviceLockCubit>().signOut(),
                      );
                    },
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
      ),
    );
  }
}
