import 'package:material_ui/material_ui.dart';

import '../../../../../core/extensions/double_extension.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/common_text.dart';

class AppointmentItem extends StatelessWidget {
  const AppointmentItem({
    super.key,
    required this.time,
    required this.slot,
    required this.name,
    required this.service,
    required this.ticket,
    required this.status,
    required this.statusColor,
    required this.statusBg,
  });

  final String time;
  final String slot;
  final String name;
  final String service;
  final String ticket;
  final String status;
  final Color statusColor;
  final Color statusBg;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: TAppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: TAppColors.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: TAppColors.inputFill,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: CommonText(
                        text: time,
                        fontColor: TAppColors.textSecondary,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    6.0.width,
                    CommonText(
                      text: slot,
                      fontColor: TAppColors.textMuted,
                      fontSize: 11,
                    ),
                  ],
                ),
                6.0.height,
                CommonText(
                  text: name,
                  fontColor: TAppColors.textPrimary,
                  fontSize: 12.5,
                  fontWeight: FontWeight.bold,
                ),
                2.0.height,
                CommonText(
                  text: service,
                  fontColor: TAppColors.textMuted,
                  fontSize: 11,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                decoration: BoxDecoration(
                  color: statusBg,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: CommonText(
                  text: status,
                  fontColor: statusColor,
                  fontSize: 9.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              6.0.height,
              CommonText(
                text: 'Ticket',
                fontColor: TAppColors.textHint,
                fontSize: 9.5,
              ),
              CommonText(
                text: ticket,
                fontColor: TAppColors.primary,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
