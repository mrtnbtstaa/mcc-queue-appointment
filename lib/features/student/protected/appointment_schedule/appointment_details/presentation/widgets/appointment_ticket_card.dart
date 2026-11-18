import 'package:material_ui/material_ui.dart';

import '../../../../../../../core/extensions/double_extension.dart';
import '../../../../../../../core/theme/app_colors.dart';
import '../../../../../../../core/widgets/common_text.dart';

class AppointmentTicketCard extends StatelessWidget {
  const AppointmentTicketCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: TAppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: TAppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Top Ticket Header Section (Burgundy Accent Box)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: TAppColors.promoBg,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.school,
                            size: 14,
                            color: TAppColors.primary,
                          ),
                          4.0.width,
                          Flexible(
                            child: CommonText(
                              text: 'MABALACAT CITY COLLEGE • R...',
                              fontColor: TAppColors.textSecondary,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              maxLine: 1,
                              textOverFlow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    6.0.width,
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: TAppColors.statusOpenBg,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: CommonText(
                        text: 'Confirmed',
                        fontColor: TAppColors.statusOpenText,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                12.0.height,
                CommonText(
                  text: 'YOUR QUEUE NUMBER',
                  fontColor: TAppColors.textMuted,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
                4.0.height,
                CommonText(
                  text: 'Q015',
                  fontColor: TAppColors.primary,
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
          ),

          // Ticket Body Details
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Student Info Grid
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonText(
                            text: 'STUDENT NAME',
                            fontColor: TAppColors.textHint,
                            fontSize: 9.5,
                            fontWeight: FontWeight.bold,
                          ),
                          2.0.height,
                          CommonText(
                            text: 'Juan Dela Cruz',
                            fontColor: TAppColors.textPrimary,
                            fontSize: 12.5,
                            fontWeight: FontWeight.bold,
                          ),
                          2.0.height,
                          CommonText(
                            text: 'BSIT - 3rd Year',
                            fontColor: TAppColors.textMuted,
                            fontSize: 11,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonText(
                            text: 'STUDENT ID / REF #',
                            fontColor: TAppColors.textHint,
                            fontSize: 9.5,
                            fontWeight: FontWeight.bold,
                          ),
                          2.0.height,
                          CommonText(
                            text: '2023-01492',
                            fontColor: TAppColors.textPrimary,
                            fontSize: 12.5,
                            fontWeight: FontWeight.bold,
                          ),
                          2.0.height,
                          CommonText(
                            text: '2026-1003-001',
                            fontColor: TAppColors.textMuted,
                            fontSize: 11,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                14.0.height,
                const Divider(color: TAppColors.border, height: 1),
                14.0.height,

                // Requested Service Row
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: TAppColors.queueIconBg,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.assignment_outlined,
                        size: 16,
                        color: TAppColors.queueIcon,
                      ),
                    ),
                    10.0.width,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonText(
                            text: 'Requested Service',
                            fontColor: TAppColors.textHint,
                            fontSize: 10,
                          ),
                          CommonText(
                            text: 'Enrollment (Verification & Clearance)',
                            fontColor: TAppColors.textPrimary,
                            fontSize: 12.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                12.0.height,

                // Appointment Schedule Row
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: TAppColors.promoBg,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.calendar_today_outlined,
                        size: 16,
                        color: TAppColors.primary,
                      ),
                    ),
                    10.0.width,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonText(
                            text: 'Appointment Schedule',
                            fontColor: TAppColors.textHint,
                            fontSize: 10,
                          ),
                          CommonText(
                            text: 'October 3, 2026',
                            fontColor: TAppColors.textPrimary,
                            fontSize: 12.5,
                            fontWeight: FontWeight.bold,
                          ),
                          CommonText(
                            text: '09:00 AM – 10:00 AM (Morning Slot)',
                            fontColor: TAppColors.textMuted,
                            fontSize: 11,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                16.0.height,

                // Arrival Notice Box
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: TAppColors.queueIconBg,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: TAppColors.queueIcon.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 16,
                        color: TAppColors.queueIcon,
                      ),
                      8.0.width,
                      Expanded(
                        child: CommonText(
                          text: 'Please arrive at least 15 minutes before your scheduled window. Present your MCC Student ID and this digital ticket to the kiosk scanner or Window 2 staff.',
                          fontColor: TAppColors.textSecondary,
                          fontSize: 11,
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
