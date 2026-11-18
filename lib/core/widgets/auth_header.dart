import 'package:material_ui/material_ui.dart';

import '../../../../../../core/style/font.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/common_text.dart';

class AuthHeader extends StatelessWidget implements PreferredSizeWidget {
  const AuthHeader({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(65);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: TAppColors.primary,
      elevation: 0,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(
            text: "Mabalacat City College",
            fontColor: TAppColors.surface,
            fontSize: TFont.font12,
            fontWeight: FontWeight.bold,
            maxLine: 1,
            textOverFlow: TextOverflow.ellipsis,
          ),
          CommonText(
            text: "Registrar's Office • Student Services System",
            fontColor: TAppColors.surface,
            fontSize: TFont.font8,
            maxLine: 1,
            textOverFlow: TextOverflow.ellipsis,
          ),
        ],
      )
    );
  }
}
