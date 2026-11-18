import 'package:material_ui/material_ui.dart';

import '../../../../../../core/extensions/double_extension.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/common_elevated_button.dart';
import '../../../../../../core/widgets/common_text.dart';
import '../../../../shared/services/domain/entities/service_entity.dart';

class RegistrarServiceCard extends StatelessWidget {
  const RegistrarServiceCard({
    super.key,
    required this.service,
    required this.onToggleStatus,
    required this.onEditDetails,
  });

  final ServiceEntity service;
  final VoidCallback onToggleStatus;
  final VoidCallback onEditDetails;

  @override
  Widget build(BuildContext context) {
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
          // Top Header Row: Icon, Title, Status Badge & Switch
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Container(
              //   padding: const EdgeInsets.all(10),
              //   decoration: BoxDecoration(
              //     color: service.iconBgColor,
              //     borderRadius: BorderRadius.circular(12),
              //   ),
              //   child: Icon(service.icon, size: 20, color: service.iconColor),
              // ),
              12.0.width,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 6,
                      runSpacing: 4,
                      children: [
                        CommonText(
                          text: service.name,
                          fontColor: TAppColors.textPrimary,
                          fontSize: 14.5,
                          fontWeight: FontWeight.bold,
                        ),
                        _StatusBadge(isActive: service.isActive),
                      ],
                    ),
                    4.0.height,
                    CommonText(
                      text: service.category,
                      fontColor: TAppColors.textMuted,
                      fontSize: 11.5,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 28,
                child: Switch(
                  value: service.isActive,
                  activeThumbColor: TAppColors.surface,
                  activeTrackColor: TAppColors.statusOpenText,
                  onChanged: (_) => onToggleStatus(),
                ),
              ),
            ],
          ),
          14.0.height,

          // Fee & Estimated Duration Metadata Box
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: TAppColors.inputFill,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: TAppColors.border),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.payments_outlined,
                        size: 15,
                        color: TAppColors.textMuted,
                      ),
                      8.0.width,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonText(
                              text: 'SERVICE FEE',
                              fontColor: TAppColors.textHint,
                              fontSize: 9.5,
                              fontWeight: FontWeight.bold,
                              maxLine: 1,
                              textOverFlow: TextOverflow.ellipsis,
                            ),
                            2.0.height,
                            CommonText(
                              text: service.fee,
                              fontColor: TAppColors.textPrimary,
                              // fontColor: service.isFree
                              //     ? TAppColors.statusOpenText
                              //     : TAppColors.textPrimary,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              maxLine: 1,
                              textOverFlow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        size: 15,
                        color: TAppColors.textMuted,
                      ),
                      8.0.width,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonText(
                              text: 'EST. DURATION',
                              fontColor: TAppColors.textHint,
                              fontSize: 9.5,
                              fontWeight: FontWeight.bold,
                              maxLine: 1,
                              textOverFlow: TextOverflow.ellipsis,
                            ),
                            2.0.height,
                            CommonText(
                              text:
                                  "${service.durationMin} - ${service.durationMax}",
                              fontColor: TAppColors.textPrimary,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              maxLine: 1,
                              textOverFlow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          14.0.height,

          // Required Documents Section
          Row(
            children: [
              const Icon(
                Icons.checklist_rtl,
                size: 14,
                color: TAppColors.textMuted,
              ),
              6.0.width,
              CommonText(
                text:
                    'Required Documents (${service.requiredDocuments.length})',
                fontColor: TAppColors.textSecondary,
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
          8.0.height,
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: service.requiredDocuments.map((doc) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: TAppColors.inputFill,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: TAppColors.border),
                ),
                child: CommonText(
                  text: doc,
                  fontColor: TAppColors.textSecondary,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              );
            }).toList(),
          ),
          14.0.height,
          const Divider(color: TAppColors.border, height: 1),
          12.0.height,

          // Bottom Action Row: Deactivate / Activate & Edit Details
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: onToggleStatus,
                child: CommonText(
                  text: service.isActive ? 'Deactivate' : 'Activate',
                  fontColor: service.isActive
                      ? TAppColors.errorTitle
                      : TAppColors.statusOpenText,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              16.0.width,
              CommonElevatedButton(
                onButtonPressed: onEditDetails,
                backgroundColor: TAppColors.surface,
                borderColor: TAppColors.border,
                borderWidth: 1.0,
                borderRadius: 8.0,
                elevatedPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 7,
                ),
                custom: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.edit_outlined,
                      size: 13,
                      color: TAppColors.primary,
                    ),
                    6.0.width,
                    CommonText(
                      text: 'Edit Details',
                      fontColor: TAppColors.primary,
                      fontSize: 11.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.isActive});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
      decoration: BoxDecoration(
        color: isActive ? TAppColors.statusOpenBg : TAppColors.errorBg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isActive
              ? TAppColors.statusOpenBorder
              : TAppColors.errorBorder,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.circle,
            size: 6,
            color: isActive ? TAppColors.statusOpenText : TAppColors.errorIcon,
          ),
          4.0.width,
          CommonText(
            text: isActive ? 'Active' : 'Inactive',
            fontColor: isActive
                ? TAppColors.statusOpenText
                : TAppColors.errorTitle,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }
}
