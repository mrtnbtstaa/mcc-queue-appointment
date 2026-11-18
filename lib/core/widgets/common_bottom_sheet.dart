import 'package:material_ui/material_ui.dart';

import '../../../../../../core/theme/app_colors.dart';

class CommonBottomSheet extends BottomSheet {
  CommonBottomSheet({
    super.key,
    required super.onClosing,
    required Widget Function(BuildContext) builder,
    super.backgroundColor = TAppColors.surface,
    super.elevation = 0,
    super.shape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    bool showDragHandle = true,
    EdgeInsetsGeometry padding = const EdgeInsets.all(16),
  }) : super(
         builder: (context) => SafeArea(
           child: Padding(
             padding: padding,
             child: Column(
               mainAxisSize: MainAxisSize.min,
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 if (showDragHandle) ...[
                   Center(
                     child: Container(
                       width: 36,
                       height: 4,
                       decoration: BoxDecoration(
                         color: TAppColors.border,
                         borderRadius: BorderRadius.circular(2),
                       ),
                     ),
                   ),
                   const SizedBox(height: 12),
                 ],
                 builder(context),
               ],
             ),
           ),
         ),
       );
}
