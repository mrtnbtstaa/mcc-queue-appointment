import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../../../../core/di/injector.dart';
import '../../../../../../../core/extensions/double_extension.dart';
import '../../../../../../../core/theme/app_colors.dart';
import '../../../../../../../core/widgets/common_elevated_button.dart';
import '../../../../../../../core/widgets/common_responsive_modal.dart';
import '../../../../../../shared/appointment_schedules/domain/entities/appointment_schedule.dart';
import '../../../../../../shared/appointments/domain/entities/appointment.dart';
import '../../../../../../shared/appointments/presentation/bloc/appointment_bloc.dart';
import '../../../../../../shared/appointments/presentation/bloc/appointment_event.dart';
import '../../../../../../shared/appointments/presentation/bloc/appointment_state.dart';

class AppointmentDetailsModal extends StatelessWidget {
  const AppointmentDetailsModal({
    super.key,
    required this.selectedDay,
    required this.schedules,
    required this.bookedSlotIds,
  });

  final DateTime selectedDay;
  final List<AppointmentSchedule> schedules;
  final Set<String> bookedSlotIds;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppointmentBloc, AppointmentState>(
      listener: (context, state) {
        if (state is AppointmentCreated) {
          Navigator.of(context).pop(state.appointment);
        }
      },
      builder: (context, state) {
        final isLoading = state is AppointmentLoading;
        final error = state is AppointmentError ? state.message : null;

        return Container(
          decoration: const BoxDecoration(
            color: TAppColors.surface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ---- drag handle -------------------------------------------
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: TAppColors.textSecondary.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),

                // ---- header ------------------------------------------------
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Appointments',
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: TAppColors.textPrimary,
                                ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _formatSelectedDay(selectedDay),
                            style: const TextStyle(
                              color: TAppColors.textSecondary,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close_rounded, size: 22),
                      color: TAppColors.textSecondary,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),

                const SizedBox(height: 12),
                const Divider(height: 1, color: TAppColors.border),
                const SizedBox(height: 12),

                if (error != null) ...[
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: TAppColors.errorBg,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: TAppColors.errorBorder),
                    ),
                    child: Text(
                      error,
                      style: const TextStyle(
                        color: TAppColors.errorTitle,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],

                // ---- event list --------------------------------------------
                if (schedules.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Column(
                      children: const [
                        Icon(
                          Icons.event_busy_rounded,
                          size: 48,
                          color: TAppColors.textSecondary,
                        ),
                        SizedBox(height: 12),
                        Text(
                          'No appointments on this day.',
                          style: TextStyle(color: TAppColors.textSecondary),
                        ),
                      ],
                    ),
                  )
                else
                  Flexible(
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: schedules.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final schedule = schedules[index];
                        return _AppointmentCard(
                          schedule: schedule,
                          isLoading: isLoading,
                          isAlreadyBooked: bookedSlotIds.contains(schedule.id),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _formatSelectedDay(DateTime day) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return '${months[day.month - 1]} ${day.day}, ${day.year}';
  }
}

/// A single appointment row inside the modal.
class _AppointmentCard extends StatelessWidget {
  const _AppointmentCard({
    required this.schedule,
    required this.isLoading,
    required this.isAlreadyBooked,
  });

  final AppointmentSchedule schedule;
  final bool isLoading;
  final bool isAlreadyBooked;

  @override
  Widget build(BuildContext context) {
    final status = schedule.status.toUpperCase();
    final remaining = schedule.remainingCapacity ?? schedule.capacity;
    final isFull = status == 'FULL' || remaining <= 0;
    final isInactive = status == 'INACTIVE' || status == 'CLOSED';
    final isAvailable =
        !isFull && !isInactive && (status == 'AVAILABLE' || status == 'OPEN');

    final statusLabel = isAlreadyBooked
        ? 'Already booked'
        : isFull
        ? 'Full'
        : isInactive
        ? 'Inactive'
        : isAvailable
        ? 'Available'
        : 'Unavailable';

    final slotId = schedule.id;
    final canBook =
        isAvailable &&
        !isAlreadyBooked &&
        !isLoading &&
        slotId != null &&
        slotId.isNotEmpty &&
        schedule.serviceName.isNotEmpty;

    final buttonLabel = isLoading
        ? 'Booking...'
        : isAlreadyBooked
        ? 'Already booked'
        : isAvailable
        ? 'Appoint Now'
        : statusLabel;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isAvailable
            ? TAppColors.primary.withValues(alpha: 0.06)
            : TAppColors.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isAvailable
              ? TAppColors.primary.withValues(alpha: 0.18)
              : TAppColors.border,
        ),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // time-side icon badge
              Container(
                width: 42,
                height: 42,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: TAppColors.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.schedule_rounded,
                  color: TAppColors.primary,
                  size: 22,
                ),
              ),

              const SizedBox(width: 12),

              // service + time
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Service',
                      style: TextStyle(
                        fontSize: 11,
                        color: TAppColors.textSecondary,
                        letterSpacing: 0.4,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      schedule.serviceName,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: TAppColors.textPrimary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    8.0.height,
                    Text(
                      'Time',
                      style: TextStyle(
                        fontSize: 11,
                        color: TAppColors.textSecondary,
                        letterSpacing: 0.4,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    2.0.height,
                    Text(
                      '${schedule.startTime} - ${schedule.endTime}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: TAppColors.textPrimary,
                      ),
                    ),
                    8.0.height,
                    Text(
                      'Capacity',
                      style: TextStyle(
                        fontSize: 11,
                        color: TAppColors.textSecondary,
                        letterSpacing: 0.4,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    2.0.height,
                    Text(
                      '$remaining of ${schedule.capacity} slots left',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: TAppColors.textPrimary,
                      ),
                    ),
                    8.0.height,
                    Text(
                      'Status',
                      style: TextStyle(
                        fontSize: 11,
                        color: TAppColors.textSecondary,
                        letterSpacing: 0.4,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    2.0.height,
                    Text(
                      statusLabel,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: TAppColors.textPrimary,
                      ),
                    ),
                    12.0.height,
                  ],
                ),
              ),
            ],
          ),
          CommonElevatedButton(
            text: buttonLabel,
            width: double.infinity,
            height: 50,
            borderRadius: 12,
            fontSize: 15,
            fontWeight: FontWeight.w600,
            onButtonPressed: canBook
                ? () {
                    context.read<AppointmentBloc>().add(
                      CreateAppointmentEvent(
                        service: schedule.serviceName,
                        slot: slotId,
                      ),
                    );
                  }
                : null,
          ),
        ],
      ),
    );
  }
}

/// Convenience entry point used from the calendar's `onDaySelected`.
Future<Appointment?> _openModal(
  BuildContext context,
  DateTime selectedDay,
  List<AppointmentSchedule> schedules,
  Set<String> bookedSlotIds,
) {
  return CommonResponsiveModal.show<Appointment>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black.withValues(alpha: 0.4),
    useSafeArea: true,
    builder: (_) => BlocProvider(
      create: (_) => getIt<AppointmentBloc>(),
      child: AppointmentDetailsModal(
        selectedDay: selectedDay,
        schedules: schedules,
        bookedSlotIds: bookedSlotIds,
      ),
    ),
  );
}

// Top-level helper so the calendar widget can call it without lifting state.
Future<Appointment?> showAppointmentDetailsModal(
  BuildContext context,
  DateTime selectedDay,
  List<AppointmentSchedule> schedules, {
  required Set<String> bookedSlotIds,
}) {
  return _openModal(context, selectedDay, schedules, bookedSlotIds);
}
