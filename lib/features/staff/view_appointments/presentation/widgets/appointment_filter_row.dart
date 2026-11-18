import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/common_text_field.dart';
import '../../domain/model.dart';
import '../cubit/view_appointments_cubit.dart';
import '../cubit/view_appointments_state.dart';

class AppointmentFilterRow extends StatelessWidget {
  const AppointmentFilterRow({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ViewAppointmentsCubit>();

    return BlocBuilder<ViewAppointmentsCubit, ViewAppointmentsState>(
      builder: (context, state) {
        return Column(
          children: [
            CommonTextField(
              hintText: 'Search student name, ID number, or appointment code',
              prefixIcon: const Icon(Icons.search, size: 18),
              onChanged: cubit.setSearchQuery,
            ),
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (final tab in AppointmentTab.values) ...[
                    if (tab != AppointmentTab.values.first)
                      const SizedBox(width: 8),
                    _buildTabButton(cubit, state, tab),
                  ],
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTabButton(
    ViewAppointmentsCubit cubit,
    ViewAppointmentsState state,
    AppointmentTab tab,
  ) {
    final isSelected = state.selectedTab == tab;

    return InkWell(
      onTap: () => cubit.setFilterTab(tab),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? TAppColors.primary : TAppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? Colors.transparent : TAppColors.border,
          ),
        ),
        child: Text(
          tab.label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: isSelected ? TAppColors.surface : TAppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}
