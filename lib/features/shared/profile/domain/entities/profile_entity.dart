import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  final String id;
  final String email;
  final String studentId;
  final String course;
  final String yearLevel;
  final String name;
  final bool isActive;
  final String role;

  const ProfileEntity({
    required this.id,
    required this.email,
    required this.studentId,
    required this.course,
    required this.yearLevel,
    required this.name,
    required this.isActive,
    required this.role,
  });

  factory ProfileEntity.fromJson(Map<String, dynamic> json) => ProfileEntity(
    id: json['id']?.toString() ?? '',
    email: json['email']?.toString() ?? '',
    studentId: json['student_id']?.toString() ?? '',
    course: json['course']?.toString() ?? '',
    yearLevel: json['year_level']?.toString() ?? '',
    name: json['name']?.toString() ?? '',
    isActive: json['is_active'] == true,
    role: json['role']?.toString() ?? '',
  );

  @override
  List<Object?> get props => [
    id,
    email,
    studentId,
    course,
    yearLevel,
    name,
    isActive,
    role,
  ];
}
