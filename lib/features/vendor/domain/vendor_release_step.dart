import 'package:equatable/equatable.dart';

/// One mark on the release track. Titles are chosen by the page.
enum VendorReleaseMark { done, current, pending }

class VendorReleaseStep extends Equatable {
  const VendorReleaseStep({required this.mark, this.when});

  final VendorReleaseMark mark;

  /// A date from the ledger, such as `16 Oct`. Pending steps omit it.
  final String? when;

  @override
  List<Object?> get props => [mark, when];
}
