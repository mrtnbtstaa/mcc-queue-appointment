import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../../core/extensions/double_extension.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/common_elevated_button.dart';
import '../../../../../core/widgets/common_text.dart';
import '../../../../shared/appointment_schedules/domain/entities/appointment_schedule.dart';
import '../../../../shared/appointment_schedules/presentation/bloc/manage_schedules_bloc.dart';
import '../../../../shared/appointment_schedules/presentation/bloc/manage_schedules_event.dart';
import '../../../../shared/appointment_schedules/presentation/bloc/manage_schedules_state.dart';

class DailyTimeSlotsList extends StatelessWidget {
  const DailyTimeSlotsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManageSchedulesBloc, ManageSchedulesState>(
      builder: (context, state) {
        if (state.status == ManageSchedulesStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.status == ManageSchedulesStatus.failure) {
          return Center(
            child: CommonText(
              text: state.errorMessage ?? 'Something went wrong',
              fontColor: TAppColors.errorTitle,
            ),
          );
        }

        final totalCapacity = state.schedules.fold<int>(
          0,
          (sum, schedule) => sum + schedule.capacity,
        );

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
                      CommonText(
                        text: DateFormat('EEEE, MMMM d, yyyy')
                            .format(state.selectedDate),
                        fontColor: TAppColors.textPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      2.0.height,
                      CommonText(
                        text:
                            '${state.schedules.length} Operating windows configured • $totalCapacity student capacity',
                        fontColor: TAppColors.textMuted,
                        fontSize: 11,
                      ),
                    ],
                  ),
                ),
                8.0.width,
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: TAppColors.promoBg,
                    shape: BoxShape.circle,
                    border: Border.all(color: TAppColors.promoBorder),
                  ),
                  child: const Icon(
                    Icons.add,
                    size: 16,
                    color: TAppColors.primary,
                  ),
                ),
              ],
            ),

            12.0.height,

            if (state.schedules.isEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: TAppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: TAppColors.border),
                ),
                child: Center(
                  child: CommonText(
                    text: 'No schedules available',
                    fontColor: TAppColors.textMuted,
                  ),
                ),
              )
            else
              Column(
                children: state.schedules.map((slot) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _TimeSlotCard(slot: slot),
                  );
                }).toList(),
              ),
          ],
        );
      },
    );
  }
}

class _TimeSlotCard extends StatelessWidget {
  const _TimeSlotCard({required this.slot});

  final AppointmentSchedule slot;

  @override
  Widget build(BuildContext context) {
    final status = slot.status.toUpperCase();
    final isClosed = status == 'INACTIVE' || status == 'CLOSED';
    final isFull = status == 'FULL';
    final statusLabel = isFull
        ? 'Full'
        : isClosed
        ? 'Inactive'
        : 'Available';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: TAppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: TAppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: isClosed
                            ? TAppColors.promoBg
                            : TAppColors.queueIconBg,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isClosed
                            ? Icons.cleaning_services_outlined
                            : Icons.access_time,
                        size: 16,
                        color: isClosed
                            ? TAppColors.primary
                            : TAppColors.queueIcon,
                      ),
                    ),
                    10.0.width,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonText(
                            text: '${slot.startTime} - ${slot.endTime}',
                            fontColor: TAppColors.textPrimary,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            maxLine: 1,
                            textOverFlow: TextOverflow.ellipsis,
                          ),
                          CommonText(
                            text: slot.service,
                            fontColor: TAppColors.textMuted,
                            fontSize: 11,
                            maxLine: 2,
                            textOverFlow: TextOverflow.ellipsis,
                          ),
                          CommonText(
                            text: DateFormat('MMM d, yyyy').format(slot.date),
                            fontColor: TAppColors.textMuted,
                            fontSize: 10,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              8.0.width,
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: isFull
                      ? TAppColors.promoBg
                      : (isClosed
                            ? TAppColors.errorBg
                            : TAppColors.statusOpenBg),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isFull
                        ? TAppColors.promoBorder
                        : (isClosed
                              ? TAppColors.errorBorder
                              : TAppColors.statusOpenBorder),
                  ),
                ),
                child: CommonText(
                  text: statusLabel,
                  fontColor: isFull
                      ? TAppColors.primary
                      : (isClosed
                            ? TAppColors.errorTitle
                            : TAppColors.statusOpenText),
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          12.0.height,

          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8,
            runSpacing: 8,
            children: [
              CommonText(
                text: 'Capacity: ${slot.capacity} students',
                fontColor: TAppColors.textSecondary,
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
              ),
              Wrap(
                spacing: 8,
                runSpacing: 6,
                children: [
                  CommonElevatedButton(
                    onButtonPressed: () {
                      if (slot.id != null) {
                        context.read<ManageSchedulesBloc>().add(
                          LoadSchedule(slot.id.toString()),
                        );
                      }
                    },
                    backgroundColor: TAppColors.surface,
                    borderColor: TAppColors.border,
                    borderWidth: 1,
                    borderRadius: 8,
                    elevatedPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    custom: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.edit_outlined,
                          size: 12,
                          color: TAppColors.textPrimary,
                        ),
                        4.0.width,
                        CommonText(
                          text: 'Edit',
                          fontColor: TAppColors.textPrimary,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),

                  if (isClosed)
                    CommonElevatedButton(
                      onButtonPressed: () {
                        if (slot.id != null) {
                          context.read<ManageSchedulesBloc>().add(
                            ToggleScheduleStatus(
                              id: slot.id.toString(),
                              status: 'AVAILABLE',
                            ),
                          );
                        }
                      },
                      backgroundColor: TAppColors.statusOpenBg,
                      borderColor: TAppColors.statusOpenBorder,
                      borderWidth: 1,
                      borderRadius: 8,
                      elevatedPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      custom: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.lock_open,
                            size: 12,
                            color: TAppColors.statusOpenText,
                          ),
                          4.0.width,
                          CommonText(
                            text: 'Reopen',
                            fontColor: TAppColors.statusOpenText,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                    )
                  else
                    CommonElevatedButton(
                      onButtonPressed: () {
                        if (slot.id != null) {
                          context.read<ManageSchedulesBloc>().add(
                            ToggleScheduleStatus(
                              id: slot.id.toString(),
                              status: 'INACTIVE',
                            ),
                          );
                        }
                      },
                      backgroundColor: TAppColors.primary,
                      borderRadius: 8,
                      elevatedPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      custom: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.visibility_outlined,
                            size: 12,
                            color: TAppColors.surface,
                          ),
                          4.0.width,
                          CommonText(
                            text: 'Close Slot',
                            fontColor: TAppColors.surface,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
