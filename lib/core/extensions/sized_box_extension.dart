import 'package:flutter/widgets.dart';

extension SizedBoxExtension on SizedBox {
  /// Wraps any widget inside this [SizedBox] dimensions.
  Widget child(Widget widget) {
    return SizedBox(key: key, width: width, height: height, child: widget);
  }
}

/// Helper extension for creating square [SizedBox] widgets easily.
extension SquareSizedBox on num {
  /// Creates a square [SizedBox] where both width and height equal this number.
  Widget get squareBox => SizedBox(width: toDouble(), height: toDouble());
}
