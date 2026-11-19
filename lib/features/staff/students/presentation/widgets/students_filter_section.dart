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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CommonTextField(
              hintText: 'Search student name, ID (e.g. 2023-014)',
              prefixIcon: const Icon(Icons.search, size: 18),
              onChanged: (val) => cubit.setSearchQuery(val),
            ),
            12.0.height,
            Container(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
              decoration: BoxDecoration(
                color: TAppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: TAppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      CommonText(
                        text: 'ACADEMIC PROGRAM',
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        fontColor: TAppColors.textMuted,
                        letterSpacing: 0.6,
                      ),
                      const Spacer(),
                      if (state.selectedCourse != null)
                        InkWell(
                          onTap: () => cubit.setCourseFilter(null),
                          borderRadius: BorderRadius.circular(8),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.close,
                                  size: 12,
                                  color: TAppColors.primary,
                                ),
                                4.0.width,
                                CommonText(
                                  text: 'Clear',
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  fontColor: TAppColors.primary,
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                  10.0.height,
                  Wrap(
                    spacing: 8,
                    children: [
                      _buildProgramChip(cubit, state, null, 'All'),
                      for (final course in courses)
                        _buildProgramChip(
                          cubit,
                          state,
                          course.value,
                          course.label,
                        ),
                    ],
                  ),
                ],
              ),
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
    return ChoiceChip(
      selected: isSelected,
      showCheckmark: false,
      onSelected: (_) => cubit.setCourseFilter(course),
      selectedColor: TAppColors.primary,
      backgroundColor: TAppColors.surface,
      side: BorderSide(
        color: isSelected ? TAppColors.primary : TAppColors.border,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      labelPadding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
      label: CommonText(
        text: label,
        fontSize: 12,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
        fontColor: isSelected ? TAppColors.surface : TAppColors.textSecondary,
      ),
    );
  }
}
