import 'package:concentric_transition/concentric_transition.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/firebase/auth_service.dart';
import 'package:flutter_demo/provider/flags_provider.dart';
import 'package:flutter_demo/provider/theme_provider.dart';
import 'package:flutter_demo/routes.dart';
import 'package:flutter_demo/screens/concentric_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

//AIzaSyC8pmLdrMOyeMW3yHPO6Li6jjsCf_O64WU  Api de mapas
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SharedPreferences prefs = await SharedPreferences.getInstance();

  String theme;
  if (prefs.getString('theme') != null) {
    theme = prefs.getString('theme')!;
  } else {
    theme = 'oscuro';
  }

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
          create: (context) => ThemeProvider(context, theme)),
      ChangeNotifierProvider<FlagsProvider>(
          create: (context) => FlagsProvider()),
      ChangeNotifierProvider<AuthService>(create: (context) => AuthService())
    ],
    child: PMSNApp(),
  ));
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(providers: [
//       ChangeNotifierProvider(create: (context) => ThemeProvider(context, 'theme')),
//       ChangeNotifierProvider<FlagsProvider>(
//           create: (context) => FlagsProvider()),
//     ], child: PMSNApp());
//   }
// }

class PMSNApp extends StatelessWidget {
  PMSNApp({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = Provider.of<ThemeProvider>(context);
    return MaterialApp(
        theme: theme.getThemeData(),
        routes: getApplicationRoutes(),
        home: ConcentricTrasition());
  }
}
