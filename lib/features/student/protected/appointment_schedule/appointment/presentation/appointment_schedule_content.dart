import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../../../core/di/injector.dart';
import '../../../../../../core/extensions/double_extension.dart';
import '../../../../../../core/widgets/common_page_body.dart';
import '../../../../../shared/appointments/presentation/bloc/appointment_bloc.dart';
import '../../../../../shared/appointments/presentation/bloc/appointment_event.dart';
import '../../../../../shared/appointment_schedules/presentation/bloc/manage_schedules_bloc.dart';
import '../../../../../shared/appointment_schedules/presentation/bloc/manage_schedules_event.dart';
import 'widgets/appointment_calendar.dart';
import 'widgets/appointment_header.dart';
import 'widgets/student_appointments_list.dart';

class AppointmentScheduleStudentWrapper extends StatelessWidget {
  const AppointmentScheduleStudentWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<ManageSchedulesBloc>()..add(LoadSchedules()),
        ),
        BlocProvider(
          create: (_) =>
              getIt<AppointmentBloc>()..add(const GetAppointmentsEvent()),
        ),
      ],
      child: const AppointmentSchedulesContent(),
    );
  }
}

class AppointmentSchedulesContent extends StatelessWidget {
  const AppointmentSchedulesContent({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonPageBody(
      maxWidth: 1280,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const AppointmentHeader(),
          16.0.height,
          LayoutBuilder(
            builder: (context, constraints) => constraints.maxWidth >= 960
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 5,
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 560),
                            child: const AppointmentCalendar(),
                          ),
                        ),
                      ),
                      20.0.width,
                      const Expanded(flex: 6, child: StudentAppointmentsList()),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 560),
                          child: const AppointmentCalendar(),
                        ),
                      ),
                      20.0.height,
                      const StudentAppointmentsList(),
                    ],
                  ),
          ),
          20.0.height,
        ],
      ),
    );
  }
}
