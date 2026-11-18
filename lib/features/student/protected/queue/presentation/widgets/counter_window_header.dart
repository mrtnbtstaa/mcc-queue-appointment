import 'package:material_ui/material_ui.dart';

import '../../../../../../core/extensions/double_extension.dart';
import '../../../../../../core/style/font.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/common_text.dart';

class CounterWindowHeader extends StatelessWidget {
  final String serviceName;

  const CounterWindowHeader({super.key, this.serviceName = ''});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: TAppColors.primary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 8,
        runSpacing: 2,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.desktop_windows,
                size: 16,
                color: TAppColors.surface,
              ),
              8.0.width,
              CommonText(
                text: serviceName.isEmpty ? 'Registrar Counter' : serviceName,
                fontSize: TFont.font12,
                fontWeight: FontWeight.bold,
                fontColor: TAppColors.surface,
              ),
            ],
          ),
          CommonText(
            text: 'COUNTER ACTIVE',
            fontSize: TFont.font8,
            fontWeight: FontWeight.bold,
            fontColor: TAppColors.background,
          ),
        ],
      ),
    );
  }
}
