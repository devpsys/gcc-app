import 'package:equatable/equatable.dart';

final class OnlineStatusState extends Equatable {
  const OnlineStatusState._(this.isOnline);

  const OnlineStatusState.unknown() : this._(null);

  const OnlineStatusState.online() : this._(true);

  const OnlineStatusState.offline() : this._(false);

  /// `null` until the first checker reading lands.
  final bool? isOnline;

  bool get isOffline => isOnline == false;

  @override
  List<Object?> get props => [isOnline];
}
