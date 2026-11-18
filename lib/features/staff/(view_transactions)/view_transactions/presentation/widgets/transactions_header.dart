import 'package:material_ui/material_ui.dart';

import '../../../../../../../core/theme/app_colors.dart';
import '../../../../../../../core/widgets/common_text.dart';

class TransactionsHeader extends StatelessWidget {
  const TransactionsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText(
          text: 'Transaction Records Archive',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontColor: TAppColors.textPrimary,
        ),
        SizedBox(height: 4),
        CommonText(
          text: 'Search, filter, and audit all processed student transactions and service logs.',
          fontSize: 12,
          fontColor: TAppColors.textSecondary,
        ),
      ],
    );
  }
}
