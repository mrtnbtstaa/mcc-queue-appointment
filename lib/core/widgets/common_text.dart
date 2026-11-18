import 'package:flutter/widgets.dart';

import '../style/font.dart';
import '../theme/app_colors.dart';

class CommonText extends Text {
  CommonText({
    super.key,
    this.text,
    this.fontColor,
    this.fontWeight,
    this.fontSize,
    this.alignment,
    this.textDecoration,
    this.letterSpacing,
    this.wordSpacing,
    this.decorationColor,
    this.textOverFlow,
    this.maxLine,
    this.softwrap,
    this.height,
  }) : super(
         text ?? "",
         maxLines: maxLine,
         softWrap: softwrap,
         textAlign: alignment,
         style: TextStyle(
           color: fontColor ?? TAppColors.primary,
           fontWeight: fontWeight ?? FontWeight.normal,
           fontSize:
               fontSize ?? TFont.font12, // Or 14.0 if font14 isn't in Dimension
           decorationColor: decorationColor,
           decoration: textDecoration,
           letterSpacing: letterSpacing ?? 0,
           wordSpacing: wordSpacing ?? 0,
           overflow: textOverFlow,
           height: height,
         ),
       );

  final String? text;
  final Color? fontColor;
  final FontWeight? fontWeight;
  final double? fontSize;
  final TextAlign? alignment;
  final TextDecoration? textDecoration;
  final double? letterSpacing;
  final double? wordSpacing;
  final Color? decorationColor;
  final TextOverflow? textOverFlow;
  final int? maxLine;
  final bool? softwrap;
  final double? height;
}
