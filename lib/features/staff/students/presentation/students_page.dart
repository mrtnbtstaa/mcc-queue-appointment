import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../../../core/extensions/double_extension.dart';
import '../../../../../../core/widgets/common_adaptive_grid.dart';
import '../../../../../../core/widgets/common_empty_state.dart';
import '../../../../../../core/widgets/common_page_body.dart';
import 'cubit/students_cubit.dart';
import 'cubit/students_state.dart';

import 'widgets/student_record_card.dart';
import 'widgets/students_filter_section.dart';
import 'widgets/students_header_stats.dart';

class RegisteredStudentsWrapper extends StatelessWidget {
  const RegisteredStudentsWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I<StudentsCubit>()..loadStudents(),
      child: const RegisteredStudentsPage(),
    );
  }
}

class RegisteredStudentsPage extends StatelessWidget {
  const RegisteredStudentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification.metrics.extentAfter < 300) {
          context.read<StudentsCubit>().loadMore();
        }
        return false;
      },
      child: CommonPageBody(
        child: BlocBuilder<StudentsCubit, StudentsState>(
          builder: (context, state) {
            final list = state.filteredStudents;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                StudentsHeaderStats(count: state.students.length),
                16.0.height,
                const StudentsFilterSection(),
                16.0.height,
                if (state.isLoading && state.students.isEmpty)
                  const Padding(
                    padding: EdgeInsets.all(32),
                    child: Center(child: CircularProgressIndicator()),
                  )
                else if (state.error != null && state.students.isEmpty)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(state.error!),
                    ),
                  )
                else if (list.isEmpty)
                  const CommonEmptyState(
                    title: 'No students found',
                    message: 'Try changing your search or course filter.',
                  )
                else ...[
                  CommonAdaptiveGrid(
                    minItemWidth: 480,
                    maxColumns: 2,
                    children: [
                      for (final student in list)
                        StudentRecordCard(student: student),
                    ],
                  ),
                  if (state.isLoading)
                    const Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  if (state.error != null)
                    TextButton(
                      onPressed: context.read<StudentsCubit>().loadMore,
                      child: Text(state.error!),
                    ),
                ],
                20.0.height,
              ],
            );
          },
        ),
      ),
    );
  }
}
