import 'package:material_ui/material_ui.dart';

import '../../../../../core/extensions/double_extension.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/common_elevated_button.dart';
import '../../../../../core/widgets/common_text.dart';

class SchedulesHeader extends StatelessWidget {
  const SchedulesHeader({
    super.key,
    required this.onCreateSchedule,
    required this.onCloseDate,
  });

  final VoidCallback onCreateSchedule;
  final VoidCallback onCloseDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 6,
                    runSpacing: 2,
                    children: [
                      CommonText(
                        text: 'Manage Appointment Schedules',
                        fontColor: TAppColors.textPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      6.0.width,
                      Container(
                        height: 7,
                        width: 7,
                        decoration: const BoxDecoration(
                          color: TAppColors.statusOpenText,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                  4.0.height,
                  CommonText(
                    text: 'Set daily counter capacities, service windows, and open/close booking dates.',
                    fontColor: TAppColors.textMuted,
                    fontSize: 11.5,
                  ),
                ],
              ),
            ),
          ],
        ),
        14.0.height,
        Row(
          children: [
            Expanded(
              child: CommonElevatedButton(
                onButtonPressed: onCreateSchedule,
                backgroundColor: TAppColors.primary,
                borderRadius: 10.0,
                elevatedPadding: const EdgeInsets.symmetric(vertical: 11),
                custom: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_circle_outline,
                      size: 16,
                      color: TAppColors.surface,
                    ),
                    6.0.width,
                    Flexible(
                      child: CommonText(
                        text: 'Create Schedule',
                        fontColor: TAppColors.surface,
                        fontSize: 12.5,
                        fontWeight: FontWeight.bold,
                        maxLine: 1,
                        textOverFlow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            10.0.width,
            // Expanded(
            //   child: CommonElevatedButton(
            //     onButtonPressed: onCloseDate,
            //     backgroundColor: TAppColors.surface,
            //     borderColor: TAppColors.promoBorder,
            //     borderWidth: 1.0,
            //     borderRadius: 10.0,
            //     elevatedPadding: const EdgeInsets.symmetric(vertical: 11),
            //     custom: Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         Icon(
            //           Icons.calendar_today_outlined,
            //           size: 15,
            //           color: TAppColors.primary,
            //         ),
            //         6.0.width,
            //         CommonText(
            //           text: 'Close Date',
            //           fontColor: TAppColors.primary,
            //           fontSize: 12.5,
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
        12.0.height,
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: TAppColors.promoBg,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: TAppColors.promoBorder),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.admin_panel_settings_outlined,
                size: 16,
                color: TAppColors.primary,
              ),
              8.0.width,
              Expanded(
                child: CommonText(
                  text: 'Administrative Note: Close date action allows flagging institution holidays (e.g. Oct 31) with custom reason.',
                  fontColor: TAppColors.textSecondary,
                  fontSize: 11,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
