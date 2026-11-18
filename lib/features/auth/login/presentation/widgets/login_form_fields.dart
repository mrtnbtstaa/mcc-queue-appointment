import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../../core/auth/auth_state.dart';
import '../../../../../core/di/injector.dart';
import '../../../../../core/extensions/double_extension.dart';
import '../../../../../core/router/app_routes.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/common_elevated_button.dart';
import '../../../../../core/widgets/common_text.dart';
import '../../../../../core/widgets/common_text_field.dart';
import '../../domain/failures/login_failure.dart';
import '../cubit/login_cubit.dart';
import '../cubit/login_state.dart';
import 'freshmen_activation_card.dart';
import 'login_error_banner.dart';

class LoginFormFields extends StatefulWidget {
  const LoginFormFields({super.key, required this.cubit});

  final LoginCubit cubit;

  @override
  State<LoginFormFields> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginFormFields> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    widget.cubit.submit(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      bloc: widget.cubit,

      // ── Listener: React to success ─────────────────────────────────
      listener: (context, state) {
        if (state is LoginSuccess) {
          // Dismiss the keyboard before navigating
          FocusManager.instance.primaryFocus?.unfocus();

          // Because AuthState has been updated, the router *could* handle this.
          // But explicitly navigating here gives a smoother UX and allows
          // us to show a success Snackbar if we want.
          final role = getIt<AuthState>().role;

          if (role == UserRole.staff) {
            context.go(AppRoutes.staffHomePath);
          } else {
            context.go(AppRoutes.studentHomePath);
          }
        }
      },

      // ── Builder: Render the UI ─────────────────────────────────────
      builder: (context, state) {
        final isSubmitting = state is LoginSubmitting || state is LoginSuccess;
        final failure = state is LoginError ? state.failure : null;

        if (kDebugMode && failure != null) {
          print("Login Failure: $failure");
        }

        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Error Banner ──────────────────────────────────────
              if (failure != null) ...[
                LoginErrorBanner(
                  message: _messageFor(failure),
                  onDismiss: () {
                    widget.cubit.resetError();
                  },
                ),
                14.0.height,
              ],

              // ── Email Field ───────────────────────────────────────
              CommonTextField(
                labelText: 'Email or Student ID',
                hintText: 'juan.delacruz@mcc.edu.ph',
                controller: _emailController,
                prefixIcon: const Icon(
                  Icons.alternate_email,
                  size: 18,
                  color: TAppColors.textHint,
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your email or student ID';
                  }
                  return null;
                },
              ),
              14.0.height,

              // ── Password Field ────────────────────────────────────
              CommonTextField(
                labelText: 'Password',
                hintText: '••••••••••••••••',
                controller: _passwordController,
                obscureText: _obscurePassword,
                prefixIcon: const Icon(
                  Icons.lock_outline,
                  size: 18,
                  color: TAppColors.textHint,
                ),
                suffixIcon: Icon(
                  _obscurePassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  size: 18,
                  color: TAppColors.textMuted,
                ),
                onSuffixPressed: () =>
                    setState(() => _obscurePassword = !_obscurePassword),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              20.0.height,

              // ── Login Button ──────────────────────────────────────
              CommonElevatedButton(
                onButtonPressed: isSubmitting ? null : _submit,
                borderRadius: 10.0,
                elevatedPadding: const EdgeInsets.symmetric(vertical: 13),
                custom: isSubmitting
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: TAppColors.surface,
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.login,
                            size: 18,
                            color: TAppColors.surface,
                          ),
                          8.0.width,
                          CommonText(
                            text: 'Log In',
                            fontColor: TAppColors.surface,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
              ),
              18.0.height,

              // ── Divider ───────────────────────────────────────────
              Row(
                children: [
                  Expanded(child: Divider(color: TAppColors.border)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: CommonText(
                      text: 'OR',
                      fontColor: TAppColors.textHint,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(child: Divider(color: TAppColors.border)),
                ],
              ),
              18.0.height,

              // ── Create Account ────────────────────────────────────
              FreshmenActivationCard(
                onCreateAccount: () {
                  context.pushReplacementNamed(AppRoutes.registerName);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  String _messageFor(LoginFailure failure) => switch (failure) {
    InvalidCredentials(:final message) =>
      message ?? 'Invalid email or password.',
    AccountNotVerified(:final message) =>
      message ?? 'Please verify your account first.',
    NetworkFailure() => 'No connection. Try again.',
    ServerFailure(:final message) => message ?? 'Server error. Try again.',
    UnknownFailure(:final message) =>
      message ?? 'Something went wrong. Try again.',
  };
}
