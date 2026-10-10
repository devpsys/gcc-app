import 'package:flutter/material.dart';

class OnboardingRoleNote extends StatelessWidget {
  const OnboardingRoleNote({required this.text, required this.path, super.key});

  final String text;
  final String path;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodySmall;
    final index = text.indexOf(path);
    if (index < 0) {
      return Text(text, textAlign: TextAlign.center, style: style);
    }
    return Text.rich(
      TextSpan(
        style: style,
        children: [
          TextSpan(text: text.substring(0, index)),
          TextSpan(
            text: path,
            style: style?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
              fontWeight: FontWeight.w500,
            ),
          ),
          TextSpan(text: text.substring(index + path.length)),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
