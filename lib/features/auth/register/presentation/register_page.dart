import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../core/di/injector.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auth_header.dart';
import '../../../../core/widgets/common_scaffold.dart';
import 'cubit/register_cubit.dart';
import 'widgets/register_form.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<RegisterCubit>(),
      child: const _RegisterView(),
    );
  }
}

class _RegisterView extends StatelessWidget {
  const _RegisterView();

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      backgroundColor: TAppColors.background,
      appBar: AuthHeader(),
      maxContentWidth: 480.0,
      body: RegisterForm(cubit: getIt<RegisterCubit>()),
    );
  }
}
