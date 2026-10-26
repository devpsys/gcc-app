import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/core/widgets/app_primary_button.dart';
import 'package:gcc_app/features/auth/data/auth_role_paths.dart';
import 'package:gcc_app/features/auth/domain/auth_role.dart';
import 'package:gcc_app/features/auth/domain/biometric_capability.dart';
import 'package:gcc_app/features/auth/domain/device_lock_snapshot.dart';
import 'package:gcc_app/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:gcc_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:gcc_app/features/auth/presentation/bloc/device_lock_cubit.dart';
import 'package:gcc_app/features/auth/presentation/bloc/device_lock_state.dart';
import 'package:gcc_app/features/auth/presentation/widgets/masked_phone_line.dart';
import 'package:gcc_app/features/auth/presentation/widgets/otp_code_field.dart';
import 'package:go_router/go_router.dart';

class AgentOtpPage extends StatefulWidget {
  const AgentOtpPage({super.key});

  @override
  State<AgentOtpPage> createState() => _AgentOtpPageState();
}

class _AgentOtpPageState extends State<AgentOtpPage> {
  static const _resendSeconds = 24;
  Timer? _timer;
  var _secondsLeft = _resendSeconds;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() => _secondsLeft = _resendSeconds);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_secondsLeft <= 1) {
        timer.cancel();
        setState(() => _secondsLeft = 0);
        return;
      }
      setState(() => _secondsLeft -= 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          current is AuthVerified && previous is! AuthVerified,
      listener: (context, state) {
        unawaited(_continueAfterVerification(context, state.entryRole));
      },
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          final cubit = context.read<AuthCubit>();
          final busy = state is AuthVerifying || state is AuthValidating;
          final incorrect =
              state is AuthFailed &&
              state.kind == AuthFailureKind.verification;
          final complete = state.code.length == OtpCodeField.length;
          final scheme = Theme.of(context).colorScheme;
          final colors = context.semanticColors;
          final timerLabel =
              '0:${_secondsLeft.toString().padLeft(2, '0')}';

          return Scaffold(
            backgroundColor: scheme.surface,
            body: SafeArea(
              child: Align(
                alignment: Alignment.topCenter,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 480),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.xs,
                          vertical: AppSpacing.xxs,
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              tooltip: l10n.authBack,
                              onPressed: busy
                                  ? null
                                  : () {
                                      cubit.editIdentifier();
                                      final router = GoRouter.maybeOf(context);
                                      if (router != null && router.canPop()) {
                                        context.pop();
                                      }
                                    },
                              icon: const Icon(Icons.arrow_back),
                            ),
                            Expanded(
                              child: Text(
                                l10n.authOtpStepLabel.toUpperCase(),
                                textAlign: TextAlign.center,
                                style: AppTextStyles.mono(
                                  Theme.of(context).textTheme.labelMedium!
                                      .copyWith(
                                        color: scheme.onSurfaceVariant,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 0.4,
                                      ),
                                ),
                              ),
                            ),
                            const SizedBox(width: AppDimensions.minTouchTarget),
                          ],
                        ),
                      ),
                      const Divider(height: 1),
                      Expanded(
                        child: ListView(
                          padding: const EdgeInsets.fromLTRB(
                            AppSpacing.lg,
                            AppSpacing.sm,
                            AppSpacing.lg,
                            AppSpacing.md,
                          ),
                          children: [
                            Text(
                              l10n.authEnterCodeTitle,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(
                                    fontSize: 24,
                                    height: 1.2,
                                    fontWeight: FontWeight.w700,
                                    color: scheme.onSurface,
                                  ),
                            ),
                            const SizedBox(height: AppSpacing.xxs),
                            MaskedPhoneLine(
                              message: l10n.authCodeSentTo(state.maskedPhone),
                              phone: state.maskedPhone,
                            ),
                            const SizedBox(height: AppSpacing.xl),
                            OtpCodeField(
                              label: l10n.authOtpFieldLabel,
                              autofocus: true,
                              enabled: !busy,
                              errorText: incorrect
                                  ? l10n.authOtpIncorrect
                                  : null,
                              onChanged: cubit.codeChanged,
                              onCompleted: (_) => cubit.verify(),
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            Text(
                              l10n.authOtpAutoSubmitHint,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.labelSmall
                                  ?.copyWith(
                                    color: scheme.onSurfaceVariant,
                                    fontWeight: FontWeight.w400,
                                  ),
                            ),
                            const SizedBox(height: AppSpacing.xl),
                            AppPrimaryButton(
                              label: l10n.authVerify,
                              busy: busy,
                              onPressed: complete && !busy
                                  ? cubit.verify
                                  : null,
                              disabledReason: complete
                                  ? null
                                  : l10n.authOtpIncompleteReason,
                            ),
                            const SizedBox(height: AppSpacing.md),
                            Text.rich(
                              TextSpan(
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(
                                      color: scheme.onSurfaceVariant,
                                      fontWeight: FontWeight.w400,
                                    ),
                                children: [
                                  TextSpan(text: '${l10n.authDidntGetCode} '),
                                  if (_secondsLeft > 0)
                                    ..._resendCountdownSpans(
                                      context,
                                      l10n.authResendIn(timerLabel),
                                      timerLabel,
                                    )
                                  else
                                    WidgetSpan(
                                      alignment:
                                          PlaceholderAlignment.baseline,
                                      baseline: TextBaseline.alphabetic,
                                      child: TextButton(
                                        onPressed: busy
                                            ? null
                                            : () async {
                                                await cubit.resendCode();
                                                _startTimer();
                                              },
                                        style: TextButton.styleFrom(
                                          foregroundColor: scheme.primary,
                                          visualDensity: VisualDensity.compact,
                                          padding: EdgeInsets.zero,
                                          minimumSize: Size.zero,
                                          tapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                        ),
                                        child: Text(
                                          l10n.authResendCode,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                color: scheme.primary,
                                                fontWeight: FontWeight.w700,
                                              ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: AppSpacing.md),
                            Center(
                              child: TextButton.icon(
                                onPressed: busy
                                    ? null
                                    : () {
                                        cubit.editIdentifier();
                                        final router = GoRouter.maybeOf(
                                          context,
                                        );
                                        if (router != null && router.canPop()) {
                                          context.pop();
                                        }
                                      },
                                style: TextButton.styleFrom(
                                  foregroundColor: scheme.primary,
                                  visualDensity: VisualDensity.compact,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: AppSpacing.md,
                                    vertical: AppSpacing.xs,
                                  ),
                                ),
                                icon: Icon(
                                  Icons.phone_iphone,
                                  size: AppDimensions.iconMd,
                                  color: scheme.primary,
                                ),
                                label: Text(
                                  l10n.authUseDifferentNumber,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        color: scheme.primary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            DecoratedBox(
                              decoration: BoxDecoration(
                                color: scheme.surfaceContainerLow,
                                borderRadius: BorderRadius.circular(
                                  AppRadii.dialog,
                                ),
                                border: Border.all(color: colors.border),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(AppSpacing.sm),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.sms_outlined,
                                      size: AppDimensions.iconMd,
                                      color: scheme.onSurfaceVariant,
                                    ),
                                    const SizedBox(width: AppSpacing.xs),
                                    Expanded(
                                      child: Text.rich(
                                        TextSpan(
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall
                                              ?.copyWith(
                                                color: scheme.onSurfaceVariant,
                                                height: 1.35,
                                              ),
                                          children: [
                                            TextSpan(
                                              text:
                                                  '${l10n.authGsmFallbackTitle} ',
                                              style: TextStyle(
                                                color: scheme.onSurface,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            TextSpan(
                                              text: l10n.authGsmFallbackBody,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(height: 1),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                          AppSpacing.lg,
                          AppSpacing.xs,
                          AppSpacing.lg,
                          AppSpacing.md,
                        ),
                        child: Text(
                          l10n.authNodeFooter(l10n.authSupportPhone),
                          textAlign: TextAlign.center,
                          style: AppTextStyles.mono(
                            Theme.of(context).textTheme.labelSmall!.copyWith(
                              color: scheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

List<InlineSpan> _resendCountdownSpans(
  BuildContext context,
  String resendIn,
  String timerLabel,
) {
  final scheme = Theme.of(context).colorScheme;
  final leadStyle = TextStyle(
    color: scheme.primary,
    fontWeight: FontWeight.w600,
  );
  final timerStyle = AppTextStyles.mono(
    TextStyle(
      color: scheme.onSurface,
      fontWeight: FontWeight.w700,
      fontSize: AppTextStyles.bodySmallSize,
      height: AppTextStyles.bodySmallLineHeight / AppTextStyles.bodySmallSize,
    ),
  );
  final index = resendIn.indexOf(timerLabel);
  if (index < 0) {
    return [TextSpan(text: resendIn, style: leadStyle)];
  }
  return [
    TextSpan(text: resendIn.substring(0, index), style: leadStyle),
    TextSpan(text: timerLabel, style: timerStyle),
    TextSpan(text: resendIn.substring(index + timerLabel.length), style: leadStyle),
  ];
}

Future<void> _continueAfterVerification(
  BuildContext context,
  AuthRole role,
) async {
  if (role == AuthRole.agent) {
    final lock = _lockCubit(context);
    if (lock != null) {
      await lock.load();
      if (!context.mounted) {
        return;
      }
      final current = lock.state;
      if (current is DeviceLockReady && _shouldOfferLock(current.snapshot)) {
        await lock.enroll();
      }
    }
  }
  if (!context.mounted) {
    return;
  }
  GoRouter.maybeOf(context)?.go(homeLocationForRole(role));
}

DeviceLockCubit? _lockCubit(BuildContext context) {
  try {
    return context.read<DeviceLockCubit>();
  } on ProviderNotFoundException {
    return null;
  }
}

bool _shouldOfferLock(DeviceLockSnapshot snapshot) {
  return snapshot.capability is BiometricAvailable &&
      !snapshot.enrolled &&
      !snapshot.promptDeclined;
}
