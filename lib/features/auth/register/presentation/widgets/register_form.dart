import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../../core/extensions/double_extension.dart';
import '../../../../../core/extensions/string_extension.dart';
import '../../../../../core/router/app_routes.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/common_dropdown_field.dart';
import '../../../../../core/widgets/common_elevated_button.dart';
import '../../../../../core/widgets/common_text.dart';
import '../../../../../core/widgets/common_text_field.dart';
import '../../domain/failures/register_failure.dart';
import '../cubit/register_cubit.dart';
import '../cubit/register_state.dart';
import 'password_strength_indicator.dart';

enum Course {
  bsit('bsit', 'BSIT', 'Bachelor of Science in Information Technology'),
  bshm('bshm', 'BSHM', 'Bachelor of Science in Hospitality Management'),
  bstm('bstm', 'BSTM', 'Bachelor of Science in Tourism Management'),
  bsa('bsa', 'BSA', 'Bachelor of Science in Accountancy'),
  bsca('bsca', 'BSCA', 'Bachelor of Science in Customs Administration'),
  bse('bse', 'BSE', 'Bachelor of Science in Entrepreneurship'),
  bsma('bsma', 'BSMA', 'Bachelor of Science in Management Accounting'),
  bsoa('bsoa', 'BSOA', 'Bachelor of Science in Office Administration'),
  beed('beed', 'BEED', 'Bachelor of Elementary Education'),
  beced('beced', 'BECED', 'Bachelor of Early Childhood Education'),
  bsedEnglish(
    'bsed-english',
    'BSED',
    'Bachelor of Secondary Education, major in English',
  ),
  bsedFilipino(
    'bsed-filipino',
    'BSED',
    'Bachelor of Secondary Education, major in Filipino',
  ),
  bsedMath(
    'bsed-math',
    'BSED',
    'Bachelor of Secondary Education, major in Mathematics',
  ),
  bsedScience(
    'bsed-science',
    'BSED',
    'Bachelor of Secondary Education, major in Science',
  ),
  bsedSocialStudies(
    'bsed-social-studies',
    'BSED',
    'Bachelor of Secondary Education, major in Social Studies',
  ),
  bped('bped', 'BPED', 'Bachelor of Physical Education'),
  btvte('btvte', 'BTVTE', 'Bachelor of Technical-Vocational Teacher Education'),
  abHistory('ab-history', 'AB History', 'Bachelor of Arts in History'),
  abPsychology(
    'ab-psychology',
    'AB Psychology',
    'Bachelor of Arts in Psychology',
  ),
  bpa('bpa', 'BPA', 'Bachelor of Public Administration'),
  bsBio('bsbio', 'BSBIO', 'Bachelor of Science in Biology'),
  bsLm('bslm', 'BSLM', 'Bachelor of Science in Legal Management');

  final String value;
  final String code;
  final String description;

  const Course(this.value, this.code, this.description);
}

/// Single, self-contained register form.
class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key, required this.cubit});

  final RegisterCubit cubit;

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  final _studentIdController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String? _selectedCourse;
  String? _selectedYearLevel;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  String _passwordStrengthText = '';
  double _passwordStrengthScore = 0.0;

  bool get _passwordsMatch =>
      _confirmPasswordController.text.isNotEmpty &&
      _confirmPasswordController.text == _passwordController.text;

  @override
  void dispose() {
    _studentIdController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onPasswordChanged(String password) {
    final hasMinLength = password.length >= 8;
    final hasUppercase = password.contains(RegExp(r'[A-Z]'));
    final hasLowercase = password.contains(RegExp(r'[a-z]'));
    final hasDigits = password.contains(RegExp(r'[0-9]'));
    final hasSpecial = password.contains(
      RegExp(r'[!@#$%^&*(),.?":{}|<>_\-\\/\[\];~`+=]'),
    );

    final missing = <String>[
      if (!hasUppercase) 'an uppercase letter',
      if (!hasLowercase) 'a lowercase letter',
      if (!hasDigits) 'a number',
      if (!hasSpecial) 'a special character',
    ];

    late final String text;
    late final double score;

    if (password.isEmpty) {
      text = '';
      score = 0.0;
    } else if (!hasMinLength) {
      text = 'Weak: Must be at least 8 characters';
      score = 0.33;
    } else if (missing.isEmpty) {
      text =
          'Strong: Contains uppercase, lowercase, numbers & special character';
      score = 1.0;
    } else if (missing.length <= 2) {
      text = 'Medium: Add ${missing.join(' and ')}';
      score = 0.66;
    } else {
      text = 'Weak: Add ${missing.first} and more variety';
      score = 0.33;
    }

    setState(() {
      _passwordStrengthText = text;
      _passwordStrengthScore = score;
    });
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedCourse == null || _selectedYearLevel == null) return;

    widget.cubit.submit(
      studentId: _studentIdController.text,
      fullName: _nameController.text,
      course: _selectedCourse!,
      email: _emailController.text,
      password: _passwordController.text,
      confirmPassword: _confirmPasswordController.text,
      yearLevel: _selectedYearLevel!,
    );
  }

  String _messageFor(RegisterFailure failure) => switch (failure) {
    // Added TermsNotAgreed() back to make the switch exhaustive
    PasswordsDoNotMatch() => 'Passwords do not match.',
    EmailAlreadyRegistered(:final message) =>
      message ?? 'This email is already registered.',
    WeakPassword(:final message) => message ?? 'Password is too weak.',
    ValidationFailure(:final fieldErrors, :final message) =>
      fieldErrors.isNotEmpty
          ? fieldErrors.values.join(', ')
          : message ?? 'Please fix the highlighted fields.',
    NetworkFailure() => 'No connection. Try again.',
    ServerFailure(:final message) => message ?? 'Server error. Try again.',
    UnknownFailure(:final message) =>
      message ?? 'Something went wrong. Try again.',
  };

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      bloc: widget.cubit,
      listener: (context, state) {
        if (state is RegisterSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Account created. Please sign in.')),
          );
        }

        context.go(AppRoutes.loginPath);
      },
      builder: (context, state) {
        final isSubmitting = state is RegisterSubmitting;
        final failure = state is RegisterError ? (state).failure : null;

        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Student ID ────────────────────────────────────────
              Wrap(
                spacing: 8,
                runSpacing: 2,
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  CommonText(
                    text: 'Student ID Number',
                    fontColor: TAppColors.textPrimary,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                  ),
                  CommonText(
                    text: 'Required for verification',
                    fontColor: TAppColors.errorIcon,
                    fontSize: 11,
                  ),
                ],
              ),
              6.0.height,
              CommonTextField(
                hintText: '2023-01492',
                controller: _studentIdController,
                prefixIcon: Icon(
                  Icons.badge_outlined,
                  size: 18,
                  color: TAppColors.textHint,
                ),
                validator: (v) => (v?.trim().isEmpty ?? true)
                    ? 'Student ID is required'
                    : null,
              ),
              14.0.height,

              // ── Full name ─────────────────────────────────────────
              CommonText(
                text: 'Full Name',
                fontColor: TAppColors.textPrimary,
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
              ),
              6.0.height,
              CommonTextField(
                hintText: 'Juan Dela Cruz',
                controller: _nameController,
                prefixIcon: Icon(
                  Icons.person_outline,
                  size: 18,
                  color: TAppColors.textHint,
                ),
                validator: (v) =>
                    (v?.trim().isEmpty ?? true) ? 'Name is required' : null,
              ),
              14.0.height,

              // ── Email ─────────────────────────────────────────────
              CommonText(
                text: 'Email Address',
                fontColor: TAppColors.textPrimary,
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
              ),
              6.0.height,
              CommonTextField(
                hintText: 'juan.delacruz@mcc.edu.ph',
                controller: _emailController,
                prefixIcon: const Icon(
                  Icons.alternate_email,
                  size: 18,
                  color: TAppColors.textHint,
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (v) {
                  final value = v?.trim() ?? '';
                  if (value.isEmpty) return 'Email is required';
                  if (!value.isValidEmail) return 'Enter a valid email address';
                  return null;
                },
              ),
              14.0.height,

              // ── Course ────────────────────────────────────────────
              CommonText(
                text: 'Course / Program',
                fontColor: TAppColors.textPrimary,
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
              ),
              6.0.height,
              CommonDropdownField<String>(
                value: _selectedCourse,
                hintText: 'Select course',
                prefixIcon: Icons.school_outlined,
                items: Course.values.map((course) {
                  return DropdownMenuItem<String>(
                    value: course.value,
                    child: Text(
                      '${course.code} - ${course.description}',
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }).toList(),
                onChanged: (v) => setState(() => _selectedCourse = v),
                validator: (v) => v == null ? 'Select a course' : null,
              ),
              14.0.height,

              // ── Year level ────────────────────────────────────────
              CommonText(
                text: 'Year Level',
                fontColor: TAppColors.textPrimary,
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
              ),
              6.0.height,
              CommonDropdownField<String>(
                value: _selectedYearLevel,
                hintText: 'Select year level',
                prefixIcon: Icons.star_outline,
                items: List.generate(
                  4,
                  (index) => DropdownMenuItem<String>(
                    value: '${index + 1}', // FIX: Convert to String ("1", "2", "3", "4")
                    child: Text('${index + 1}'),
                  ),
                ),
                onChanged: (v) => setState(() => _selectedYearLevel = v),
                validator: (v) => v == null ? 'Select a year level' : null,
              ),
              14.0.height,

              // ── Password ──────────────────────────────────────────
              CommonText(
                text: 'Password',
                fontColor: TAppColors.textPrimary,
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
              ),
              6.0.height,
              CommonTextField(
                hintText: '••••••••••••••••',
                controller: _passwordController,
                obscureText: _obscurePassword,
                onChanged: _onPasswordChanged,
                prefixIcon: Icon(
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
                validator: (v) => (v ?? '').isEmpty
                    ? 'Password is required'
                    : (v!.length < 8
                          ? 'Password must be at least 8 characters'
                          : null),
              ),
              if (_passwordStrengthText.isNotEmpty) ...[
                8.0.height,
                PasswordStrengthIndicator(
                  score: _passwordStrengthScore,
                  strengthText: _passwordStrengthText,
                ),
              ],
              14.0.height,

              // ── Confirm password ──────────────────────────────────
              CommonText(
                text: 'Confirm Password',
                fontColor: TAppColors.textPrimary,
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
              ),
              6.0.height,
              CommonTextField(
                hintText: '••••••••••••••••',
                controller: _confirmPasswordController,
                borderColor: _passwordsMatch ? TAppColors.success : null,
                obscureText: _obscureConfirmPassword,
                onChanged: (_) => setState(() {}),
                prefixIcon: Icon(
                  Icons.lock_outline,
                  size: 18,
                  color: TAppColors.textHint,
                ),
                suffixIcon: Icon(
                  _obscureConfirmPassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  size: 18,
                  color: TAppColors.textMuted,
                ),
                onSuffixPressed: () => setState(
                  () => _obscureConfirmPassword = !_obscureConfirmPassword,
                ),
                validator: (v) {
                  if ((v ?? '').isEmpty) return 'Please confirm your password';
                  if (v != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              16.0.height,

              if (failure != null && failure is! ValidationFailure)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: CommonText(
                    text: _messageFor(failure),
                    fontColor: TAppColors.errorIcon,
                    fontSize: 12,
                  ),
                ),

              SizedBox(
                width: double.infinity,
                child: CommonElevatedButton(
                  onButtonPressed: isSubmitting ? null : _submit,
                  custom: isSubmitting
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: TAppColors.surface,
                          ),
                        )
                      : const Text(
                          'Create account',
                          style: TextStyle(
                            color: TAppColors.surface,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),

              24.0.height,

              Center(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 4,
                  children: [
                    CommonText(
                      text: 'Already have an account?',
                      fontColor: TAppColors.textSecondary, // Dark gray
                      fontSize: 13.5,
                    ),
                    GestureDetector(
                      onTap: () => context.go(AppRoutes.loginPath),
                      child: CommonText(
                        text: 'Log in',
                        fontColor: TAppColors.primary, // Maroon color
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
