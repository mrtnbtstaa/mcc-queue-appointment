import 'package:material_ui/material_ui.dart';

import '../../../../../../core/theme/app_colors.dart';

class PortalStatusBanner extends StatelessWidget {
  const PortalStatusBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 8,
      runSpacing: 4,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.verified, size: 16, color: TAppColors.primary),
            SizedBox(width: 6),
            Text(
              'OFFICIAL REGISTRAR PORTAL',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: TAppColors.primary,
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: TAppColors.successBg,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              CircleAvatar(radius: 3, backgroundColor: TAppColors.successText),
              SizedBox(width: 6),
              Text(
                'Counters Online',
                style: TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.bold,
                  color: TAppColors.successText,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
