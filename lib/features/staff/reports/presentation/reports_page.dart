import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../../../core/di/injector.dart';
import '../../../../../../core/network/api_client.dart';
import '../../../../../../core/widgets/common_page_body.dart';
import '../../../../../../core/widgets/common_snackbar.dart';
import 'cubit/reports_cubit.dart';
import 'cubit/reports_state.dart';
import 'widgets/report_parameters_card.dart';
import 'widgets/reports_header_card.dart';

class RegistrarReportsWrapper extends StatelessWidget {
  const RegistrarReportsWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegistrarReportsCubit(getIt<ApiClient>()),
      child: const RegistrarReportsPage(),
    );
  }
}

class RegistrarReportsPage extends StatelessWidget {
  const RegistrarReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegistrarReportsCubit, RegistrarReportsState>(
      listenWhen: (previous, current) =>
          previous.error != current.error && current.error != null ||
          previous.successMessage != current.successMessage &&
              current.successMessage != null,
      listener: (context, state) {
        if (state.error != null) {
          CommonSnackbar.showError(context, state.error!);
        } else if (state.successMessage != null) {
          CommonSnackbar.showSuccess(context, state.successMessage!);
        }
      },
      child: CommonPageBody(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            ReportsHeaderCard(),
            SizedBox(height: 16),
            ReportParametersCard(),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
