import 'package:equatable/equatable.dart';
import 'package:gcc_app/features/auth/domain/auth_role.dart';

final class SessionSnapshot extends Equatable {
  const SessionSnapshot({required this.unlocked, this.role});

  final bool unlocked;
  final AuthRole? role;

  @override
  List<Object?> get props => [unlocked, role];
}
