import '../../../../../core/network/api_client.dart';
import '../../../../../core/network/api_result.dart';
import '../models/login_request_dto.dart';
import '../models/session_dto.dart';

class LoginRemoteDataSource {
  LoginRemoteDataSource(this._client);
  final ApiClient _client;

  Future<ApiResult<SessionDto>> login(LoginRequestDto dto) async {
    return await _client.post<SessionDto>(
      'v1/auth/login/',
      body: dto.toJson(),
      requireAuth:
          false, // Public endpoint (no Bearer token, no 401-refresh loop)
      isIdempotent: false, // POST request, do not retry on 5xx
      decode: (json) => SessionDto.fromJson(json as Map<String, dynamic>),
    );
  }
}
