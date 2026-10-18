import 'package:flutter/material.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/app_primary_button.dart';
import 'package:gcc_app/core/widgets/app_secondary_button.dart';

class BiometricUnlockAction extends StatelessWidget {
  const BiometricUnlockAction({
    required this.unlockLabel,
    required this.codeLabel,
    required this.onUseCode,
    this.onUnlock,
    this.unlockDisabledReason,
    this.busy = false,
    super.key,
  });

  final String unlockLabel;
  final String codeLabel;
  final VoidCallback? onUnlock;
  final VoidCallback onUseCode;
  final String? unlockDisabledReason;
  final bool busy;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppPrimaryButton(
          label: unlockLabel,
          busy: busy,
          onPressed: busy ? null : onUnlock,
          disabledReason: unlockDisabledReason,
        ),
        const SizedBox(height: AppSpacing.sm),
        AppSecondaryButton(
          label: codeLabel,
          onPressed: busy ? null : onUseCode,
        ),
      ],
    );
  }
}
