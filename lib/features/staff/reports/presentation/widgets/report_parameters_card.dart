import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../../../core/extensions/double_extension.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/common_elevated_button.dart';
import '../../../../../../core/widgets/common_text.dart';
import '../cubit/reports_cubit.dart';
import '../cubit/reports_state.dart';

class ReportParametersCard extends StatelessWidget {
  const ReportParametersCard({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegistrarReportsCubit>();
    return BlocBuilder<RegistrarReportsCubit, RegistrarReportsState>(
      builder: (context, state) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: TAppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: TAppColors.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.description_outlined,
                  size: 16,
                  color: TAppColors.primary,
                ),
                8.0.width,
                CommonText(
                  text: 'Appointment & Transaction Summary',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
            14.0.height,
            CommonText(
              text: 'Date Range',
              fontSize: 11,
              fontWeight: FontWeight.bold,
              fontColor: TAppColors.textSecondary,
            ),
            6.0.height,
            InkWell(
              onTap: state.isGenerating
                  ? null
                  : () async {
                      final range = await showDateRangePicker(
                        context: context,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                        initialDateRange: DateTimeRange(
                          start: state.dateFrom,
                          end: state.dateTo,
                        ),
                      );
                      if (range != null) cubit.setDateRange(range);
                    },
              borderRadius: BorderRadius.circular(10),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: TAppColors.background,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: TAppColors.border),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: TAppColors.primary,
                    ),
                    8.0.width,
                    Expanded(
                      child: CommonText(
                        text: state.dateScope,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        maxLine: 2,
                      ),
                    ),
                    const Icon(Icons.arrow_drop_down, size: 18),
                  ],
                ),
              ),
            ),
            16.0.height,
            CommonElevatedButton(
              text: state.isGenerating
                  ? 'Generating PDF...'
                  : 'Generate PDF Report',
              backgroundColor: TAppColors.primary,
              onButtonPressed: state.isGenerating ? null : cubit.generateReport,
            ),
          ],
        ),
      ),
    );
  }
}
