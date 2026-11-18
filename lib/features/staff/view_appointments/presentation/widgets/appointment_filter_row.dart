import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/common_text_field.dart';
import '../../../../shared/filter_options/presentation/filter_options_cubit.dart';
import '../cubit/view_appointments_cubit.dart';
import '../cubit/view_appointments_state.dart';

class AppointmentFilterRow extends StatelessWidget {
  const AppointmentFilterRow({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ViewAppointmentsCubit>();

    return BlocBuilder<ViewAppointmentsCubit, ViewAppointmentsState>(
      builder: (context, state) {
        final statuses = context
            .watch<FilterOptionsCubit>()
            .state
            .options
            .appointmentStatuses;

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
                  _buildTabButton(cubit, state, null, 'All'),
                  for (final status in statuses) ...[
                    const SizedBox(width: 8),
                    _buildTabButton(
                      cubit,
                      state,
                      status.value,
                      status.label,
                    ),
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
    String? status,
    String label,
  ) {
    final isSelected = state.selectedStatus == status;

    return InkWell(
      onTap: () => cubit.setFilterTab(status),
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
          label,
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
