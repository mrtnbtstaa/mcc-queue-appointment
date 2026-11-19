import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../../../../core/theme/app_colors.dart';
import '../../../../../../../core/widgets/common_adaptive_grid.dart';
import '../../../../../../../core/widgets/common_empty_state.dart';
import '../../../../../../shared/appointments/domain/entities/appointment.dart';
import '../../../../../../shared/appointments/presentation/bloc/appointment_bloc.dart';
import '../../../../../../shared/appointments/presentation/bloc/appointment_event.dart';
import '../../../../../../shared/appointments/presentation/bloc/appointment_state.dart';

class StudentAppointmentsList extends StatelessWidget {
  const StudentAppointmentsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppointmentBloc, AppointmentState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'My Appointments',
              style: TextStyle(
                color: TAppColors.textPrimary,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            switch (state) {
              AppointmentsLoaded(:final appointments) =>
                appointments.isEmpty
                    ? _emptyState()
                    : CommonAdaptiveGrid(
                        minItemWidth: 300,
                        maxColumns: 2,
                        children: [
                          for (final appointment in appointments)
                            _AppointmentCard(appointment: appointment),
                        ],
                      ),
              AppointmentError(:final message) => _loadError(context, message),
              _ => const Padding(
                padding: EdgeInsets.all(28),
                child: Center(child: CircularProgressIndicator()),
              ),
            },
          ],
        );
      },
    );
  }

  Widget _emptyState() => const CommonEmptyState(
    title: 'No appointments yet',
    message: 'Appointments you book will appear here.',
    illustrationHeight: 120,
  );

  Widget _loadError(BuildContext context, String message) => Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: TAppColors.surface,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: TAppColors.border),
    ),
    child: Column(
      children: [
        Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(color: TAppColors.errorText, fontSize: 12),
        ),
        TextButton(
          onPressed: () =>
              context.read<AppointmentBloc>().add(const GetAppointmentsEvent()),
          child: const Text('Retry'),
        ),
      ],
    ),
  );
}

class _AppointmentCard extends StatelessWidget {
  const _AppointmentCard({required this.appointment});

  final Appointment appointment;

  @override
  Widget build(BuildContext context) {
    final status = appointment.status.replaceAll('_', ' ').toLowerCase();
    final statusLabel = status.isEmpty
        ? 'Pending'
        : '${status[0].toUpperCase()}${status.substring(1)}';
    final statusColor = switch (status) {
      'confirmed' || 'completed' => TAppColors.successText,
      'cancelled' || 'rejected' => TAppColors.errorTitle,
      _ => TAppColors.primary,
    };

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: TAppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: TAppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.025),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.event_available_outlined,
                color: TAppColors.primary,
                size: 18,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  appointment.serviceName.isEmpty
                      ? 'Registrar service'
                      : appointment.serviceName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: TAppColors.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  statusLabel,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          if (appointment.appointmentCode.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              appointment.appointmentCode,
              style: const TextStyle(color: TAppColors.textMuted, fontSize: 11),
            ),
          ],
          const SizedBox(height: 12),
          const Divider(height: 1, color: TAppColors.border),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.schedule_outlined,
                size: 15,
                color: TAppColors.textMuted,
              ),
              const SizedBox(width: 7),
              Expanded(
                child: Text(
                  appointment.slotLabel.isEmpty
                      ? 'Schedule details unavailable'
                      : appointment.slotLabel,
                  style: const TextStyle(
                    color: TAppColors.textSecondary,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
