import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../../core/extensions/double_extension.dart';
import '../../../../../core/extensions/context_extension.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/common_text.dart';
import 'schedule_date_details_sheet.dart';
import '../../../../shared/appointment_schedules/presentation/bloc/manage_schedules_bloc.dart';
import '../../../../shared/appointment_schedules/presentation/bloc/manage_schedules_event.dart';
import '../../../../shared/appointment_schedules/presentation/bloc/manage_schedules_state.dart';

class ScheduleCalendarCard extends StatelessWidget {
  const ScheduleCalendarCard({super.key});

  static const _months = [
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManageSchedulesBloc, ManageSchedulesState>(
      builder: (context, state) {
        final selectedDay = state.selectedDate;
        final focusedDay = state.focusedDate;

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: TAppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: TAppColors.border),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TableCalendar(
                firstDay: DateTime.utc(2025, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: focusedDay,
                currentDay: DateTime.now(),
                calendarFormat: CalendarFormat.month,
                headerVisible: false,
                enabledDayPredicate: (day) =>
                    isSameDay(day, DateTime.now()) ||
                    day.isAfter(DateTime.now()),
                eventLoader: (day) {
                  return state.schedulesFor(day);
                },

                calendarStyle: CalendarStyle(
                  outsideDaysVisible: true,
                  defaultTextStyle: const TextStyle(
                    color: TAppColors.textPrimary,
                    fontSize: 12,
                  ),
                  weekendTextStyle: const TextStyle(
                    color: TAppColors.textPrimary,
                    fontSize: 12,
                  ),
                  disabledTextStyle: const TextStyle(
                    color: TAppColors.textHint,
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

                selectedDayPredicate: (day) => isSameDay(day, selectedDay),

                onDaySelected: (selectedDay, focusedDay) {
                  context.read<ManageSchedulesBloc>().add(
                    SelectDate(selectedDay),
                  );
                  final events = state.schedulesFor(selectedDay);
                  if (events.isNotEmpty && !context.isDesktop) {
                    ScheduleDateDetailsSheet.show(context, selectedDay, events);
                  }
                },

                onPageChanged: (focusedDay) {
                  context.read<ManageSchedulesBloc>().add(
                    ChangeFocusedDate(focusedDay),
                  );
                },
              ),

              8.0.height,

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.chevron_left,
                      color: TAppColors.textSecondary,
                      size: 20,
                    ),
                    onPressed: () {
                      final previousMonth = DateTime(
                        focusedDay.year,
                        focusedDay.month - 1,
                        1,
                      );

                      context.read<ManageSchedulesBloc>().add(
                        ChangeFocusedDate(previousMonth),
                      );
                    },
                  ),

                  Row(
                    children: [
                      CommonText(
                        text:
                            '${_months[focusedDay.month - 1]} ${focusedDay.year}',
                        fontColor: TAppColors.textPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      6.0.width,
                      const CircleAvatar(
                        radius: 3,
                        backgroundColor: TAppColors.primary,
                      ),
                    ],
                  ),

                  IconButton(
                    icon: const Icon(
                      Icons.chevron_right,
                      color: TAppColors.textSecondary,
                      size: 20,
                    ),
                    onPressed: () {
                      final nextMonth = DateTime(
                        focusedDay.year,
                        focusedDay.month + 1,
                        1,
                      );

                      context.read<ManageSchedulesBloc>().add(
                        ChangeFocusedDate(nextMonth),
                      );
                    },
                  ),
                ],
              ),

              const Divider(height: 1, color: TAppColors.border),

              14.0.height,

              // Wrap(
              //   alignment: WrapAlignment.spaceBetween,
              //   crossAxisAlignment: WrapCrossAlignment.center,
              //   spacing: 12,
              //   runSpacing: 4,
              //   children: [
              //     CommonText(
              //       text: '${state.schedules.length} schedules configured',
              //       fontColor: TAppColors.textMuted,
              //       fontSize: 11,
              //     ),
              //     CommonText(
              //       text:
              //           '${state.schedules.fold<int>(0, (sum, e) => sum + e.capacity)} total capacity',
              //       fontColor: TAppColors.primary,
              //       fontSize: 11,
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ],
              // ),

              // 10.0.height,
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: TAppColors.promoBg,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: TAppColors.promoBorder),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.calendar_month,
                      size: 14,
                      color: TAppColors.primary,
                    ),
                    6.0.width,
                    Expanded(
                      child: CommonText(
                        text:
                            '${selectedDay.month}/${selectedDay.day}/${selectedDay.year}',
                        fontColor: TAppColors.textSecondary,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
