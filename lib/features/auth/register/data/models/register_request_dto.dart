import '../../domain/entities/registration_entity.dart';

class RegisterRequestDto {
  const RegisterRequestDto({
    required this.email,
    required this.password,
    required this.fullName,
    required this.studentNumber,
    required this.course,
    required this.yearLevel,
  });

  factory RegisterRequestDto.fromDomain(RegistrationEntity draft) {
    return RegisterRequestDto(
      email: draft.email,
      password: draft.password,
      fullName: draft.fullName,
      studentNumber: draft.studentNumber,
      course: draft.course,
      yearLevel: draft.yearLevel,
    );
  }

  final String email;
  final String password;
  final String fullName;
  final String studentNumber;
  final String course;
  final String yearLevel;

  Map<String, dynamic> toJson() {
    final map = {
      'student_id': studentNumber,
      'full_name': fullName,
      'email': email,
      'course': course,
      'year_level': yearLevel,
      'password': password,
      'confirm_password': password,
    };
    print('REGISTER PAYLOAD: $map'); // Check this in your console!
    return map;
  }
}
