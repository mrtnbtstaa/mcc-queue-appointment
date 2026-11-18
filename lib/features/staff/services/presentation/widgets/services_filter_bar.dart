import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../../../core/extensions/double_extension.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/common_text.dart';
import '../../../../../../core/widgets/common_text_field.dart';
import '../../../../shared/filter_options/presentation/filter_options_cubit.dart';
import '../../../../shared/services/presentation/bloc/manage_services_bloc.dart';
import '../../../../shared/services/presentation/bloc/manage_services_event.dart';
import '../../../../shared/services/presentation/bloc/manage_services_state.dart';

class ServicesFilterBar extends StatefulWidget {
  const ServicesFilterBar({super.key, required this.bloc});

  final ManageServicesBloc bloc;

  @override
  State<ServicesFilterBar> createState() => _ServicesFilterBarState();
}

class _ServicesFilterBarState extends State<ServicesFilterBar> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(
      text: widget.bloc.state.searchQuery,
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManageServicesBloc, ManageServicesState>(
      bloc: widget.bloc,
      builder: (context, state) {
        final serviceCategories = context
            .watch<FilterOptionsCubit>()
            .state
            .options
            .serviceCategories;
        final categories = [
          (value: 'All', label: 'All', count: state.allServices.length),
          for (final category in serviceCategories)
            (
              value: category.value,
              label: category.label,
              count: state.allServices
                  .where((service) => service.category == category.value)
                  .length,
            ),
        ];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonTextField(
              hintText: 'Search service name or keyword...',
              controller: _searchController,
              onChanged: (query) {
                widget.bloc.add(SearchServices(query));
              },
              prefixIcon: const Icon(
                Icons.search,
                size: 18,
                color: TAppColors.textHint,
              ),
            ),
            12.0.height,

            // Horizontal Category Chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: categories.map((cat) {
                  final isSelected = state.selectedCategory == cat.value;

                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: GestureDetector(
                      onTap: () =>
                          widget.bloc.add(SelectServiceCategory(cat.value)),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? TAppColors.primary
                              : TAppColors.surface,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected
                                ? TAppColors.primary
                                : TAppColors.border,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CommonText(
                              text: cat.label,
                              fontColor: isSelected
                                  ? TAppColors.surface
                                  : TAppColors.textSecondary,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                            6.0.width,
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 1,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? TAppColors.surface.withValues(alpha: 0.2)
                                    : TAppColors.inputFill,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: CommonText(
                                text: '${cat.count}',
                                fontColor: isSelected
                                    ? TAppColors.surface
                                    : TAppColors.textMuted,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            12.0.height,

            // Status Filter Tabs & Result Counter
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 8,
              runSpacing: 8,
              children: [
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: TAppColors.inputFill,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: TAppColors.border),
                  ),
                  child: Wrap(
                    children: [
                      _StatusTab(
                        label: 'All Status',
                        isSelected:
                            state.statusFilter == ServiceStatusFilter.all,
                        onTap: () => widget.bloc.add(
                          const SelectServiceStatusFilter(
                            ServiceStatusFilter.all,
                          ),
                        ),
                      ),
                      _StatusTab(
                        label: 'Active Only',
                        isSelected:
                            state.statusFilter ==
                            ServiceStatusFilter.activeOnly,
                        onTap: () => widget.bloc.add(
                          const SelectServiceStatusFilter(
                            ServiceStatusFilter.activeOnly,
                          ),
                        ),
                      ),
                      _StatusTab(
                        label: 'Inactive',
                        isSelected:
                            state.statusFilter == ServiceStatusFilter.inactive,
                        onTap: () => widget.bloc.add(
                          const SelectServiceStatusFilter(
                            ServiceStatusFilter.inactive,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                CommonText(
                  text: 'Showing ${state.filteredServices.length} services',
                  fontColor: TAppColors.textMuted,
                  fontSize: 11,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _StatusTab extends StatelessWidget {
  const _StatusTab({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: isSelected ? TAppColors.surface : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 3,
                    offset: const Offset(0, 1),
                  ),
                ]
              : [],
        ),
        child: CommonText(
          text: label,
          fontColor: isSelected ? TAppColors.textPrimary : TAppColors.textMuted,
          fontSize: 11,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
        ),
      ),
    );
  }
}
