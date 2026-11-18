import 'package:equatable/equatable.dart';

import '../../../../shared/profile/domain/entities/profile_entity.dart';

class StudentsState extends Equatable {
  final String searchQuery;
  final String? selectedCourse;
  final List<ProfileEntity> students;
  final bool isLoading;
  final String? error;
  final int page;
  final int totalPages;

  const StudentsState({
    this.searchQuery = '',
    this.selectedCourse,
    this.students = const [],
    this.isLoading = false,
    this.error,
    this.page = 1,
    this.totalPages = 1,
  });

  List<ProfileEntity> get filteredStudents => students;

  StudentsState copyWith({
    String? searchQuery,
    String? selectedCourse,
    bool clearCourse = false,
    List<ProfileEntity>? students,
    bool? isLoading,
    String? error,
    bool clearError = false,
    int? page,
    int? totalPages,
  }) => StudentsState(
    searchQuery: searchQuery ?? this.searchQuery,
    selectedCourse: clearCourse ? null : selectedCourse ?? this.selectedCourse,
    students: students ?? this.students,
    isLoading: isLoading ?? this.isLoading,
    error: clearError ? null : error ?? this.error,
    page: page ?? this.page,
    totalPages: totalPages ?? this.totalPages,
  );

  @override
  List<Object?> get props => [
    searchQuery,
    selectedCourse,
    students,
    isLoading,
    error,
    page,
    totalPages,
  ];
}
