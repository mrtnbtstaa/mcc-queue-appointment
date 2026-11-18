import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../../../core/di/injector.dart';
import '../../../../../../core/extensions/context_extension.dart';
import '../../../../../../core/extensions/double_extension.dart';
import '../../../../../../core/widgets/common_page_body.dart';
import '../../../../../shared/appointment_schedules/presentation/bloc/manage_schedules_bloc.dart';
import '../../../../../shared/appointment_schedules/presentation/bloc/manage_schedules_event.dart';
import 'widgets/appointment_calendar.dart';
import 'widgets/appointment_header.dart';

class AppointmentScheduleStudentWrapper extends StatelessWidget {
  const AppointmentScheduleStudentWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ManageSchedulesBloc>()..add(LoadSchedules()),
      child: AppointmentSchedulesContent(),
    );
  }
}

class AppointmentSchedulesContent extends StatelessWidget {
  const AppointmentSchedulesContent({super.key});

  @override
  Widget build(BuildContext context) {
    const calendar = AppointmentCalendar();

    final slots = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // const AvailableSlotsList(),
        20.0.height,
        // const UpcomingAppointmentsList(),
      ],
    );

    return CommonPageBody(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const AppointmentHeader(),
          16.0.height,
          if (context.isDesktop)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 4, child: calendar),
                20.0.width,
                Expanded(flex: 5, child: slots),
              ],
            )
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [calendar, 16.0.height, slots],
            ),
          20.0.height,
          // const AppointmentBottomBar(),
          20.0.height,
        ],
      ),
    );
  }
}
