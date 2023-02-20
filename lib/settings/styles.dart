import 'package:flutter/material.dart';

class StylesApp {
  static Color appPrimaryColor = Color.fromARGB(255, 6, 126, 122);

  static ThemeData darkTheme() {
    final ThemeData theme = ThemeData.dark();
    return theme;
  }

  static ThemeData lightTheme() {
    final ThemeData theme = ThemeData.light();
    return theme;
  }
}
