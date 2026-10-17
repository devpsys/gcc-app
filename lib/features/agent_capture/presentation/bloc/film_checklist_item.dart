import 'package:equatable/equatable.dart';

/// One shot the agent is asked to film, in the order the design lists them.
class FilmChecklistItem extends Equatable {
  const FilmChecklistItem({required this.label, this.done = false});

  final String label;
  final bool done;

  FilmChecklistItem copyWith({bool? done}) =>
      FilmChecklistItem(label: label, done: done ?? this.done);

  @override
  List<Object?> get props => [label, done];
}
