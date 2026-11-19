import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../core/di/injector.dart';
import '../../../../core/extensions/string_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/common_elevated_button.dart';
import '../../../../core/widgets/common_filter_chips.dart';
import '../../../../core/widgets/common_page_body.dart';
import '../../../../core/widgets/common_text.dart';
import '../../../../core/widgets/common_text_field.dart';
import '../domain/entities/profile_entity.dart';
import 'cubit/profile_cubit.dart';
import 'cubit/profile_state.dart';

class ProfileWrapper extends StatelessWidget {
  const ProfileWrapper({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => getIt<ProfileCubit>()..loadProfile(),
    child: const ProfilePage(),
  );
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _emailFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) => BlocBuilder<ProfileCubit, ProfileState>(
    builder: (context, state) {
      final profile = state.profile;
      if (state.isLoading && profile == null) {
        return const Center(child: CircularProgressIndicator());
      }
      if (profile == null) {
        return CommonPageBody(
          child: Center(
            child: CommonText(text: state.error ?? 'Unable to load profile.'),
          ),
        );
      }

      final cubit = context.read<ProfileCubit>();
      if (profile.role.toLowerCase() == 'student') {
        return _StudentProfileView(
          profile: profile,
          state: state,
          cubit: cubit,
        );
      }
      return CommonPageBody(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CommonText(
              text: 'Manage Profile',
              fontSize: 22,
              fontWeight: FontWeight.bold,
              fontColor: TAppColors.textPrimary,
            ),
            const SizedBox(height: 16),
            if (state.error != null) _Message(state.error!, isError: true),
            if (state.successMessage != null) _Message(state.successMessage!),
            CommonText(
              text: profile.name,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontColor: TAppColors.textPrimary,
            ),
            CommonText(
              text:
                  '${profile.role} - ${profile.isActive ? 'Active' : 'Inactive'}',
              fontColor: TAppColors.textSecondary,
            ),
            if (profile.studentId.isNotEmpty)
              CommonText(text: 'Student ID: ${profile.studentId}'),
            const SizedBox(height: 20),
            Form(
              key: _emailFormKey,
              child: CommonTextField(
                controller: cubit.emailController,
                keyboardType: TextInputType.emailAddress,
                labelText: 'Email',
                validator: (value) {
                  final email = value?.trim() ?? '';
                  if (email.isEmpty) return 'Email is required';
                  if (!email.isValidEmail) {
                    return 'Enter a valid email address';
                  }
                  return null;
                },
              ),
            ),
            if (profile.role.toLowerCase() == 'student') ...[
              const SizedBox(height: 12),
              CommonTextField(
                controller: cubit.courseController,
                labelText: 'Course',
              ),
              const SizedBox(height: 12),
              CommonTextField(
                controller: cubit.yearLevelController,
                labelText: 'Year level',
              ),
            ],
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: CommonElevatedButton(
                onButtonPressed: state.isSaving
                    ? null
                    : () {
                        if (!(_emailFormKey.currentState?.validate() ??
                            false)) {
                          return;
                        }
                        cubit.saveChanges();
                      },
                text: 'Save profile',
                fontSize: 13,
              ),
            ),
            const Divider(height: 40),
            CommonText(
              text: 'Change password',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontColor: TAppColors.textPrimary,
            ),
            const SizedBox(height: 12),
            _ChangePasswordForm(
              cubit: cubit,
              isSaving: state.isChangingPassword,
            ),
          ],
        ),
      );
    },
  );
}

class _StudentProfileView extends StatelessWidget {
  final ProfileEntity profile;
  final ProfileState state;
  final ProfileCubit cubit;

  const _StudentProfileView({
    required this.profile,
    required this.state,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) => CommonPageBody(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (state.error != null) _Message(state.error!, isError: true),
        if (state.successMessage != null) _Message(state.successMessage!),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: TAppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: TAppColors.border),
          ),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: TAppColors.primary,
                child: CommonText(
                  text: profile.name
                      .split(' ')
                      .where((part) => part.isNotEmpty)
                      .take(2)
                      .map((part) => part[0])
                      .join()
                      .toUpperCase(),
                  fontColor: TAppColors.surface,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      text: 'Manage Profile',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontColor: TAppColors.textPrimary,
                    ),
                    CommonText(
                      text: profile.name,
                      fontColor: TAppColors.textSecondary,
                    ),
                    CommonText(
                      text:
                          'ID: ${profile.studentId} • ${profile.course.toUpperCase()} - ${profile.yearLevel}',
                      fontColor: TAppColors.textMuted,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        CommonFilterChips(
          items: const [
            FilterChipItem(icon: Icons.person_outline, label: 'Personal Info'),
            FilterChipItem(icon: Icons.lock_outline, label: 'Account Security'),
          ],
          selectedFilterIndex: state.activeTab == ProfileTab.personalInfo
              ? 0
              : 1,
          onFilterChanged: (index) => cubit.changeTab(
            index == 0 ? ProfileTab.personalInfo : ProfileTab.accountSecurity,
          ),
        ),
        const SizedBox(height: 16),
        if (state.activeTab == ProfileTab.personalInfo) ...[
          _ReadOnlyProfileSection(
            title: 'Official Academic Records',
            fields: [
              ('Full Name', profile.name),
              ('Student ID Number', profile.studentId),
              ('Course / Program', profile.course),
              ('Year Level', profile.yearLevel),
            ],
          ),
          const SizedBox(height: 16),
          _ReadOnlyProfileSection(
            title: 'Contact Details',
            fields: [('Institutional / Active Email', profile.email)],
          ),
        ] else ...[
          CommonText(
            text: 'Change your account password.',
            fontColor: TAppColors.textSecondary,
          ),
          const SizedBox(height: 12),
          _ChangePasswordForm(cubit: cubit, isSaving: state.isChangingPassword),
        ],
      ],
    ),
  );
}

class _ReadOnlyProfileSection extends StatelessWidget {
  final String title;
  final List<(String, String)> fields;

  const _ReadOnlyProfileSection({required this.title, required this.fields});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: TAppColors.surface,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: TAppColors.border),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CommonText(
          text: title,
          fontSize: 14,
          fontWeight: FontWeight.bold,
          fontColor: TAppColors.textPrimary,
        ),
        const SizedBox(height: 12),
        for (final (label, value) in fields) ...[
          CommonTextField(
            labelText: label,
            initialValue: value,
            readOnly: true,
            suffixIcon: const Icon(Icons.lock_outline, size: 16),
          ),
          const SizedBox(height: 12),
        ],
      ],
    ),
  );
}

class _ChangePasswordForm extends StatefulWidget {
  final ProfileCubit cubit;
  final bool isSaving;

  const _ChangePasswordForm({required this.cubit, required this.isSaving});

  @override
  State<_ChangePasswordForm> createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<_ChangePasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final _current = TextEditingController();
  final _new = TextEditingController();
  final _confirm = TextEditingController();

  @override
  void dispose() {
    _current.dispose();
    _new.dispose();
    _confirm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Form(
    key: _formKey,
    child: Column(
      children: [
        CommonTextField(
          controller: _current,
          obscureText: true,
          labelText: 'Current password',
          validator: (value) =>
              (value ?? '').isEmpty ? 'Enter your current password' : null,
        ),
        const SizedBox(height: 12),
        CommonTextField(
          controller: _new,
          obscureText: true,
          labelText: 'New password',
          validator: (value) {
            final password = value ?? '';
            if (password.isEmpty) return 'Enter a new password';
            if (password.length < 8) {
              return 'Password must be at least 8 characters';
            }
            return null;
          },
        ),
        const SizedBox(height: 12),
        CommonTextField(
          controller: _confirm,
          obscureText: true,
          labelText: 'Confirm new password',
          validator: (value) {
            if ((value ?? '').isEmpty) {
              return 'Confirm your new password';
            }
            if (value != _new.text) return 'Passwords do not match';
            return null;
          },
        ),
        const SizedBox(height: 12),
        Align(
          alignment: Alignment.centerRight,
          child: CommonElevatedButton(
            onButtonPressed: widget.isSaving
                ? null
                : () async {
                    if (!(_formKey.currentState?.validate() ?? false)) {
                      return;
                    }
                    await widget.cubit.changePassword(
                      currentPassword: _current.text,
                      newPassword: _new.text,
                      confirmPassword: _confirm.text,
                    );
                    if (widget.cubit.state.successMessage ==
                        'Password changed successfully.') {
                      _current.clear();
                      _new.clear();
                      _confirm.clear();
                    }
                  },
            text: 'Change password',
            fontSize: 13,
          ),
        ),
      ],
    ),
  );
}

class _Message extends StatelessWidget {
  final String text;
  final bool isError;

  const _Message(this.text, {this.isError = false});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: CommonText(
      text: text,
      fontColor: isError ? TAppColors.errorText : TAppColors.successText,
    ),
  );
}
