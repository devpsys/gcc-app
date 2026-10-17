import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/coordinate_field.dart';

/// Latitude and longitude entry for agents with no usable GPS signal.
///
/// Validation is per axis, because a latitude outside ±90 and a longitude
/// outside ±180 are different mistakes and need different messages.
class ManualCoordinatesForm extends StatefulWidget {
  const ManualCoordinatesForm({
    required this.latitudeLabel,
    required this.longitudeLabel,
    required this.northSuffix,
    required this.eastSuffix,
    required this.onChanged,
    this.latitudeError,
    this.longitudeError,
    super.key,
  });

  final String latitudeLabel;
  final String longitudeLabel;
  final String northSuffix;
  final String eastSuffix;

  /// Range message for latitude, or null when the value is usable.
  final String? latitudeError;

  /// Range message for longitude, or null when the value is usable.
  final String? longitudeError;

  final void Function({required String latitude, required String longitude})
  onChanged;

  /// Whether [value] is inside ±[limit] degrees, or blank.
  static bool isValid(String value, double limit) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) {
      return true;
    }
    final parsed = double.tryParse(trimmed);
    if (parsed == null) {
      return false;
    }
    return parsed.abs() <= limit;
  }

  @override
  State<ManualCoordinatesForm> createState() => _ManualCoordinatesFormState();
}

class _ManualCoordinatesFormState extends State<ManualCoordinatesForm> {
  final _latitude = TextEditingController();
  final _longitude = TextEditingController();

  @override
  void dispose() {
    _latitude.dispose();
    _longitude.dispose();
    super.dispose();
  }

  void _emitLatitude(String value) {
    widget.onChanged(latitude: value, longitude: _longitude.text);
  }

  void _emitLongitude(String value) {
    widget.onChanged(latitude: _latitude.text, longitude: value);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      children: [
        CoordinateField(
          label: widget.latitudeLabel,
          hint: l10n.gpsLatitudeExample,
          direction: widget.northSuffix,
          controller: _latitude,
          errorText: widget.latitudeError,
          onChanged: _emitLatitude,
        ),
        const SizedBox(height: AppSpacing.md),
        CoordinateField(
          label: widget.longitudeLabel,
          hint: l10n.gpsLongitudeExample,
          direction: widget.eastSuffix,
          controller: _longitude,
          errorText: widget.longitudeError,
          onChanged: _emitLongitude,
        ),
      ],
    );
  }
}
