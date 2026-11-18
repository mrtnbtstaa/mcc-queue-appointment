import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../../../core/theme/app_colors.dart';

class WelcomeBanner extends StatelessWidget {
  const WelcomeBanner({super.key});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: TAppColors.surface,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.04),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _WelcomeGreeting(),
        const SizedBox(height: 16),
        const _CurrentDateChip(),
      ],
    ),
  );
}

class _WelcomeGreeting extends StatelessWidget {
  const _WelcomeGreeting();

  @override
  Widget build(BuildContext context) => const Row(
    children: [
      CircleAvatar(
        radius: 26,
        backgroundColor: TAppColors.primary,
        child: Icon(Icons.person, color: TAppColors.surface),
      ),
      SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome back!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: TAppColors.textPrimary,
              ),
            ),
            SizedBox(height: 2),
            Text(
              'Here is an overview of your account.',
              style: TextStyle(fontSize: 12, color: TAppColors.textMuted),
            ),
          ],
        ),
      ),
    ],
  );
}

class _CurrentDateChip extends StatelessWidget {
  const _CurrentDateChip();

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: TAppColors.background,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        const Icon(Icons.calendar_today, size: 14, color: TAppColors.primary),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            DateFormat('MMMM d, yyyy - EEEE, h:mm a').format(DateTime.now()),
            style: const TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w500,
              color: TAppColors.textSecondary,
            ),
          ),
        ),
      ],
    ),
  );
}
