import 'package:material_ui/material_ui.dart';

extension ContextBreakpoints on BuildContext {
  double get screenWidth => MediaQuery.sizeOf(this).width;

  bool get isMobile => screenWidth < 600;

  bool get isTablet => screenWidth >= 600 && screenWidth < 1024;

  bool get isDesktop => screenWidth >= 1024;
}
