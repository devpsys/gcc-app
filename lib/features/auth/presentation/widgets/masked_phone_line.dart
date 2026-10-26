import 'package:flutter/material.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';

/// “Sent via SMS to {mono phone}” — Frame 02 left-aligned body + mono bold phone.
class MaskedPhoneLine extends StatelessWidget {
  const MaskedPhoneLine({
    required this.message,
    required this.phone,
    this.textAlign = TextAlign.start,
    super.key,
  });

  final String message;
  final String phone;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final style = Theme.of(context).textTheme.bodySmall?.copyWith(
      color: scheme.onSurfaceVariant,
      fontWeight: FontWeight.w400,
    );
    final index = message.indexOf(phone);
    if (index < 0) {
      return Text(message, textAlign: textAlign, style: style);
    }
    return Text.rich(
      TextSpan(
        style: style,
        children: [
          TextSpan(text: message.substring(0, index)),
          TextSpan(
            text: phone,
            style: AppTextStyles.mono(
              style!.copyWith(
                color: scheme.onSurface,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          TextSpan(text: message.substring(index + phone.length)),
        ],
      ),
      textAlign: textAlign,
    );
  }
}
