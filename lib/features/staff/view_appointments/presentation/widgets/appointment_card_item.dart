import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/common_adaptive_grid.dart';
import '../../../../../core/widgets/common_circle_avatar.dart';
import '../../../../../core/widgets/common_elevated_button.dart';
import '../../../../../core/widgets/common_text.dart';
import '../../../../shared/appointments/domain/entities/appointment.dart';
import '../cubit/view_appointments_cubit.dart';

class AppointmentCardItem extends StatelessWidget {
  final Appointment appointment;
  final bool isUpdating;

  const AppointmentCardItem({
    super.key,
    required this.appointment,
    this.isUpdating = false,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ViewAppointmentsCubit>();
    final status = appointment.status.toUpperCase();
    final isPending = status == 'PENDING' || status.isEmpty;
    final isConfirmed = status == 'CONFIRMED';
    final isCompleted = status == 'COMPLETED';
    final isCancelled = status == 'CANCELLED';

    final statusColor = isCompleted
        ? TAppColors.queueIcon
        : (isConfirmed
              ? TAppColors.success
              : (isCancelled ? TAppColors.errorIcon : TAppColors.warningText));
    final badgeBackground = isCompleted
        ? TAppColors.queueIconBg
        : (isConfirmed
              ? TAppColors.successBg
              : (isCancelled ? TAppColors.errorBg : TAppColors.warningBg));
    final statusLabel = isCompleted
        ? 'Completed'
        : (isConfirmed ? 'Confirmed' : (isCancelled ? 'Cancelled' : 'Pending'));

    final name = appointment.userName.isNotEmpty
        ? appointment.userName
        : (appointment.userEmail.isNotEmpty
              ? appointment.userEmail
              : 'Student');

    final program = [
      if (appointment.course.isNotEmpty) appointment.course.toUpperCase(),
      if (appointment.yearLevel.isNotEmpty) 'Year ${appointment.yearLevel}',
    ].join(' ');
    final studentMeta = [
      if (appointment.studentId.isNotEmpty) 'ID: ${appointment.studentId}',
      if (program.isNotEmpty) program,
    ].join(' • ');

    final service = appointment.serviceName.isNotEmpty
        ? appointment.serviceName
        : '—';
    final schedule = appointment.slotLabel.isNotEmpty
        ? appointment.slotLabel
        : '—';
    final reference = appointment.appointmentCode.isNotEmpty
        ? appointment.appointmentCode
        : '—';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: TAppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border(left: BorderSide(color: statusColor, width: 4)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  children: [
                    CommonCircleAvatar(
                      backgroundColor: badgeBackground,
                      child: Icon(
                        isCompleted
                            ? Icons.check_circle_outline
                            : (isConfirmed
                                  ? Icons.verified_outlined
                                  : (isCancelled
                                        ? Icons.cancel_outlined
                                        : Icons.hourglass_top)),
                        color: statusColor,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonText(
                            text: name,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            maxLine: 1,
                            textOverFlow: TextOverflow.ellipsis,
                          ),
                          if (studentMeta.isNotEmpty)
                            CommonText(
                              text: studentMeta,
                              fontSize: 11,
                              fontColor: TAppColors.textHint,
                              maxLine: 1,
                              textOverFlow: TextOverflow.ellipsis,
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: badgeBackground,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: CommonText(
                  text: statusLabel,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  fontColor: statusColor,
                ),
              ),
            ],
          ),
          const Divider(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonText(
                text: 'Service',
                fontSize: 11,
                fontColor: TAppColors.textHint,
              ),
              Flexible(
                child: CommonText(
                  text: service,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  alignment: TextAlign.end,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonText(
                text: 'Schedule',
                fontSize: 11,
                fontColor: TAppColors.textHint,
              ),
              Flexible(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.access_time,
                      size: 12,
                      color: TAppColors.textHint,
                    ),
                    const SizedBox(width: 4),
                    Flexible(
                      child: CommonText(
                        text: schedule,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        alignment: TextAlign.end,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: TAppColors.border,
              borderRadius: BorderRadius.circular(6),
            ),
            child: CommonText(
              text: 'Ref: $reference',
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (isPending) ...[
            const Divider(height: 20),
            if (isUpdating)
              const Center(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              )
            else
              CommonAdaptiveGrid(
                minItemWidth: 150,
                maxColumns: 2,
                spacing: 8,
                children: [
                  CommonElevatedButton(
                    text: 'Confirm Appointment',
                    backgroundColor: TAppColors.primary,
                    onButtonPressed: () => cubit.confirm(appointment.id),
                  ),
                  OutlinedButton(
                    onPressed: () => cubit.decline(appointment.id),
                    child: CommonText(
                      text: 'Decline',
                      fontSize: 11,
                      fontColor: TAppColors.errorIcon,
                    ),
                  ),
                ],
              ),
          ],
        ],
      ),
    );
  }
}
