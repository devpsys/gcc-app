import 'package:flutter/material.dart';

/// One action in the camera stage's bottom bar.
class CameraAction {
  const CameraAction({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;
}
