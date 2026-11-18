import 'package:material_ui/material_ui.dart';

import '../../../../../../core/extensions/double_extension.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/common_text.dart';

class CounterStatusBadge extends StatelessWidget {
  final bool isOnline;
  final ValueChanged<bool> onChanged;

  const CounterStatusBadge({
    super.key,
    required this.isOnline,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: TAppColors.successBg,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: TAppColors.successBorder),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 4,
                  backgroundColor: TAppColors.success,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: CommonText(
                    text: 'Assigned Counter: Window 2 – Enrollment & Records (Active)',
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    fontColor: TAppColors.success,
                    maxLine: 2,
                    textOverFlow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
        8.0.width,
        Row(
          children: [
            CommonText(
              text: 'Online',
              fontSize: 11,
              fontColor: TAppColors.textHint,
            ),
            const SizedBox(width: 6),
            Switch(
              value: isOnline,
              onChanged: onChanged,
              activeThumbColor: TAppColors.success,
            ),
          ],
        ),
      ],
    );
  }
}
