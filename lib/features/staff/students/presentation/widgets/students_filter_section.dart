import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../../../core/extensions/double_extension.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/common_text.dart';
import '../../../../../../core/widgets/common_text_field.dart';
import '../../../../shared/filter_options/presentation/filter_options_cubit.dart';
import '../cubit/students_cubit.dart';
import '../cubit/students_state.dart';

class StudentsFilterSection extends StatelessWidget {
  const StudentsFilterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<StudentsCubit>();

    return BlocBuilder<StudentsCubit, StudentsState>(
      builder: (context, state) {
        final courses = context
            .watch<FilterOptionsCubit>()
            .state
            .options
            .courses;

        return Column(
          children: [
            CommonTextField(
              hintText: 'Search student name, ID (e.g. 2023-014)',
              prefixIcon: const Icon(Icons.search, size: 18),
              onChanged: (val) => cubit.setSearchQuery(val),
            ),
            12.0.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText(
                  text: 'ACADEMIC PROGRAM',
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  fontColor: TAppColors.textHint,
                ),
                GestureDetector(
                  onTap: () => cubit.setCourseFilter(null),
                  child: CommonText(
                    text: 'Clear',
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    fontColor: TAppColors.primary,
                  ),
                ),
              ],
            ),
            8.0.height,
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildProgramChip(cubit, state, null, 'All'),
                for (final course in courses)
                  _buildProgramChip(cubit, state, course.value, course.label),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildProgramChip(
    StudentsCubit cubit,
    StudentsState state,
    String? course,
    String label,
  ) {
    final isSelected = state.selectedCourse == course;
    return InkWell(
      onTap: () => cubit.setCourseFilter(course),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? TAppColors.primary : TAppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? Colors.transparent : TAppColors.border,
          ),
        ),
        child: CommonText(
          text: label,
          fontSize: 11,
          fontWeight: FontWeight.bold,
          fontColor: isSelected ? TAppColors.surface : TAppColors.textPrimary,
        ),
      ),
    );
  }
}
