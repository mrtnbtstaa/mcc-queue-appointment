import 'package:material_ui/material_ui.dart';

import '../../../../core/di/injector.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/common_page_body.dart';
import '../../../../core/widgets/common_text.dart';
import '../../../../core/widgets/common_text_field.dart';
import '../../../shared/profile/domain/entities/profile_entity.dart';
import '../../../shared/profile/domain/usecases/get_user.dart';

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
          _details,
        );
      },
    ),
  );

  Widget _details(ProfileEntity student) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      CommonText(
        text: 'Manage Profile',
        fontSize: 22,
        fontWeight: FontWeight.bold,
        fontColor: TAppColors.textPrimary,
      ),
      CommonText(
        text: '${student.role} - ${student.isActive ? 'Active' : 'Inactive'}',
        fontColor: TAppColors.textSecondary,
      ),
      const SizedBox(height: 20),
      _field('Full name', student.name),
      _field('Student ID', student.studentId),
      _field('Email', student.email),
      _field('Course', student.course),
      _field('Year level', student.yearLevel),
    ],
  );

  Widget _field(String label, String value) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: CommonTextField(
      labelText: label,
      initialValue: value,
      readOnly: true,
      suffixIcon: const Icon(Icons.lock_outline, size: 16),
    ),
  );
}
