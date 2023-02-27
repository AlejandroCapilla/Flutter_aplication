import 'package:flutter/material.dart';
import 'package:flutter_demo/settings/styles.dart';

class ThemeProvider with ChangeNotifier {
  ThemeProvider(BuildContext context) {
    _themeData = StylesApp.darkTheme(context);
  }

  ThemeData? _themeData;

  getThemeData() => _themeData;

  setThemeData(ThemeData theme) {
    _themeData = theme;
    notifyListeners();
  }
}
