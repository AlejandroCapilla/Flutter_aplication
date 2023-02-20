import 'package:flutter/material.dart';
import 'package:flutter_demo/settings/styles.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData? _themeData = StylesApp.darkTheme();

  getThemeData() => _themeData;

  setThemeData(ThemeData theme) {
    _themeData = theme;
    notifyListeners();
  }
}
