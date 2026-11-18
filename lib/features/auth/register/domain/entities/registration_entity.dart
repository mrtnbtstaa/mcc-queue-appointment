import 'package:equatable/equatable.dart';

class RegistrationEntity extends Equatable {
  const RegistrationEntity({
    required this.email,
    required this.password,
    required this.fullName,
    required this.studentNumber,
    required this.course,
    required this.yearLevel,
  });

  final String email;
  final String password;
  final String fullName;
  final String studentNumber;
  final String course;
  final String yearLevel;

  @override
  List<Object?> get props => [
    email,
    password,
    fullName,
    studentNumber,
    course,
    yearLevel,
  ];
}
