import 'package:equatable/equatable.dart';

import '../../../../shared/profile/domain/entities/profile_entity.dart';
import '../../domain/model.dart';

class StudentsState extends Equatable {
  final String searchQuery;
  final ProgramFilter selectedProgram;
  final List<ProfileEntity> students;
  final bool isLoading;
  final String? error;
  final int page;
  final int totalPages;

  const StudentsState({
    this.searchQuery = '',
    this.selectedProgram = ProgramFilter.all,
    this.students = const [],
    this.isLoading = false,
    this.error,
    this.page = 1,
    this.totalPages = 1,
  });

  List<ProfileEntity> get filteredStudents => students;

  StudentsState copyWith({
    String? searchQuery,
    ProgramFilter? selectedProgram,
    List<ProfileEntity>? students,
    bool? isLoading,
    String? error,
    bool clearError = false,
    int? page,
    int? totalPages,
  }) => StudentsState(
    searchQuery: searchQuery ?? this.searchQuery,
    selectedProgram: selectedProgram ?? this.selectedProgram,
    students: students ?? this.students,
    isLoading: isLoading ?? this.isLoading,
    error: clearError ? null : error ?? this.error,
    page: page ?? this.page,
    totalPages: totalPages ?? this.totalPages,
  );

  @override
  List<Object?> get props => [
    searchQuery,
    selectedProgram,
    students,
    isLoading,
    error,
    page,
    totalPages,
  ];
}
