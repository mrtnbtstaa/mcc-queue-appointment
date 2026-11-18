import 'package:material_ui/material_ui.dart';

import '../extensions/context_extension.dart';
import '../theme/app_colors.dart';

/// Standard scrolling content area: responsive padding, centered max width.
class CommonPageBody extends StatelessWidget {
  const CommonPageBody({super.key, required this.child, this.maxWidth = 1280});

  final Widget child;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    final horizontal = context.isMobile
        ? 16.0
        : (context.isTablet ? 24.0 : 32.0);

    return Container(
      color: TAppColors.background,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: 20),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: child,
          ),
        ),
      ),
    );
  }
}
