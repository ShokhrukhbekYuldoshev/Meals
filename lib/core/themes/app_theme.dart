import 'package:flutter/material.dart';

class AppTheme {
  ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
    );
  }

  ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.dark(),
    );
  }
}
