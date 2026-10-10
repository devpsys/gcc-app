import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/widgets/app_primary_button.dart';

class OnboardingSignInAction extends StatelessWidget {
  const OnboardingSignInAction({
    required this.busy,
    required this.awaitingCode,
    required this.verificationFailed,
    required this.codeComplete,
    required this.phoneReady,
    required this.phoneEmpty,
    required this.onSendCode,
    required this.onVerify,
    super.key,
  });

  final bool busy;
  final bool awaitingCode;
  final bool verificationFailed;
  final bool codeComplete;
  final bool phoneReady;
  final bool phoneEmpty;
  final VoidCallback onSendCode;
  final VoidCallback onVerify;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    if (verificationFailed) {
      return AppPrimaryButton(
        label: l10n.authResendCode,
        busy: busy,
        onPressed: busy ? null : onSendCode,
      );
    }
    if (awaitingCode) {
      return AppPrimaryButton(
        label: l10n.authVerify,
        busy: busy,
        onPressed: codeComplete && !busy ? onVerify : null,
        disabledReason: l10n.authOtpIncompleteReason,
      );
    }
    return AppPrimaryButton(
      label: l10n.onboardingSendCode,
      busy: busy,
      onPressed: phoneReady && !busy ? onSendCode : null,
      disabledReason: phoneEmpty
          ? l10n.onboardingSendCodeNeedsPhone
          : l10n.onboardingSendCodeNeedsFullPhone,
    );
  }
}
