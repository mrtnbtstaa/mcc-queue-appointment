import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../../../core/router/app_routes.dart';
import '../../../../../../core/theme/app_colors.dart';

class RecentTransactionsSection extends StatelessWidget {
  final int? total;
  const RecentTransactionsSection({super.key, this.total});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Recent Records',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: TAppColors.textPrimary,
              ),
            ),
            TextButton(
              onPressed: () => context.go(AppRoutes.historyPath),
              child: const Text('View All'),
            ),
          ],
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(
            Icons.receipt_long_outlined,
            color: TAppColors.primary,
          ),
          title: Text(
            total == null
                ? 'Loading record summary...'
                : '$total recent records',
          ),
          subtitle: const Text('Your transaction and registrar records'),
        ),
      ],
    ),
  );
}
