import 'package:flutter/material.dart';

class StylesApp {
  //static Color appPrimaryColor = Color.fromARGB(255, 6, 126, 122);

  static ThemeData darkTheme(BuildContext context) {
    final ThemeData theme = ThemeData.dark();
    return theme.copyWith(
      colorScheme: Theme.of(context)
          .colorScheme
          .copyWith(primary: Color.fromARGB(255, 8, 103, 37)),
    );
  }

  static ThemeData lightTheme(BuildContext context) {
    final ThemeData theme = ThemeData.light();
    return theme.copyWith(
      colorScheme: Theme.of(context)
          .colorScheme
          .copyWith(primary: Color.fromARGB(255, 8, 103, 37)),
    );
  }

  static ThemeData linceTheme(BuildContext context) {
    final ThemeData theme = ThemeData.light();
    return theme.copyWith(
      colorScheme: Theme.of(context)
          .colorScheme
          .copyWith(primary: Color.fromARGB(255, 163, 119, 24)),
    );
  }
}
