import 'package:equatable/equatable.dart';

/// One week in the six-week earnings chart.
class WeeklyEarning extends Equatable {
  const WeeklyEarning({required this.weekEnding, required this.amount});

  /// e.g. `30 AUG`.
  final String weekEnding;

  /// e.g. `₦15K`.
  final String amount;

  /// The figure as a number, for scaling the bar.
  ///
  /// Honours the `K` and `M` suffixes the chart uses, so `₦15K` reads as 15000
  /// rather than 15. Stripping the suffix silently would flatten the chart and
  /// understate the total.
  double get numeric {
    final digits = amount.replaceAll(RegExp(r'[^0-9.]'), '');
    final value = double.tryParse(digits) ?? 0;
    if (amount.toUpperCase().contains('M')) return value * 1000000;
    if (amount.toUpperCase().contains('K')) return value * 1000;
    return value;
  }

  @override
  List<Object?> get props => [weekEnding, amount];
}
