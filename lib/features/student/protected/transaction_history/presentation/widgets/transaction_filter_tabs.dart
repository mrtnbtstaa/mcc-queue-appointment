import 'package:material_ui/material_ui.dart';

import '../../../../../../core/widgets/common_filter_chips.dart';

class TransactionFilterTabs extends StatelessWidget {
  final int selectedFilterIndex;
  final ValueChanged<int> onFilterChanged;
  const TransactionFilterTabs({
    super.key,
    required this.selectedFilterIndex,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          CommonFilterChips(
            items: [
              FilterChipItem(icon: Icons.list_alt, label: "All"),
              FilterChipItem(
                icon: Icons.calendar_today_outlined,
                label: "Appointments",
              ),
              FilterChipItem(
                icon: Icons.description_outlined,
                label: "Transactions",
              ),
            ],
            selectedFilterIndex: selectedFilterIndex,
            onFilterChanged: onFilterChanged,
          ),
        ],
      ),
    );
  }
}
