import 'package:material_ui/material_ui.dart';

import '../extensions/context_extension.dart';
import '../theme/app_colors.dart';

abstract final class CommonResponsiveModal {
  static Future<T?> show<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    bool isScrollControlled = true,
    bool showDragHandle = false,
    bool useSafeArea = true,
    Color backgroundColor = TAppColors.surface,
    Color? barrierColor,
    double maxWidth = 720,
  }) {
    if (context.isMobile) {
      return showModalBottomSheet<T>(
        context: context,
        isScrollControlled: isScrollControlled,
        showDragHandle: showDragHandle,
        useSafeArea: useSafeArea,
        backgroundColor: backgroundColor,
        barrierColor: barrierColor,
        builder: builder,
      );
    }

    return showDialog<T>(
      context: context,
      barrierColor: barrierColor,
      builder: (context) => Dialog(
        backgroundColor: backgroundColor,
        insetPadding: const EdgeInsets.all(24),
        clipBehavior: Clip.antiAlias,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: maxWidth,
            maxHeight: MediaQuery.sizeOf(context).height * 0.9,
          ),
          child: builder(context),
        ),
      ),
    );
  }
}
