import 'package:material_ui/material_ui.dart';

import '../../../../../../core/extensions/double_extension.dart';
import '../../../../../../core/style/font.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/common_filter_chips.dart';
import '../../../../../../core/widgets/common_text.dart';
import '../../../../../../core/widgets/common_text_field.dart';

class SearchAndFilterBar extends StatelessWidget {
  final int selectedFilterIndex;
  final ValueChanged<int> onFilterChanged;
  final ValueChanged<String> onSearchChanged;

  const SearchAndFilterBar({
    super.key,
    required this.selectedFilterIndex,
    required this.onFilterChanged,
    required this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText(
          text: 'Registrar Services',
          fontColor: TAppColors.textPrimary,
          fontSize: TFont.font20,
          fontWeight: FontWeight.bold,
        ),
        4.0.height,
        CommonText(
          text: 'Choose a service to start your request or reserve an on-campus appointment slot.',
          fontSize: TFont.font12,
          fontColor: TAppColors.textSecondary,
        ),
        12.0.height,
        // Search bar
        CommonTextField(
          fillColor: TAppColors.surface,
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
          onChanged: onSearchChanged,
          prefixIcon: const Icon(
            Icons.search,
            color: TAppColors.textMuted,
            size: 20,
          ),
          hintStyle: const TextStyle(fontSize: 12, color: TAppColors.textMuted),
          hintText: "Search registrar services (e.g. TOR, Enrollment)...",
        ),
        12.0.height,
        // Filter Chips
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              CommonFilterChips(
                items: [
                  FilterChipItem(icon: Icons.grid_view, label: "All Services"),
                  FilterChipItem(
                    icon: Icons.school_outlined,
                    label: "Enrollment",
                  ),
                  FilterChipItem(
                    icon: Icons.card_membership_outlined,
                    label: "Certificates",
                  ),
                  FilterChipItem(icon: Icons.folder_outlined, label: "Records"),
                ],
                selectedFilterIndex: selectedFilterIndex,
                onFilterChanged: onFilterChanged,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
