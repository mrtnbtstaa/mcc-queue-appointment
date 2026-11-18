import 'package:material_ui/material_ui.dart';

import '../../../../../../../core/theme/app_colors.dart';

class AvailableSlotsList extends StatelessWidget {
  const AvailableSlotsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 8,
          runSpacing: 2,
          children: const [
            Text(
              'Available Slots for Oct 3, 2026',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: TAppColors.textPrimary,
              ),
            ),
            Text(
              '4 slots total',
              style: TextStyle(fontSize: 11, color: TAppColors.textMuted),
            ),
          ],
        ),
        const SizedBox(height: 10),
        _buildSlotCard(
          '09:00 AM – 10:00 AM',
          'Morning Session - General Clearance',
          '3 slots left',
          TAppColors.errorBg,
          TAppColors.errorTitle,
          true,
          false,
        ),
        const SizedBox(height: 8),
        _buildSlotCard(
          '10:00 AM – 11:00 AM',
          'Mid-morning Session',
          '1 slot left',
          TAppColors.warningBg,
          TAppColors.warningText,
          false,
          false,
        ),
        const SizedBox(height: 8),
        _buildSlotCard(
          '01:00 PM – 02:00 PM',
          'Afternoon Session',
          '5 slots left',
          TAppColors.successBg,
          TAppColors.successText,
          false,
          false,
        ),
        const SizedBox(height: 8),
        _buildSlotCard(
          '02:00 PM – 03:00 PM',
          'Afternoon Session - Fully Occupied',
          'Full',
          TAppColors.border,
          TAppColors.textMuted,
          false,
          true,
        ),
      ],
    );
  }

  Widget _buildSlotCard(
    String time,
    String subtitle,
    String badgeText,
    Color badgeColor,
    Color badgeTextColor,
    bool isSelected,
    bool isFull,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isFull ? TAppColors.background : TAppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? TAppColors.primary : TAppColors.border,
          width: isSelected ? 1.5 : 1,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 8,
                  runSpacing: 2,
                  children: [
                    Text(
                      time,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: isFull
                            ? TAppColors.textMuted
                            : TAppColors.textPrimary,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: badgeColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        badgeText,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: badgeTextColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 11,
                    color: isFull ? TAppColors.textHint : TAppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
          RadioGroup<bool>(
            groupValue: isSelected ? true : null, // Moved groupValue here
            onChanged: (val) => {},
            // onChanged: isFull
            //     ? null
            //     : (value) {
            //         // Handle change selection here
            //       },
            child: Radio<bool>(
              value: true,
              activeColor: TAppColors.primary,
              // groupValue and onChanged are removed from here
            ),
          ),
        ],
      ),
    );
  }
}
