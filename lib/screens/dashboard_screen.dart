import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/settings/styles.dart';
import 'package:provider/provider.dart';

import '../provider/theme_provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isDarkThemeEnable = true;

  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Lince Sacial :)'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://i.ytimg.com/vi/-LmKCdYhrjg/maxresdefault.jpg'),
                ),
                accountName: Text('Alejandro Capilla'),
                accountEmail: Text('19031028@itcelaya.edu.mx')),
            DayNightSwitcher(
                isDarkModeEnabled: isDarkThemeEnable,
                onStateChanged: ((isDarkModeEnabled) {
                  isDarkModeEnabled
                      ? theme.setThemeData(StylesApp.lightTheme())
                      : theme.setThemeData(StylesApp.darkTheme());

                  isDarkThemeEnable = isDarkModeEnabled;
                  setState(() {});
                }))
          ],
        ),
      ),
    );
  }
}
