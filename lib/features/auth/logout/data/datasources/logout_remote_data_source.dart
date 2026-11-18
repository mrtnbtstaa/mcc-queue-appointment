import '../../../../../core/network/api_client.dart';
import '../../../../../core/network/api_result.dart';
import '../models/logout_request_dto.dart';

class LogoutRemoteDataSource {
  LogoutRemoteDataSource(this._client);
  final ApiClient _client;

  Future<ApiResult<void>> logout(String refreshToken) async {
    final dto = LogoutRequestDto(refreshToken: refreshToken);

    return await _client.post<void>(
      'v1/auth/logout/',
      body: dto.toJson(),
      requireAuth: true, // Bearer token is attached by interceptor
      isIdempotent: true,
      decode: (_) {},
    );
  }
}
