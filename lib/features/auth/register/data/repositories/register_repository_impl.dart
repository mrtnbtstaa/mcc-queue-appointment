import 'package:fpdart/fpdart.dart';

import '../../../../../core/network/api_error.dart';
import '../../domain/entities/registration_entity.dart';
import '../../domain/failures/register_failure.dart';
import '../../domain/repositories/register_repository.dart';
import '../datasources/register_remote_data_source.dart';
import '../models/register_request_dto.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  RegisterRepositoryImpl(this._remote);
  final RegisterRemoteDataSource _remote;

  @override
  Future<Either<RegisterFailure, Unit>> register(
    RegistrationEntity draft,
  ) async {
    final error = await _remote.register(RegisterRequestDto.fromDomain(draft));
    if (error == null) return const Right(unit);
    return Left(_mapFailure(error));
  }

  // ── Failure mapping ──────────────────────────────────────────────────
  // This is the layer's whole job: turn a transport error (ApiError, with
  // its HTTP status and backend `error_code`) into a domain failure
  // (RegisterFailure) that the Cubit and UI understand.

  RegisterFailure _mapFailure(ApiError error) {
    // Prefer backend error_code — more specific than HTTP status.
    switch (error.code) {
      case 'EMAIL_ALREADY_EXISTS':
      case 'DUPLICATE_EMAIL':
        return EmailAlreadyRegistered(error.message);
      case 'WEAK_PASSWORD':
        return WeakPassword(error.message);
      case 'VALIDATION_ERROR':
        return ValidationFailure(mapFieldErrors(error.details), error.message);
    }

    // Fall back to HTTP-status-based mapping when no code is present.
    return switch (error.kind) {
      ApiErrorKind.conflict => EmailAlreadyRegistered(error.message),
      ApiErrorKind.validation => ValidationFailure(
        mapFieldErrors(error.details),
        error.message,
      ),
      ApiErrorKind.network || ApiErrorKind.timeout => const NetworkFailure(),
      ApiErrorKind.server => ServerFailure(error.message),
      _ => UnknownFailure(error.message),
    };
  }
}

// ── Pure helper (top-level, testable in isolation) ─────────────────────
// Kept outside the class because it's a pure function with no dependency
// on `_remote` — extracting it lets tests call it without constructing a
// repository with a fake datasource.

/// Maps the backend's field-error payload to `field -> first message`.
///
/// ASSUMPTION: the 422 envelope is
///   `{ "errors": { "email": ["is taken"], "password": ["too short"] } }`
/// — a map of field name to a list of message strings.
Map<String, String> mapFieldErrors(Map<String, dynamic>? details) {
  if (details == null) return const {};
  final out = <String, String>{};
  for (final entry in details.entries) {
    final value = entry.value;
    if (value is List && value.isNotEmpty && value.first is String) {
      out[entry.key] = value.first as String;
      continue;
    }
    if (value is String && value.isNotEmpty) {
      out[entry.key] = value;
    }
  }
  return out;
}
