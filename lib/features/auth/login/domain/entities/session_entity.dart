import 'package:equatable/equatable.dart';

import '../../../../../core/auth/auth_state.dart';

class SessionEntity extends Equatable {
  const SessionEntity({
    required this.accessToken,
    required this.refreshToken,
    required this.role,
  });

  final String accessToken;
  final String refreshToken;
  final UserRole role;

  @override
  List<Object?> get props => [accessToken, refreshToken, role];
}
