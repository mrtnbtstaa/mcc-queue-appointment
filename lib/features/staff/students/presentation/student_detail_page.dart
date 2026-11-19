import 'package:material_ui/material_ui.dart';

import '../../../../core/constants/academic_options.dart';
import '../../../../core/di/injector.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/extensions/string_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/common_dropdown_field.dart';
import '../../../../core/widgets/common_elevated_button.dart';
import '../../../../core/widgets/common_page_body.dart';
import '../../../../core/widgets/common_snackbar.dart';
import '../../../../core/widgets/common_text.dart';
import '../../../../core/widgets/common_text_field.dart';
import '../../../shared/profile/domain/entities/profile_entity.dart';
import '../../../shared/profile/domain/usecases/get_user.dart';
import '../../../shared/profile/domain/usecases/update_user.dart';

class StudentDetailPage extends StatefulWidget {
  final String id;

  const StudentDetailPage({super.key, required this.id});

  @override
  State<StudentDetailPage> createState() => _StudentDetailPageState();
}

class _StudentDetailPageState extends State<StudentDetailPage> {
  late final Future result = getIt<GetUser>()(GetUserParams(widget.id));

  @override
  Widget build(BuildContext context) => CommonPageBody(
    child: FutureBuilder(
      future: result,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          return const Center(child: CircularProgressIndicator());
        }
        return snapshot.data!.fold(
          (failure) => Center(child: Text(failureMessage(failure))),
          (profile) => _StudentDetailsEditor(profile: profile),
        );
      },
    ),
  );
}

class _StudentDetailsEditor extends StatefulWidget {
  const _StudentDetailsEditor({required this.profile});

  final ProfileEntity profile;

  @override
  State<_StudentDetailsEditor> createState() => _StudentDetailsEditorState();
}

class _StudentDetailsEditorState extends State<_StudentDetailsEditor> {
  final _formKey = GlobalKey<FormState>();
  late final _nameController = TextEditingController(text: widget.profile.name);
  late final _studentIdController = TextEditingController(
    text: widget.profile.studentId,
  );
  late final _emailController = TextEditingController(
    text: widget.profile.email,
  );
  late String? _course = normalizeAcademicValue(
    courseOptions,
    widget.profile.course,
  );
  late String? _yearLevel = normalizeAcademicValue(
    yearLevelOptions,
    widget.profile.yearLevel,
  );
  late ProfileEntity _profile = widget.profile;
  bool _isActive = false;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _isActive = widget.profile.isActive;
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSaving = true);
    final result = await getIt<UpdateUser>()(
      UpdateUserParams(
        id: _profile.id,
        name: _nameController.text.trim(),
        studentId: _studentIdController.text.trim(),
        email: _emailController.text.trim(),
        course: _course ?? '',
        yearLevel: _yearLevel ?? '',
        isActive: _isActive,
      ),
    );
    if (!mounted) return;
    result.fold(
      (failure) {
        setState(() => _isSaving = false);
        CommonSnackbar.showError(context, failureMessage(failure));
      },
      (updated) {
        setState(() {
          _profile = updated;
          _isActive = updated.isActive;
          _nameController.text = updated.name;
          _studentIdController.text = updated.studentId;
          _emailController.text = updated.email;
          _course = normalizeAcademicValue(courseOptions, updated.course);
          _yearLevel = normalizeAcademicValue(
            yearLevelOptions,
            updated.yearLevel,
          );
          _isSaving = false;
        });
        CommonSnackbar.showSuccess(context, 'Student information updated.');
      },
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _studentIdController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Form(
    key: _formKey,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CommonText(
          text: 'Manage Student',
          fontSize: 22,
          fontWeight: FontWeight.bold,
          fontColor: TAppColors.textPrimary,
        ),
        CommonText(
          text: 'Update account information and access status.',
          fontColor: TAppColors.textSecondary,
        ),
        const SizedBox(height: 20),
        CommonTextField(
          labelText: 'Full name',
          controller: _nameController,
          validator: _requiredField('Enter the student’s full name.'),
        ),
        const SizedBox(height: 12),
        CommonTextField(
          labelText: 'Student ID',
          controller: _studentIdController,
          validator: _requiredField('Enter the student ID.'),
        ),
        const SizedBox(height: 12),
        CommonTextField(
          labelText: 'Email',
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            final email = value?.trim() ?? '';
            if (email.isEmpty) return 'Email is required.';
            if (!email.isValidEmail) return 'Enter a valid email address.';
            return null;
          },
        ),
        const SizedBox(height: 12),
        CommonDropdownField<String>(
          labelText: 'Course',
          value: _course,
          hintText: 'Select course',
          items: _dropdownItems(courseOptions, _course),
          onChanged: (value) => setState(() => _course = value),
          validator: (value) =>
              value == null || value.isEmpty ? 'Select a course.' : null,
        ),
        const SizedBox(height: 12),
        CommonDropdownField<String>(
          labelText: 'Year level',
          value: _yearLevel,
          hintText: 'Select year level',
          items: _dropdownItems(yearLevelOptions, _yearLevel),
          onChanged: (value) => setState(() => _yearLevel = value),
          validator: (value) =>
              value == null || value.isEmpty ? 'Select a year level.' : null,
        ),
        const SizedBox(height: 12),
        SwitchListTile.adaptive(
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          title: const Text('Student account active'),
          subtitle: Text(_isActive ? 'Active' : 'Inactive'),
          value: _isActive,
          onChanged: _isSaving
              ? null
              : (value) => setState(() => _isActive = value),
          activeTrackColor: TAppColors.success,
        ),
        const SizedBox(height: 16),
        CommonElevatedButton(
          text: _isSaving ? 'Saving...' : 'Save Changes',
          height: 48,
          onButtonPressed: _isSaving ? null : _save,
        ),
      ],
    ),
  );

  FormFieldValidator<String> _requiredField(String message) =>
      (value) => value == null || value.trim().isEmpty ? message : null;

  /// Keeps a stored value selectable even when it is not in the backend list.
  List<DropdownMenuItem<String>> _dropdownItems(
    List<AcademicOption> options,
    String? selected,
  ) {
    return [
      for (final option in options)
        DropdownMenuItem(value: option.value, child: Text(option.label)),
      if (selected != null &&
          selected.isNotEmpty &&
          !options.any((option) => option.value == selected))
        DropdownMenuItem(value: selected, child: Text(selected)),
    ];
  }
}
