import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../../../core/extensions/double_extension.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/common_text.dart';
import '../../../../../../core/widgets/common_text_field.dart';
import '../../domain/model.dart';
import '../cubit/students_cubit.dart';
import '../cubit/students_state.dart';

class StudentsFilterSection extends StatelessWidget {
  const StudentsFilterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<StudentsCubit>();

    return BlocBuilder<StudentsCubit, StudentsState>(
      builder: (context, state) {
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
                  onTap: () => cubit.setProgramFilter(ProgramFilter.all),
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
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildProgramChip(cubit, state, ProgramFilter.all, 'All'),
                  8.0.width,
                  _buildProgramChip(cubit, state, ProgramFilter.bsit, 'BSIT'),
                  8.0.width,
                  _buildProgramChip(cubit, state, ProgramFilter.bsed, 'BSED'),
                  8.0.width,
                  _buildProgramChip(cubit, state, ProgramFilter.bsba, 'BSBA'),
                  8.0.width,
                  _buildProgramChip(cubit, state, ProgramFilter.bscpe, 'BSCpE'),
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
    ProgramFilter program,
    String label,
  ) {
    final isSelected = state.selectedProgram == program;
    return InkWell(
      onTap: () => cubit.setProgramFilter(program),
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
