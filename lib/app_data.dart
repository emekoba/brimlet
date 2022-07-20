import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();
  BuildContext? context;

  // static final ThemeData light = ThemeData(
  //   brightness: Brightness.light,
  //   primaryColor: Colors.white,
  //   scaffoldBackgroundColor: const Color.fromRGBO(231, 238, 241, 0.938),
  //   iconTheme: const IconThemeData(
  //     color: Colors.black,
  //   ),
  //   floatingActionButtonTheme: const FloatingActionButtonThemeData(
  //     foregroundColor: Colors.white,
  //   ),
  //   appBarTheme: const AppBarTheme(
  //     color: Colors.white,
  //   ),
  //   bottomNavigationBarTheme: const BottomNavigationBarThemeData(
  //     backgroundColor: Colors.white,
  //   ),
  //   colorScheme: ColorScheme.fromSwatch().copyWith(
  //     secondary: Colors.grey,
  //   ),
  // );

  static final ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xff1D212B),
    scaffoldBackgroundColor: const Color(0xff4a4a58),
    iconTheme: const IconThemeData(color: Colors.redAccent),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      brightness: Brightness.dark,
      secondary: const Color(0xff4a4a58),
    ),
    // textTheme: Theme.of(context).textTheme.apply(
    //       bodyColor: Colors.pinkAccent, //<-- SEE HERE
    //       displayColor: Colors.pinkAccent, //<-- SEE HERE
    //     ),
  );
}
