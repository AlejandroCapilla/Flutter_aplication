import 'package:flutter/material.dart';
import 'package:flutter_demo/screens/dashboard_screen.dart';
import 'package:flutter_demo/screens/register_screen.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/register': (BuildContext context) => const RegisterScreen(),
    '/dash': (BuildContext context) => const DashboardScreen(),
  };
}
