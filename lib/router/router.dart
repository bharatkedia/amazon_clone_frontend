import 'package:amazon_clone/feature/auth/screens/auth_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(builder: (context) => const AuthScreen());

    default:
      return MaterialPageRoute(
          builder: (context) => const Text("Error! Page not found"));
  }
}
