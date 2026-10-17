import 'package:equatable/equatable.dart';

/// A media item listed on the review screen.
class ReviewMediaItem extends Equatable {
  const ReviewMediaItem({
    required this.kind,
    required this.title,
    required this.detail,
    this.sizeLabel,
  });

  final ReviewMediaKind kind;
  final String title;

  /// e.g. `Exterior facade & sign`.
  final String detail;

  /// File size for videos, e.g. `6.2 MB`.
  final String? sizeLabel;

  @override
  List<Object?> get props => [kind, title, detail, sizeLabel];
}

/// Whether a media item is a still or the condition clip.
enum ReviewMediaKind { photo, clip, walkaround }
