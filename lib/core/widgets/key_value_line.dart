import 'package:flutter/material.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';

class KeyValueLine extends StatelessWidget {
  const KeyValueLine({required this.label, required this.value, super.key});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: textTheme.bodySmall),
        Text(value, style: AppTextStyles.tabular(textTheme.bodyMedium!)),
      ],
    );
  }
}
