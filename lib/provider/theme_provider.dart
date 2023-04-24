import 'package:flutter/material.dart';
import 'package:flutter_demo/settings/styles.dart';

class ThemeProvider with ChangeNotifier {
  ThemeProvider(BuildContext context, String theme) {
    if (theme == 'oscuro') {
      _themeData = StylesApp.darkTheme(context);
    } else if (theme == 'claro') {
      _themeData = StylesApp.lightTheme(context);
    } else {
      _themeData = StylesApp.linceTheme(context);
    }
    _theme = theme;
  }

  ThemeData? _themeData;
  String? _theme;

  getThemeData() => _themeData;

  setThemeData(ThemeData theme) {
    _themeData = theme;
    notifyListeners();
  }

  getTheme() => _theme;
  setTheme(String theme) {
    _theme = theme;
  }
}
