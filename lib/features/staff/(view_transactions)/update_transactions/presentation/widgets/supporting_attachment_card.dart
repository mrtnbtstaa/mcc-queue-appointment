import 'package:material_ui/material_ui.dart';

import '../../../../../../core/extensions/double_extension.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/common_text.dart';

class SupportingAttachmentCard extends StatelessWidget {
  const SupportingAttachmentCard({super.key});

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
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(
            text: 'Supporting Attachment / Digital Seal',
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          12.0.height,
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: TAppColors.background,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: TAppColors.border,
                style: BorderStyle.none,
              ),
            ),
            child: Column(
              children: [
                const Icon(
                  Icons.cloud_upload_outlined,
                  size: 28,
                  color: TAppColors.primary,
                ),
                8.0.height,
                CommonText(
                  text: 'Upload signed clearance or scanned slip',
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                2.0.height,
                CommonText(
                  text: 'PDF, PNG, or JPG up to 10MB',
                  fontSize: 10,
                  fontColor: TAppColors.textHint,
                ),
              ],
            ),
          ),
          12.0.height,
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: TAppColors.background,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: TAppColors.border),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.insert_drive_file,
                  color: TAppColors.primary,
                  size: 20,
                ),
                10.0.width,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText(
                        text: 'TOR_Validation_Clearance_...',
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                      2.0.height,
                      CommonText(
                        text: '1.4 MB • Signed by Evaluator',
                        fontSize: 10,
                        fontColor: TAppColors.textHint,
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.visibility_outlined,
                  size: 18,
                  color: TAppColors.textSecondary,
                ),
                10.0.width,
                const Icon(
                  Icons.delete_outline,
                  size: 18,
                  color: TAppColors.errorIcon,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
