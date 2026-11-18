import 'auth_state.dart';

/// Maps the role string from the login/register response to [UserRole].
///
/// ASSUMPTION: your backend returns `"student"` or `"staff"` (case-insensitive)
/// in a `role` field. If it returns an enum int, a different string, or a
/// list of roles, change this — and only this.
UserRole mapRole(String? raw) {
  switch (raw?.toLowerCase()) {
    case 'student':
      return UserRole.student;
    case 'staff':
    case 'registrar':
    case 'admin':
      return UserRole.staff;
    default:
      return UserRole.none;
  }
}
