import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../../../core/extensions/double_extension.dart';
import '../../../../../../core/style/font.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/common_filter_chips.dart';
import '../../../../../../core/widgets/common_text.dart';
import '../../../../../../core/widgets/common_text_field.dart';
import '../../../../../shared/filter_options/presentation/filter_options_cubit.dart';

class SearchAndFilterBar extends StatelessWidget {
  final String? selectedCategory;
  final ValueChanged<String?> onFilterChanged;
  final ValueChanged<String> onSearchChanged;

  const SearchAndFilterBar({
    super.key,
    required this.selectedCategory,
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
              BlocBuilder<FilterOptionsCubit, FilterOptionsState>(
                builder: (context, filterState) {
                  final categories =
                      filterState.options.serviceCategories;
                  final selectedIndex = selectedCategory == null
                      ? 0
                      : categories.indexWhere(
                              (category) =>
                                  category.value == selectedCategory,
                            ) +
                            1;

                  return CommonFilterChips(
                    items: [
                      const FilterChipItem(
                        icon: Icons.grid_view,
                        label: 'All Services',
                      ),
                      for (final category in categories)
                        FilterChipItem(
                          icon: Icons.folder_outlined,
                          label: category.label,
                        ),
                    ],
                    selectedFilterIndex: selectedIndex,
                    onFilterChanged: (index) => onFilterChanged(
                      index == 0 ? null : categories[index - 1].value,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
