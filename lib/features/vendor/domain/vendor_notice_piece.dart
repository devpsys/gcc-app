import 'package:equatable/equatable.dart';

/// One fragment of a notification detail line.
///
/// [locked] is only for money that is still held. A released or returned
/// amount stays unlocked.
class VendorNoticePiece extends Equatable {
  const VendorNoticePiece(
    this.text, {
    this.locked = false,
    this.emphasis = false,
  });

  final String text;
  final bool locked;
  final bool emphasis;

  @override
  List<Object?> get props => [text, locked, emphasis];
}
