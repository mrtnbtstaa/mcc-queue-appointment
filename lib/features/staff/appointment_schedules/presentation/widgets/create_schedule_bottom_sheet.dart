import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/common_bottom_sheet.dart';
import '../../../../../core/widgets/common_responsive_modal.dart';
import '../../../../shared/appointment_schedules/domain/entities/appointment_schedule.dart';
import '../../../../shared/appointment_schedules/presentation/bloc/manage_schedules_bloc.dart';
import '../../../../shared/appointment_schedules/presentation/bloc/manage_schedules_event.dart';
import '../../../../shared/appointment_schedules/presentation/bloc/manage_schedules_state.dart';

class CreateServiceSlotsBottomSheet extends StatefulWidget {
  const CreateServiceSlotsBottomSheet({super.key, this.schedule});

  final AppointmentSchedule? schedule;

  static void showCreateServiceSlotsModal(BuildContext context) {
    _show(context);
  }

  static void showEditScheduleModal(
    BuildContext context,
    AppointmentSchedule schedule,
  ) {
    _show(context, schedule: schedule);
  }

  static void _show(BuildContext context, {AppointmentSchedule? schedule}) {
    final bloc = context.read<ManageSchedulesBloc>();

    CommonResponsiveModal.show<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: bloc,
        child: CreateServiceSlotsBottomSheet(schedule: schedule),
      ),
    );
  }

  @override
  State<CreateServiceSlotsBottomSheet> createState() =>
      CreateServiceSlotsBottomSheetState();
}

class CreateServiceSlotsBottomSheetState
    extends State<CreateServiceSlotsBottomSheet> {
  late String _selectedServiceID = widget.schedule?.serviceName ?? '';

  final TextEditingController _dateController = TextEditingController(
    text: DateFormat('MMM d, yyyy').format(DateTime.now()),
  );
  final TextEditingController _startTimeController = TextEditingController(
    text: '08:00',
  );
  final TextEditingController _endTimeController = TextEditingController(
    text: '17:00',
  );
  final TextEditingController _capacityController = TextEditingController(
    text: '10',
  );

  @override
  void initState() {
    super.initState();
    final schedule = widget.schedule;
    if (schedule == null) return;
    _dateController.text = DateFormat('MMM d, yyyy').format(schedule.date);
    _startTimeController.text = schedule.startTime;
    _endTimeController.text = schedule.endTime;
    _capacityController.text = schedule.capacity.toString();
  }

  @override
  void dispose() {
    _dateController.dispose();
    _startTimeController.dispose();
    _endTimeController.dispose();
    _capacityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CommonBottomSheet(
      onClosing: () {},
      showDragHandle: false,
      padding: EdgeInsets.zero,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: TAppColors.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header Section with Maroon Background
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: TAppColors.primary,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: TAppColors.surface.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.date_range,
                      color: TAppColors.surface,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.schedule == null
                              ? 'Create Service Slots'
                              : 'Edit Schedule',
                          style: const TextStyle(
                            color: TAppColors.surface,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          widget.schedule == null
                              ? 'Batch generate bookable student windows'
                              : 'Update this bookable student window',
                          style: const TextStyle(
                            color: Color.fromARGB(179, 8, 7, 7),
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.close,
                      color: TAppColors.surface,
                      size: 20,
                    ),
                    splashRadius: 20,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),

            // Form Body Content (Scrollable)
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Target Service
                    const Text(
                      'Target Service',
                      style: TextStyle(
                        color: TAppColors.textPrimary,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    BlocBuilder<ManageSchedulesBloc, ManageSchedulesState>(
                      builder: (context, state) {
                        debugPrint(_selectedServiceID);
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          decoration: BoxDecoration(
                            color: TAppColors.inputFill,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: TAppColors.border),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value:
                                  state.services.any(
                                    (service) =>
                                        service.name == _selectedServiceID,
                                  )
                                  ? _selectedServiceID
                                  : null,
                              isExpanded: true,
                              hint: const Text('Select Service'),
                              icon: const Icon(
                                Icons.keyboard_arrow_down,
                                color: TAppColors.textSecondary,
                                size: 20,
                              ),
                              style: const TextStyle(
                                fontSize: 13,
                                color: TAppColors.textPrimary,
                              ),
                              items: state.services.map((service) {
                                return DropdownMenuItem<String>(
                                  value: service.name,
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.school_outlined,
                                        size: 16,
                                        color: TAppColors.textSecondary,
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          service.name,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  setState(() {
                                    _selectedServiceID = newValue;
                                  });
                                }
                              },
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 14),

                    // Date Application (Start & End Date)
                    const Text(
                      'Date Application',
                      style: TextStyle(
                        color: TAppColors.textPrimary,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    TextField(
                      controller: _dateController,
                      readOnly: true,
                      onTap: () async {
                        final today = DateUtils.dateOnly(DateTime.now());
                        final initialDate = widget.schedule?.date ?? today;
                        final selectedDate = await showDatePicker(
                          context: context,
                          initialDate: initialDate.isBefore(today)
                              ? today
                              : initialDate,
                          firstDate: today,
                          lastDate: DateTime(2100),
                        );

                        if (selectedDate != null) {
                          setState(() {
                            _dateController.text = DateFormat('MMM d, yyyy')
                                .format(selectedDate);
                          });
                        }
                      },
                      style: const TextStyle(
                        fontSize: 13,
                        color: TAppColors.textPrimary,
                      ),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.calendar_today_outlined,
                          size: 16,
                          color: TAppColors.textSecondary,
                        ),
                        suffixIcon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: TAppColors.textSecondary,
                        ),
                        hintText: 'Select Date',
                        filled: true,
                        fillColor: TAppColors.inputFill,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 12,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: TAppColors.border,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: TAppColors.border,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: TAppColors.primary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    // Daily Start & End Time Row
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Daily Start',
                                style: TextStyle(
                                  color: TAppColors.textPrimary,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 6),
                              TextFormField(
                                controller: _startTimeController,
                                readOnly: true,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: TAppColors.textPrimary,
                                ),
                                onTap: () async {
                                  final selectedTime = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  );

                                  if (selectedTime != null) {
                                    _startTimeController.text =
                                        '${selectedTime.hour.toString().padLeft(2, '0')}:'
                                        '${selectedTime.minute.toString().padLeft(2, '0')}:00';
                                  }
                                },
                                decoration: InputDecoration(
                                  hintText: 'Select start time',
                                  prefixIcon: const Icon(
                                    Icons.access_time,
                                    size: 16,
                                    color: TAppColors.textSecondary,
                                  ),
                                  filled: true,
                                  fillColor: TAppColors.inputFill,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 12,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                      color: TAppColors.border,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                      color: TAppColors.border,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                      color: TAppColors.primary,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Daily End',
                                style: TextStyle(
                                  color: TAppColors.textPrimary,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 6),
                              TextFormField(
                                controller: _endTimeController,
                                readOnly: true,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: TAppColors.textPrimary,
                                ),
                                onTap: () async {
                                  final selectedTime = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  );

                                  if (selectedTime != null) {
                                    _endTimeController.text =
                                        '${selectedTime.hour.toString().padLeft(2, '0')}:'
                                        '${selectedTime.minute.toString().padLeft(2, '0')}:00';
                                  }
                                },
                                decoration: InputDecoration(
                                  hintText: 'Select end time',
                                  prefixIcon: const Icon(
                                    Icons.access_time,
                                    size: 16,
                                    color: TAppColors.textSecondary,
                                  ),
                                  filled: true,
                                  fillColor: TAppColors.inputFill,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 12,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                      color: TAppColors.border,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                      color: TAppColors.border,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                      color: TAppColors.primary,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // Slot Duration & Capacity Row
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Capacity / Slot',
                          style: TextStyle(
                            color: TAppColors.textPrimary,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 6),
                        TextField(
                          controller: _capacityController,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                            fontSize: 13,
                            color: TAppColors.textPrimary,
                          ),
                          decoration: InputDecoration(
                            suffixText: 'students',
                            suffixStyle: const TextStyle(
                              color: TAppColors.textHint,
                              fontSize: 11,
                            ),
                            filled: true,
                            fillColor: TAppColors.inputFill,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 12,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: TAppColors.border,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: TAppColors.border,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: TAppColors.primary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Footer Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: TAppColors.textPrimary,
                              side: const BorderSide(color: TAppColors.border),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => _saveSchedule(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: TAppColors.primary,
                              foregroundColor: TAppColors.surface,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              widget.schedule == null
                                  ? 'Save Schedule'
                                  : 'Update Schedule',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveSchedule(BuildContext context) {
    final date = DateFormat('MMM d, yyyy').parse(_dateController.text);
    final bloc = context.read<ManageSchedulesBloc>();
    final existingSchedule = widget.schedule;
    final duplicateDate = bloc.state
        .schedulesFor(date)
        .any((schedule) => schedule.id != existingSchedule?.id);
    if (duplicateDate) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('A schedule already exists for this date.'),
        ),
      );
      return;
    }

    final schedule = AppointmentSchedule(
      id: existingSchedule?.id,
      service:
          existingSchedule != null &&
              _selectedServiceID == existingSchedule.serviceName
          ? existingSchedule.service
          : _selectedServiceID,
      status: existingSchedule?.status ?? 'AVAILABLE',
      startTime: _startTimeController.text,
      endTime: _endTimeController.text,
      date: date,
      capacity: int.tryParse(_capacityController.text) ?? 0,
      remainingCapacity: existingSchedule?.remainingCapacity,
      serviceName: _selectedServiceID,
    );
    if (existingSchedule == null) {
      bloc.add(CreateSchedule(schedule));
    } else if (existingSchedule.id != null) {
      bloc.add(UpdateSchedule(id: existingSchedule.id!, schedule: schedule));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('This schedule cannot be edited.')),
      );
      return;
    }
    Navigator.pop(context);
  }
}
