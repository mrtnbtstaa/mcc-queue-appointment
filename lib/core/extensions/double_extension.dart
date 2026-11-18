import 'package:flutter/widgets.dart';

extension DoubleExtension on double {
  /// Creates a vertical [SizedBox] with height equal to this double value.
  SizedBox get height => SizedBox(height: this);

  /// Creates a horizontal [SizedBox] with height equal to this double value.
  SizedBox get width => SizedBox(width: this);
}
