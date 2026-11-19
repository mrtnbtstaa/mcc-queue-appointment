import 'package:material_ui/material_ui.dart';

import '../../../../../../core/theme/app_colors.dart';

class PriorityCounterNotice extends StatelessWidget {
  const PriorityCounterNotice({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: TAppColors.errorBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: TAppColors.errorBorder.withValues(alpha: 0.5),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Icon(Icons.info_outline, color: TAppColors.errorTitle, size: 18),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Priority Counter Notice',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: TAppColors.errorTitle,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Review document prerequisites before booking.',
                  style: TextStyle(fontSize: 11, color: TAppColors.errorText),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
