import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../../../core/extensions/double_extension.dart';
import '../../../../../../core/router/app_routes.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/common_text.dart';
import '../../../../shared/profile/domain/entities/profile_entity.dart';

class StudentRecordCard extends StatelessWidget {
  final ProfileEntity student;
  const StudentRecordCard({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    final isActive = student.isActive;
    final academicDetails = [
      if (student.course.isNotEmpty) student.course.toUpperCase(),
      if (student.yearLevel.isNotEmpty) 'Year ${student.yearLevel}',
    ].join(' • ');
    return InkWell(
      onTap: () => context.pushNamed(
        AppRoutes.staffStudentDetailName,
        pathParameters: {'id': student.id},
      ),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: TAppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border(
            left: BorderSide(
              color: isActive ? TAppColors.success : TAppColors.errorIcon,
              width: 4,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundColor: TAppColors.border,
                  child: Icon(Icons.person, color: TAppColors.textSecondary),
                ),
                10.0.width,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText(
                        text: student.name.isEmpty
                            ? 'Unnamed student'
                            : student.name,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        maxLine: 1,
                        textOverFlow: TextOverflow.ellipsis,
                      ),
                      2.0.height,
                      if (student.studentId.isNotEmpty) ...[
                        CommonText(
                          text: 'ID: ${student.studentId}',
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          fontColor: TAppColors.textSecondary,
                        ),
                        2.0.height,
                      ],
                      CommonText(
                        text: student.email,
                        fontSize: 11,
                        fontColor: TAppColors.textHint,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: isActive ? TAppColors.successBg : TAppColors.errorBg,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: CommonText(
                    text: isActive ? 'Active' : 'Inactive',
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    fontColor: isActive
                        ? TAppColors.success
                        : TAppColors.errorIcon,
                  ),
                ),
              ],
            ),
            if (academicDetails.isNotEmpty) ...[
              const Divider(height: 20),
              Row(
                children: [
                  const Icon(
                    Icons.school,
                    size: 12,
                    color: TAppColors.textHint,
                  ),
                  4.0.width,
                  CommonText(
                    text: academicDetails,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
