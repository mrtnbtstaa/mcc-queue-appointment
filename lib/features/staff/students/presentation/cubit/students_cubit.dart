import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../shared/profile/domain/usecases/get_users.dart';
import 'students_state.dart';

class StudentsCubit extends Cubit<StudentsState> {
  final GetUsers getUsers;
  Timer? _searchDebounce;
  int _requestId = 0;

  StudentsCubit(this.getUsers) : super(const StudentsState());

  Future<void> loadStudents({bool clearStudents = false}) async {
    emit(
      state.copyWith(
        isLoading: true,
        clearError: true,
        students: clearStudents ? const [] : null,
      ),
    );
    final query = state.searchQuery.trim();
    final course = state.selectedCourse;
    final requestId = ++_requestId;
    final result = await getUsers.callPage(
      GetUsersParams(search: query.isEmpty ? null : query, course: course),
    );
    if (isClosed || requestId != _requestId) return;
    result.fold(
      (failure) => emit(
        state.copyWith(isLoading: false, error: failureMessage(failure)),
      ),
      (usersPage) => emit(
        state.copyWith(
          isLoading: false,
          clearError: true,
          students: usersPage.items
              .where((user) => user.role.toLowerCase() == 'student')
              .toList(),
          page: usersPage.page,
          totalPages: usersPage.totalPages,
        ),
      ),
    );
  }

  Future<void> loadMore() async {
    if (state.isLoading || state.page >= state.totalPages) return;
    final requestId = _requestId;
    emit(state.copyWith(isLoading: true, clearError: true));
    final query = state.searchQuery.trim();
    final course = state.selectedCourse;
    final result = await getUsers.callPage(
      GetUsersParams(
        search: query.isEmpty ? null : query,
        course: course,
        page: state.page + 1,
      ),
    );
    if (isClosed || requestId != _requestId) return;
    result.fold(
      (failure) => emit(
        state.copyWith(isLoading: false, error: failureMessage(failure)),
      ),
      (usersPage) => emit(
        state.copyWith(
          isLoading: false,
          students: [
            ...state.students,
            ...usersPage.items.where(
              (user) => user.role.toLowerCase() == 'student',
            ),
          ],
          page: usersPage.page,
          totalPages: usersPage.totalPages,
        ),
      ),
    );
  }

  void setSearchQuery(String query) {
    if (query == state.searchQuery) return;
    emit(state.copyWith(searchQuery: query));
    _searchDebounce?.cancel();
    _searchDebounce = Timer(
      const Duration(milliseconds: 400),
      () => loadStudents(clearStudents: true),
    );
  }

  void setCourseFilter(String? course) {
    if (course == state.selectedCourse) return;
    _searchDebounce?.cancel();
    emit(state.copyWith(selectedCourse: course, clearCourse: course == null));
    loadStudents(clearStudents: true);
  }

  @override
  Future<void> close() {
    _searchDebounce?.cancel();
    return super.close();
  }
}
