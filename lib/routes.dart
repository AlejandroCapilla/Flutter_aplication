import 'package:flutter/material.dart';
import 'package:flutter_demo/screens/about_us_screen.dart';
import 'package:flutter_demo/screens/concentric_transition.dart';
import 'package:flutter_demo/screens/dashboard_screen.dart';
import 'package:flutter_demo/screens/detail_favorite_movie_screen.dart';
import 'package:flutter_demo/screens/detail_movie_screen.dart';
import 'package:flutter_demo/screens/events_screen.dart';
import 'package:flutter_demo/screens/favorite_movies_screen.dart';
import 'package:flutter_demo/screens/home_page.dart';
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
    '/home': (BuildContext context) => const HomePage(),
    '/about': (BuildContext context) => const AboutUsScreen(),
    '/movie_detail': (BuildContext context) => DetailMovieScreen(),
    '/favorite_movie_detail': (BuildContext context) =>
        const DetailFavoriteMovieScreen(),
    '/favorite_movies': (BuildContext context) => const FavoriteMoviesScreen(),
  };
}
