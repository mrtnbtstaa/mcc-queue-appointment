import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../../core/extensions/context_extension.dart';
import '../../../../../core/extensions/double_extension.dart';
import '../../../../../core/widgets/common_page_body.dart';
import '../../../../core/di/injector.dart';
import '../../../shared/appointment_schedules/presentation/bloc/manage_schedules_bloc.dart';
import '../../../shared/appointment_schedules/presentation/bloc/manage_schedules_event.dart';
import 'widgets/create_schedule_bottom_sheet.dart';
import 'widgets/daily_time_slots_list.dart';
import 'widgets/schedule_calendar_card.dart';
import 'widgets/schedules_header.dart';

class AppointmentScheduleWrapper extends StatelessWidget {
  const AppointmentScheduleWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ManageSchedulesBloc>()
        ..add(LoadServices())
        ..add(LoadSchedules()),
      child: const ManageSchedulesContent(),
    );
  }
}

class ManageSchedulesContent extends StatelessWidget {
  const ManageSchedulesContent({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ManageSchedulesBloc>();

    return CommonPageBody(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SchedulesHeader(
            onCreateSchedule: () =>
                CreateServiceSlotsBottomSheet.showCreateServiceSlotsModal(
                  context,
                ),
            onCloseDate: cubit.close,
          ),
          16.0.height,
          16.0.height,
          if (context.isDesktop)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(flex: 4, child: ScheduleCalendarCard()),
                20.0.width,
                const Expanded(flex: 5, child: DailyTimeSlotsList()),
              ],
            )
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                ScheduleCalendarCard(),
                SizedBox(height: 16),
                // DailyTimeSlotsList(),
              ],
            ),
          20.0.height,
        ],
      ),
    );
  }
}
