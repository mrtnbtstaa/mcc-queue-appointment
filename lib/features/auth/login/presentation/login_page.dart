import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../core/di/injector.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auth_header.dart';
import '../../../../core/widgets/common_scaffold.dart';
import 'cubit/login_cubit.dart';
import 'widgets/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<LoginCubit>(),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatelessWidget {
  const _LoginView();

  @override
  Widget build(BuildContext context) {
    return const CommonScaffold(
      backgroundColor: TAppColors.background,
      appBar: AuthHeader(),
      maxContentWidth: 460.0,
      body: LoginForm(),
    );
  }
}
