import 'package:material_ui/material_ui.dart';

import '../../../../../../core/extensions/double_extension.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/common_text.dart';

class StudentsHeaderStats extends StatelessWidget {
  final int count;
  const StudentsHeaderStats({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText(
                text: 'Registered Students',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontColor: TAppColors.textPrimary,
              ),
              SizedBox(height: 2),
              CommonText(
                text: 'Manage credentials & Institutional records',
                fontSize: 11,
                fontColor: TAppColors.textHint,
              ),
            ],
          ),
        ),
        10.0.width,
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: TAppColors.successBg,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 3,
                backgroundColor: TAppColors.success,
              ),
              const SizedBox(width: 6),
              CommonText(
                text: '$count Students',
                fontSize: 11,
                fontWeight: FontWeight.bold,
                fontColor: TAppColors.successText,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
