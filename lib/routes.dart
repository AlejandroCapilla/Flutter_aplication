import 'package:flutter/material.dart';
import 'package:flutter_demo/screens/concentric_transition.dart';
import 'package:flutter_demo/screens/dashboard_screen.dart';
import 'package:flutter_demo/screens/events_screen.dart';
import 'package:flutter_demo/screens/login_screen.dart';
import 'package:flutter_demo/screens/popular_movies_screen.dart';
import 'package:flutter_demo/screens/register_screen.dart';
import 'package:flutter_demo/screens/settings_screen.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/register': (BuildContext context) => const RegisterScreen(),
    '/dash': (BuildContext context) => const DashboardScreen(),
    '/popular': (BuildContext context) => const PopularMoviesScreen(),
    '/concentric': (BuildContext context) => ConcentricTrasition(),
    '/login': (BuildContext context) => const LoginScreen(),
    '/settings': (BuildContext context) => const SettingsScreen(),
    '/events': (BuildContext context) => const EventsScreen(),
  };
}
