import 'package:material_ui/material_ui.dart';

import '../../../../../../../core/extensions/double_extension.dart';
import '../../../../../../../core/theme/app_colors.dart';
import '../../../../../../../core/widgets/common_text.dart';

class AppointmentProgressTimeline extends StatelessWidget {
  const AppointmentProgressTimeline({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: TAppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: TAppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8,
            runSpacing: 2,
            children: [
              CommonText(
                text: 'Transaction Progress',
                fontColor: TAppColors.textPrimary,
                fontSize: 13.5,
                fontWeight: FontWeight.bold,
              ),
              CommonText(
                text: 'Updated Today',
                fontColor: TAppColors.textMuted,
                fontSize: 11,
              ),
            ],
          ),
          16.0.height,
          const _TimelineStep(
            title: 'Appointment Submitted',
            subtitle: 'Sep 30, 2026 • 02:15 PM',
            isCompleted: true,
            isLast: false,
          ),
          const _TimelineStep(
            title: 'Confirmed by Registrar',
            subtitle: 'Sep 30, 2026 • 03:00 PM',
            isCompleted: true,
            isLast: false,
          ),
          const _TimelineStep(
            title: 'Queue Number Assigned (Q015)',
            subtitle: 'Oct 1, 2026 • 08:00 AM',
            isCompleted: true,
            isActive: true,
            isLast: false,
          ),
          const _TimelineStep(
            title: 'Counter Service & Completion',
            subtitle: 'Scheduled for Oct 3 • Window 2',
            isCompleted: false,
            isLast: true,
          ),
        ],
      ),
    );
  }
}

class _TimelineStep extends StatelessWidget {
  const _TimelineStep({
    required this.title,
    required this.subtitle,
    required this.isCompleted,
    this.isActive = false,
    required this.isLast,
  });

  final String title;
  final String subtitle;
  final bool isCompleted;
  final bool isActive;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                color: isCompleted
                    ? TAppColors.statusOpenBg
                    : TAppColors.inputFill,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isCompleted
                      ? TAppColors.statusOpenText
                      : TAppColors.border,
                  width: isActive ? 2 : 1,
                ),
              ),
              child: Icon(
                isCompleted ? Icons.check : Icons.circle,
                size: 10,
                color: isCompleted
                    ? TAppColors.statusOpenText
                    : TAppColors.textHint,
              ),
            ),
            if (!isLast)
              Container(
                height: 28,
                width: 2,
                color: isCompleted
                    ? TAppColors.statusOpenText.withValues(alpha: 0.4)
                    : TAppColors.border,
              ),
          ],
        ),
        12.0.width,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    child: CommonText(
                      text: title,
                      fontColor: TAppColors.textPrimary,
                      fontSize: 12.5,
                      fontWeight: FontWeight.bold,
                      maxLine: 2,
                    ),
                  ),
                  if (isActive) ...[
                    6.0.width,
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 1,
                      ),
                      decoration: BoxDecoration(
                        color: TAppColors.errorBg,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: TAppColors.errorBorder),
                      ),
                      child: CommonText(
                        text: 'Active',
                        fontColor: TAppColors.errorTitle,
                        fontSize: 9.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ],
              ),
              2.0.height,
              CommonText(
                text: subtitle,
                fontColor: TAppColors.textMuted,
                fontSize: 11,
              ),
              if (!isLast) 12.0.height,
            ],
          ),
        ),
      ],
    );
  }
}
