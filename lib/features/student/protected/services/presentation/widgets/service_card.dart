import 'package:material_ui/material_ui.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../shared/services/domain/entities/service_entity.dart';

class ServiceCard extends StatelessWidget {
  const ServiceCard({
    super.key,
    required this.service,
    required this.onViewChecklist,
    required this.onBookAppointment,
  });

  final ServiceEntity service;
  final VoidCallback onViewChecklist;
  final VoidCallback onBookAppointment;

  @override
  Widget build(BuildContext context) {
    final isFree = (double.tryParse(service.fee) ?? 0) == 0;
    final (icon, iconColor) = switch (service.category) {
      'Enrollment' => (Icons.school_outlined, TAppColors.errorIcon),
      'Certificates' => (Icons.verified_outlined, TAppColors.queueIcon),
      'Records' => (Icons.description_outlined, TAppColors.success),
      _ => (Icons.article_outlined, TAppColors.primary),
    };
    final price = isFree ? 'Free' : '₱${service.fee}';
    final estTime = service.durationMin == service.durationMax
        ? '${service.durationMin} mins'
        : '${service.durationMin}–${service.durationMax} mins';
    final documents = service.requiredDocuments.isEmpty
        ? 'None'
        : service.requiredDocuments.join(', ');
    final statusColor = service.isActive
        ? TAppColors.success
        : TAppColors.textMuted;

    return Container(
      padding: const EdgeInsets.all(14),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row: Icon, Title, Price Badge
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: iconColor.withValues(alpha: 0.1),
                child: Icon(icon, size: 18, color: iconColor),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            service.name,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: TAppColors.textPrimary,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: isFree
                                ? TAppColors.successBg
                                : TAppColors.background,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            price,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: isFree
                                  ? TAppColors.successText
                                  : TAppColors.textSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        CircleAvatar(radius: 3, backgroundColor: statusColor),
                        const SizedBox(width: 5),
                        Text(
                          service.isActive ? 'Active / Available' : 'Inactive',
                          style: TextStyle(
                            fontSize: 10.5,
                            color: statusColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Required Documents Container
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: TAppColors.background,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.folder_outlined,
                  size: 16,
                  color: TAppColors.textSecondary,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Required Documents',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: TAppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        documents,
                        style: const TextStyle(
                          fontSize: 11,
                          color: TAppColors.textMuted,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // Estimated Time & View Checklist
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8,
            runSpacing: 4,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.access_time,
                    size: 14,
                    color: TAppColors.textMuted,
                  ),
                  const SizedBox(width: 4),
                  Flexible(
                    child: Text(
                      'Est. Time: $estTime',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 11,
                        color: TAppColors.textMuted,
                      ),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: onViewChecklist,
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'View Checklist',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: TAppColors.primary,
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      size: 14,
                      color: TAppColors.primary,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(height: 1, color: TAppColors.background),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: onBookAppointment,
              style: ElevatedButton.styleFrom(
                backgroundColor: TAppColors.primary,
                foregroundColor: TAppColors.surface,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 11),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: const Icon(Icons.calendar_today, size: 14),
              label: const Text(
                'Book Appointment',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
