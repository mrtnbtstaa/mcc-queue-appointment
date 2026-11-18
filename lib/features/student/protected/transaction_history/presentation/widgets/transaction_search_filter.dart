import 'package:material_ui/material_ui.dart';

import '../../../../../../core/extensions/double_extension.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/common_text_field.dart';

class TransactionSearchFilter extends StatelessWidget {
  final ValueChanged<String> onSearchChanged;
  const TransactionSearchFilter({super.key, required this.onSearchChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search Input Bar
        CommonTextField(
          fillColor: TAppColors.surface,
          contentPadding: EdgeInsets.symmetric(vertical: 0),
          onChanged: onSearchChanged,
          prefixIcon: Icon(Icons.search, color: TAppColors.textMuted, size: 20),
          hintStyle: TextStyle(fontSize: 12, color: TAppColors.textMuted),
          hintText: "Search reference or queue...",
        ),
        10.0.height,

        // Dropdown Filters Row
      ],
    );
  }
}
