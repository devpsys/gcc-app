import 'package:flutter/material.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';

class MaskedPhoneLine extends StatelessWidget {
  const MaskedPhoneLine({
    required this.message,
    required this.phone,
    super.key,
  });

  final String message;
  final String phone;

  @override
  Widget build(BuildContext context) {
    final style = DefaultTextStyle.of(context).style;
    final index = message.indexOf(phone);
    if (index < 0) {
      return Text(message, textAlign: TextAlign.center, style: style);
    }
    return Text.rich(
      TextSpan(
        style: style,
        children: [
          TextSpan(text: message.substring(0, index)),
          TextSpan(
            text: phone,
            style: AppTextStyles.mono(
              style.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          TextSpan(text: message.substring(index + phone.length)),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
