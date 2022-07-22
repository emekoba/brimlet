import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();
  BuildContext? context;

  static final ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xff1D212B),
    scaffoldBackgroundColor: const Color(0xff4a4a58),
    iconTheme: const IconThemeData(color: Colors.redAccent),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      brightness: Brightness.dark,
      secondary: const Color(0xff4a4a58),
    ),
  );
}
