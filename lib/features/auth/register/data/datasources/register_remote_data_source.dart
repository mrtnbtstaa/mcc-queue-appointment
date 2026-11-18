import '../../../../../core/network/api_client.dart';
import '../../../../../core/network/api_error.dart';
import '../../../../../core/network/api_result.dart';
import '../models/register_request_dto.dart';

class RegisterRemoteDataSource {
  RegisterRemoteDataSource(this._client);
  final ApiClient _client;

  /// Returns `null` on success, or the [ApiError] on failure.
  ///
  /// `ApiClient` already converts transport exceptions into `ApiResult`,
  /// so there's no try/catch here. Returning `ApiError?` (rather than
  /// `ApiResult<void>`) keeps the repository free of unwrapping
  /// boilerplate for a response body it discards.
  Future<ApiError?> register(RegisterRequestDto dto) async {
    final result = await _client.post<void>(
      'v1/auth/register/',
      body: dto.toJson(),
      requireAuth: false,
      isIdempotent: false,
      decode: (_) {},
    );

    return switch (result) {
      ApiSuccess() => null,
      ApiFailure(:final error) => error,
    };
  }
}
