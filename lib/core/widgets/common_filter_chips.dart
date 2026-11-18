import 'package:material_ui/material_ui.dart';

import '../../../../../../core/extensions/double_extension.dart';
import '../../../../../../core/style/font.dart';
import '../../../../../../core/widgets/common_text.dart';

class FilterChipItem {
  final IconData icon;
  final String label;

  const FilterChipItem({required this.icon, required this.label});
}

class CommonFilterChips extends StatelessWidget {
  final int selectedFilterIndex;
  final ValueChanged<int> onFilterChanged;
  final List<FilterChipItem> items;
  final Color selectedColor;
  final Color unselectedTextColor;
  final Color selectedTextColor;
  final Color iconColor;
  final double spacing;

  const CommonFilterChips({
    super.key,
    required this.items,
    required this.selectedFilterIndex,
    required this.onFilterChanged,
    this.selectedColor = const Color(0xFF7A1822),
    this.selectedTextColor = Colors.white,
    this.unselectedTextColor = const Color(0xFF1F2937),
    this.iconColor = const Color(0xFF7A1822),
    this.spacing = 8,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (int i = 0; i < items.length; i++) ...[
            _buildFilterChip(i, items[i]),
            if (i != items.length - 1) spacing.width,
          ],
        ],
      ),
    );
  }

  Widget _buildFilterChip(int index, FilterChipItem item) {
    final isSelected = selectedFilterIndex == index;

    return ChoiceChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            item.icon,
            size: 14,
            color: isSelected ? selectedTextColor : iconColor,
          ),
          6.0.width,
          CommonText(
            text: item.label,
            fontSize: TFont.font12,
            fontColor: isSelected ? selectedTextColor : unselectedTextColor,
          ),
        ],
      ),
      selected: isSelected,
      selectedColor: selectedColor,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      side: BorderSide(
        color: isSelected ? selectedColor : const Color(0xFFE5E7EB),
      ),
      onSelected: (_) => onFilterChanged(index),
    );
  }
}
