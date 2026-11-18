import '../../../../../core/auth/user_role_mapper.dart'; // Adjust path to where your mapRole lives
import '../../domain/entities/session_entity.dart';

class SessionDto {
  const SessionDto({
    required this.accessToken,
    required this.refreshToken,
    required this.role,
  });

  factory SessionDto.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;
    return SessionDto(
      accessToken: data['access_token'] as String,
      refreshToken: data['refresh_token'] as String,
      role: data['role'] as String,
    );
  }

  final String accessToken;
  final String refreshToken;
  final String role;

  SessionEntity toDomain() {
    return SessionEntity(
      accessToken: accessToken,
      refreshToken: refreshToken,
      role: mapRole(role),
    );
  }
}
