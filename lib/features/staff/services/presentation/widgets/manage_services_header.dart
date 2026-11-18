import 'package:material_ui/material_ui.dart';

import '../../../../../../core/extensions/double_extension.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/common_elevated_button.dart';
import '../../../../../../core/widgets/common_text.dart';

class ManageServicesHeader extends StatelessWidget {
  const ManageServicesHeader({super.key, required this.onAddService});

  final VoidCallback onAddService;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText(
                    text: 'Manage Registrar Services',
                    fontColor: TAppColors.textPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                  6.0.height,
                  CommonText(
                    text: 'Configure available student services, requirements, fees, and active...',
                    fontColor: TAppColors.textMuted,
                    fontSize: 12,
                    height: 1.35,
                  ),
                ],
              ),
            ),
            12.0.width,
            CommonElevatedButton(
              onButtonPressed: onAddService,
              backgroundColor: TAppColors.primary,
              borderRadius: 10.0,
              elevatedPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 10,
              ),
              custom: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.add, size: 16, color: TAppColors.surface),
                  4.0.width,
                  CommonText(
                    text: 'Add Service',
                    fontColor: TAppColors.surface,
                    fontSize: 12.5,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),
          ],
        ),
        14.0.height,
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: TAppColors.promoBg,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: TAppColors.promoBorder),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.info_outline,
                size: 16,
                color: TAppColors.primary,
              ),
              8.0.width,
              Expanded(
                child: CommonText(
                  text: 'Deactivating a service immediately hides it from the student booking catalog and kiosk displays.',
                  fontColor: TAppColors.textSecondary,
                  fontSize: 11.5,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
