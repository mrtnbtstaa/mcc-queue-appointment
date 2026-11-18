extension StringExtension on String {
  /// Checks if the string is null, empty, or contains only whitespace.
  bool get isNullOrEmpty => trim().isEmpty;

  /// Checks if the string is not null, empty, or whitespace.
  bool get isNotNullOrEmpty => trim().isNotEmpty;

  /// Capitalizes the first letter of the string.
  String capitalize() {
    if (isEmpty) return this;
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  /// Capitalizes the first letter of every word in the string.
  String capitalizeWords() {
    if (isEmpty) return this;
    return split(' ').map((word) => word.capitalize()).join(' ');
  }

  /// Basic email validation check.
  bool get isValidEmail {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(this);
  }
}
