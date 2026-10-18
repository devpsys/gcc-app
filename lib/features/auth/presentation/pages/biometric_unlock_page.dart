import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/app_loading_indicator.dart';
import 'package:gcc_app/core/widgets/app_notice_panel.dart';
import 'package:gcc_app/features/auth/domain/biometric_capability.dart';
import 'package:gcc_app/features/auth/presentation/biometric_status_copy.dart';
import 'package:gcc_app/features/auth/presentation/bloc/device_lock_cubit.dart';
import 'package:gcc_app/features/auth/presentation/bloc/device_lock_state.dart';
import 'package:gcc_app/features/auth/presentation/widgets/auth_screen_scaffold.dart';
import 'package:gcc_app/features/auth/presentation/widgets/biometric_unlock_action.dart';
import 'package:gcc_app/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class BiometricUnlockPage extends StatelessWidget {
  const BiometricUnlockPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocConsumer<DeviceLockCubit, DeviceLockState>(
      listenWhen: (previous, current) =>
          current is DeviceLockUnlocked || current is DeviceLockRevoked,
      listener: (context, state) {
        final router = GoRouter.maybeOf(context);
        if (router == null) {
          return;
        }
        switch (state) {
          case DeviceLockUnlocked(:final homeLocation):
            router.go(homeLocation);
          case DeviceLockRevoked(:final signInLocation):
            router.go(signInLocation);
          default:
            break;
        }
      },
      builder: (context, state) {
        if (state is DeviceLockLoading) {
          return const Scaffold(body: Center(child: AppLoadingIndicator()));
        }
        final cubit = context.read<DeviceLockCubit>();
        final busy = state is DeviceLockBusy;
        final lost =
            state is DeviceLockFailed &&
            state.failure is BiometricEnrollmentLostFailure;
        final capability = state.snapshot.capability;
        final canUnlock =
            !lost &&
            state.snapshot.enrolled &&
            capability is BiometricAvailable;
        return AuthScreenScaffold(
          title: biometricUnlockTitle(l10n, capability),
          subtitle: Text(
            l10n.biometricEnrollBody,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (lost) ...[
                AppNoticePanel(
                  icon: Icons.fingerprint,
                  title: l10n.biometricEnrollmentLostTitle,
                  message: l10n.biometricEnrollmentLost,
                ),
                const SizedBox(height: AppSpacing.md),
              ],
              if (state is DeviceLockFailed &&
                  state.failure is! BiometricEnrollmentLostFailure &&
                  state.failure is! BiometricLockoutFailure &&
                  state.failure is! CancelledFailure) ...[
                Text(
                  l10n.biometricGenericFailure,
                  style: Theme.of(context).textTheme.bodyMedium
                      ?.copyWith(color: context.semanticColors.danger),
                ),
                const SizedBox(height: AppSpacing.md),
              ],
              BiometricUnlockAction(
                unlockLabel: l10n.biometricUnlockAction,
                codeLabel: l10n.biometricUseCode,
                busy: busy,
                onUnlock: canUnlock ? cubit.unlock : null,
                unlockDisabledReason: _disabledReason(l10n, state),
                onUseCode: cubit.useVerificationCode,
              ),
            ],
          ),
          footer: const SizedBox.shrink(),
        );
      },
    );
  }

  String? _disabledReason(AppLocalizations l10n, DeviceLockState state) {
    if (state is DeviceLockFailed && state.failure is BiometricLockoutFailure) {
      return l10n.biometricUnavailableLockout;
    }
    if (state is DeviceLockFailed &&
        state.failure is BiometricEnrollmentLostFailure) {
      return l10n.biometricEnrollmentLost;
    }
    final capability = state.snapshot.capability;
    if (capability is BiometricUnavailable) {
      return biometricStatusCopy(l10n, capability).detail;
    }
    if (!state.snapshot.enrolled) {
      return l10n.biometricSignInFirst;
    }
    return null;
  }
}
