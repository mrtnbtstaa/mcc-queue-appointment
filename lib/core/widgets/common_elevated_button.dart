import 'package:material_ui/material_ui.dart';

import '../extensions/int_extension.dart';
import '../style/dimension.dart';
import '../theme/app_colors.dart';

class CommonElevatedButton extends ElevatedButton {
  CommonElevatedButton({
    super.key,
    this.onButtonPressed,
    this.text,
    this.fontColor,
    this.backgroundColor,
    this.borderColor,
    this.fontWeight,
    this.fontSize,
    this.borderRadius,
    this.padding,
    this.width,
    this.height,
    this.borderWidth,
    this.textAlign,
    this.alignment,
    this.clip,
    this.elevation,
    this.splashColor,
    this.overlayColor,
    this.shadowColor,
    this.border,
    this.borderSide,
    this.splashFactory,
    this.custom,
    this.elevatedPadding,
  }) : super(
         onPressed: onButtonPressed,
         clipBehavior: clip ?? Clip.none,
         style: ElevatedButton.styleFrom(
           elevation: elevation ?? 0.0,
           overlayColor: overlayColor,
           padding:
               elevatedPadding ??
               EdgeInsets.symmetric(horizontal: Dimension.padding16),
           animationDuration: 500.seconds(),
           splashFactory: splashFactory ?? InkRipple.splashFactory,
           backgroundColor:
               backgroundColor ??
               TAppColors.primary, // Updated default theme background
           foregroundColor:
               fontColor ??
               Colors.white, // Ensures correct ripple/text contrast defaults
           shape:
               border ??
               RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(
                   borderRadius ?? Dimension.radius10,
                 ),
                 side:
                     borderSide ??
                     BorderSide(
                       color: borderColor ?? Colors.transparent, // Defaults to transparent unless specified
                       width: borderWidth ?? 0.0,
                     ),
               ),
           shadowColor: shadowColor ?? Colors.transparent,
         ),
         child:
             custom ??
             Container(
               alignment: alignment ?? Alignment.center,
               padding: padding ?? EdgeInsets.zero,
               width: width, // Removed '?? 0.0' so unconstrained width works naturally inside rows/columns
               height: height,
               child: Text(
                 text ?? "",
                 style: TextStyle(
                   color: fontColor ?? Colors.white, // Defaults to white text on primary background
                   fontWeight:
                       fontWeight ??
                       FontWeight.w600, // Standardizes clean default weight
                   fontSize:
                       fontSize, // Falls back to theme/default style if null
                 ),
                 textAlign: textAlign ?? TextAlign.center,
               ),
             ),
       );

  final VoidCallback? onButtonPressed;
  final String? text;
  final Color? fontColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final FontWeight? fontWeight;
  final double? fontSize;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;
  final double? borderWidth;
  final TextAlign? textAlign;
  final Alignment? alignment;
  final Clip? clip;
  final double? elevation;
  final Color? splashColor;
  final Color? overlayColor;
  final Color? shadowColor;
  final OutlinedBorder? border;
  final BorderSide? borderSide;
  final InteractiveInkFeatureFactory? splashFactory;
  final Widget? custom;
  final EdgeInsetsGeometry? elevatedPadding;
}
