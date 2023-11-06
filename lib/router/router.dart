import 'package:amazon_clone/common/widgets/bottom_bar.dart';
import 'package:amazon_clone/feature/auth/screens/auth_screen.dart';
import 'package:amazon_clone/feature/home/screens/home_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const AuthScreen(),
        settings: routeSettings,
      );
    case HomeScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const HomeScreen(),
        settings: routeSettings,
      );
    case BottomBar.routeName:
      return MaterialPageRoute(
        builder: (context) => const BottomBar(),
        settings: routeSettings,
      );

    default:
      return MaterialPageRoute(
          builder: (context) => const Text("Error! Page not found"));
  }
}
