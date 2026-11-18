import 'package:material_ui/material_ui.dart';

import '../../../../../../core/extensions/double_extension.dart';
import '../../../../../../core/style/font.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/common_circle_avatar.dart';
import '../../../../../../core/widgets/common_text.dart';
import '../../../../../shared/transaction_history/domain/entities/transaction_entity.dart';

class TransactionStatusProgression extends StatelessWidget {
  final List<TimelineStepModel> steps;

  const TransactionStatusProgression({super.key, required this.steps});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText(
          text: 'STATUS PROGRESSION',
          fontSize: TFont.font10,
          fontWeight: FontWeight.bold,
          fontColor: TAppColors.textMuted,
          letterSpacing: 0.5,
        ),
        14.0.height,
        ...List.generate(steps.length, (index) {
          final step = steps[index];
          final isLast = index == steps.length - 1;

          final (
            icon,
            iconColor,
            iconBgColor,
            titleColor,
            subtitleColor,
          ) = switch ((step.isCompleted, step.isInProgress)) {
            (true, _) => (
              Icons.check,
              TAppColors.statusOpenText,
              TAppColors.statusOpenBg,
              TAppColors.textPrimary,
              TAppColors.textMuted,
            ),
            (_, true) => (
              Icons.autorenew,
              TAppColors.warningText,
              TAppColors.warningBg,
              TAppColors.warningText,
              TAppColors.textPrimary,
            ),
            _ => (
              Icons.hourglass_empty_rounded,
              TAppColors.textHint,
              TAppColors.inputFill,
              TAppColors.textHint,
              TAppColors.textHint,
            ),
          };

          return _buildStep(
            icon: icon,
            iconColor: iconColor,
            iconBgColor: iconBgColor,
            title: step.title,
            subtitle: step.subtitle,
            titleColor: titleColor,
            subtitleColor: subtitleColor,
            isLast: isLast,
          );
        }),
      ],
    );
  }

  Widget _buildStep({
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String title,
    required String subtitle,
    required Color titleColor,
    required Color subtitleColor,
    bool isLast = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            CommonCircleAvatar(
              radius: 14,
              backgroundColor: iconBgColor,
              child: Icon(icon, size: 14, color: iconColor),
            ),
            if (!isLast)
              Container(width: 2, height: 36, color: TAppColors.border),
          ],
        ),
        12.0.width,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              2.0.height,
              CommonText(
                text: title,
                fontSize: TFont.font12,
                fontWeight: FontWeight.bold,
                fontColor: titleColor,
              ),
              2.0.height,
              CommonText(
                text: subtitle,
                fontSize: TFont.font10,
                fontColor: subtitleColor,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
