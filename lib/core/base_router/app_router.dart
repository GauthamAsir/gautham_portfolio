import 'package:flutter/material.dart';
import 'package:gautham_portfolio/core/base_widgets/error_screen.dart';
import 'package:gautham_portfolio/screens/main/initial_screen.dart';
import 'package:gautham_portfolio/screens/main/main_screen.dart';
import 'package:gautham_portfolio/screens/splash/splash_screen.dart';

class AppRouter {
  static const String initialRouteName = SplashScreen.routeName;

  static Widget getWidget(RouteSettings routeSettings) {
    final Map<String, dynamic> args;

    if (routeSettings.arguments != null) {
      args = routeSettings.arguments as Map<String, dynamic>;
    } else {
      args = {};
    }

    switch (routeSettings.name) {
      case SplashScreen.routeName:
        return const SplashScreen();
      case InitialScreen.routeName:
        return const InitialScreen();
      case MainScreen.routeName:
        return const MainScreen();
      default:
        return const ErrorScreen();
    }
  }
}
