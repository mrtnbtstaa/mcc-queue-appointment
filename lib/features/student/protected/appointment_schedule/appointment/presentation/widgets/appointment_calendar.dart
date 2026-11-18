import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../../../../core/theme/app_colors.dart';
import '../../../../../../shared/appointment_schedules/presentation/bloc/manage_schedules_bloc.dart';
import '../../../../../../shared/appointment_schedules/presentation/bloc/manage_schedules_event.dart';
import '../../../../../../shared/appointment_schedules/presentation/bloc/manage_schedules_state.dart';
import 'appointment_details_bottom_sheet.dart';

class AppointmentCalendar extends StatelessWidget {
  const AppointmentCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManageSchedulesBloc, ManageSchedulesState>(
      builder: (context, state) {
        final focusedDay = state.focusedDate;

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: TAppColors.surface,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              TableCalendar(
                firstDay: DateTime.utc(2025, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: focusedDay,
                currentDay: DateTime.now(),
                calendarFormat: CalendarFormat.month,
                headerVisible: false,
                eventLoader: (day) {
                  return state.schedules.where((schedule) {
                    return schedule.date.year == day.year &&
                        schedule.date.month == day.month &&
                        schedule.date.day == day.day;
                  }).toList();
                },
                calendarStyle: CalendarStyle(
                  outsideDaysVisible: true,
                  defaultTextStyle: TextStyle(
                    color: TAppColors.textPrimary,
                    fontSize: 12,
                  ),
                  weekendTextStyle: TextStyle(
                    color: TAppColors.textPrimary,
                    fontSize: 12,
                  ),
                  selectedDecoration: const BoxDecoration(
                    color: TAppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  todayDecoration: BoxDecoration(
                    color: TAppColors.primary.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  todayTextStyle: const TextStyle(
                    color: TAppColors.primary,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  markersMaxCount: 3,
                  markerSize: 10,
                  markerMargin: const EdgeInsets.symmetric(horizontal: 1),
                  markerDecoration: const BoxDecoration(
                    color: TAppColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
                selectedDayPredicate: (day) =>
                    isSameDay(day, state.selectedDate),
                onDaySelected: (selectedDay, focusedDay) async {
                  context.read<ManageSchedulesBloc>().add(
                    SelectDate(selectedDay),
                  );

                  final daySchedules = state.schedules.where((schedule) {
                    return schedule.date.year == selectedDay.year &&
                        schedule.date.month == selectedDay.month &&
                        schedule.date.day == selectedDay.day;
                  }).toList();

                  if (daySchedules.isEmpty) return;

                  final booked = await showAppointmentDetailsModal(
                    context,
                    selectedDay,
                    daySchedules,
                  );

                  if (booked == null || !context.mounted) return;

                  context.read<ManageSchedulesBloc>().add(
                    const LoadSchedules(),
                  );

                  final code = booked.appointmentCode;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        code.isEmpty
                            ? 'Appointment booked.'
                            : 'Appointment booked: $code',
                      ),
                    ),
                  );
                },
                onPageChanged: (focusedDay) {
                  context.read<ManageSchedulesBloc>().add(
                    ChangeFocusedDate(focusedDay),
                  );
                },
              ),

              // Custom Header Navigation Title & Month Control
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.chevron_left,
                      color: TAppColors.textMuted,
                      size: 20,
                    ),
                    onPressed: () {
                      context.read<ManageSchedulesBloc>().add(
                        ChangeFocusedDate(
                          DateTime(focusedDay.year, focusedDay.month - 1, 1),
                        ),
                      );
                    },
                  ),
                  Row(
                    children: [
                      Text(
                        DateFormat('MMMM yyyy').format(focusedDay),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: TAppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const CircleAvatar(
                        radius: 3,
                        backgroundColor: TAppColors.primary,
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.chevron_right,
                      color: TAppColors.textMuted,
                      size: 20,
                    ),
                    onPressed: () {
                      context.read<ManageSchedulesBloc>().add(
                        ChangeFocusedDate(
                          DateTime(focusedDay.year, focusedDay.month + 1, 1),
                        ),
                      );
                    },
                  ),
                ],
              ),

              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Divider(height: 1, color: TAppColors.background),
              ),

              // Legends
              Wrap(
                alignment: WrapAlignment.spaceAround,
                spacing: 12,
                runSpacing: 6,
                children: [
                  _buildLegendItem(TAppColors.errorBg, 'Available Date'),
                  _buildLegendItem(TAppColors.primary, 'Selected Date'),
                  _buildLegendItem(TAppColors.border, 'Fully Booked'),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 3,
                    backgroundColor: TAppColors.primary,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Today (${DateFormat('MMM d').format(DateTime.now())})',
                    style: const TextStyle(
                      fontSize: 10.5,
                      color: TAppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 5),
        Text(
          label,
          style: const TextStyle(fontSize: 10.5, color: TAppColors.textMuted),
        ),
      ],
    );
  }
}
