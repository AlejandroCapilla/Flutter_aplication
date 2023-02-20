import 'package:flutter/material.dart';
import 'package:flutter_demo/provider/theme_provider.dart';
import 'package:flutter_demo/routes.dart';
import 'package:provider/provider.dart';

import 'screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ThemeProvider(), child: PMSNApp());
  }
}

class PMSNApp extends StatelessWidget {
  PMSNApp({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = Provider.of<ThemeProvider>(context);

    return MaterialApp(
        theme: theme.getThemeData(),
        routes: getApplicationRoutes(),
        home: const LoginScreen());
  }
}
