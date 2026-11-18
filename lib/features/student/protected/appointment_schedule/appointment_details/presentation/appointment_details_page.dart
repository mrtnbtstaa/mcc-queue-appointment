import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../../../core/extensions/double_extension.dart';
import '../../../../../../core/widgets/common_page_body.dart';
import '../../appointment/presentation/widgets/appointment_header.dart';
import 'cubit/appointment_details_cubit.dart';
import 'widgets/appointment_actions.dart';
import 'widgets/appointment_progress_timeline.dart';
import 'widgets/appointment_ticket_card.dart';

class AppointmentDetailsWrapper extends StatelessWidget {
  const AppointmentDetailsWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppointmentSlipCubit(),
      child: AppointmentDetailsPage(),
    );
  }
}

class AppointmentDetailsPage extends StatelessWidget {
  const AppointmentDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AppointmentSlipCubit>();

    return CommonPageBody(
      maxWidth: 760,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const AppointmentHeader(),
          16.0.height,
          const AppointmentTicketCard(),
          16.0.height,
          const AppointmentProgressTimeline(),
          16.0.height,
          AppointmentActions(cubit: cubit),
          20.0.height,
        ],
      ),
    );
  }
}
