extension IntExtension on int {
  /// Converts an integer into a [Duration] in milliseconds.
  Duration milliseconds() {
    return Duration(milliseconds: this);
  }

  /// Converts an integer into a [Duration] in seconds.
  Duration seconds() {
    return Duration(seconds: this);
  }

  /// Converts an integer into a [Duration] in minutes.
  Duration minutes() {
    return Duration(minutes: this);
  }
}
