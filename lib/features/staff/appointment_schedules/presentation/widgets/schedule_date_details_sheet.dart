import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/common_responsive_modal.dart';
import '../../../../shared/appointment_schedules/domain/entities/appointment_schedule.dart';
import 'create_schedule_bottom_sheet.dart';

class ScheduleDateDetailsSheet extends StatelessWidget {
  const ScheduleDateDetailsSheet({
    super.key,
    required this.date,
    required this.schedules,
    required this.onEdit,
  });

  final DateTime date;
  final List<AppointmentSchedule> schedules;
  final ValueChanged<AppointmentSchedule> onEdit;

  static Future<void> show(
    BuildContext context,
    DateTime date,
    List<AppointmentSchedule> schedules,
  ) => CommonResponsiveModal.show<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    maxWidth: 560,
    builder: (_) => ScheduleDateDetailsSheet(
      date: date,
      schedules: schedules,
      onEdit: (schedule) {
        Navigator.of(context).pop();
        CreateServiceSlotsBottomSheet.showEditScheduleModal(context, schedule);
      },
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.85,
      ),
      decoration: BoxDecoration(
        color: TAppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Schedules for this date',
                        style: TextStyle(
                          color: TAppColors.textPrimary,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        DateFormat('EEEE, MMMM d, yyyy').format(date),
                        style: const TextStyle(
                          color: TAppColors.textMuted,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  tooltip: 'Close',
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const Divider(color: TAppColors.border),
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: schedules.length,
                separatorBuilder: (_, _) => const SizedBox(height: 10),
                itemBuilder: (context, index) => _ScheduleEventCard(
                  schedule: schedules[index],
                  onEdit: onEdit,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScheduleEventCard extends StatelessWidget {
  const _ScheduleEventCard({required this.schedule, required this.onEdit});

  final AppointmentSchedule schedule;
  final ValueChanged<AppointmentSchedule> onEdit;

  @override
  Widget build(BuildContext context) {
    final isClosed = [
      'INACTIVE',
      'CLOSED',
    ].contains(schedule.status.toUpperCase());
    final isFull = schedule.status.toUpperCase() == 'FULL';
    final status = isClosed
        ? 'Closed'
        : isFull
        ? 'Full'
        : 'Available';
    final statusColor = isClosed
        ? TAppColors.errorTitle
        : isFull
        ? TAppColors.primary
        : TAppColors.successText;
    final remaining = schedule.remainingCapacity ?? schedule.capacity;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: TAppColors.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: TAppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  schedule.serviceName.isEmpty
                      ? 'Service schedule'
                      : schedule.serviceName,
                  style: const TextStyle(
                    color: TAppColors.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '${schedule.startTime} – ${schedule.endTime}',
            style: const TextStyle(
              color: TAppColors.textSecondary,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Capacity: $remaining of ${schedule.capacity} spots available',
            style: const TextStyle(color: TAppColors.textMuted, fontSize: 11),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: OutlinedButton.icon(
              onPressed: () => onEdit(schedule),
              icon: const Icon(Icons.edit_outlined, size: 16),
              label: const Text('Edit'),
            ),
          ),
        ],
      ),
    );
  }
}
