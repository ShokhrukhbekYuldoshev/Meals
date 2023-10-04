extension StringExtensions on String {
  /// Returns the string with the first letter capitalized.
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }

  /// Returns the string with the first letter of each word capitalized.
  String capitalizeWords() {
    return split(" ").map((str) => str.capitalize()).join(" ");
  }
}
