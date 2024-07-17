import 'package:amazon_clone/common/widgets/bottom_bar.dart';
import 'package:amazon_clone/feature/address/screen/address_screen.dart';
import 'package:amazon_clone/feature/admin/screens/add_product_screen.dart';
import 'package:amazon_clone/feature/auth/screens/auth_screen.dart';
import 'package:amazon_clone/feature/home/screens/category_screen.dart';
import 'package:amazon_clone/feature/home/screens/home_screen.dart';
import 'package:amazon_clone/feature/product_details/product_details_screen.dart';
import 'package:amazon_clone/feature/search/screens/search_screen.dart';
import 'package:amazon_clone/model/product.dart';
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
    case AddProductScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const AddProductScreen(),
        settings: routeSettings,
      );
    case CategoryScreen.routeName:
      return MaterialPageRoute(
        builder: (context) =>
            CategoryScreen(category: routeSettings.arguments as String),
        settings: routeSettings,
      );
    case SearchScreen.routeName:
      return MaterialPageRoute(
        builder: (context) =>
            SearchScreen(searchQuery: routeSettings.arguments as String),
        settings: routeSettings,
      );
    case ProductDetailsScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => ProductDetailsScreen(
          product: routeSettings.arguments as Product,
        ),
        settings: routeSettings,
      );
    case AddressScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const AddressScreen(),
        settings: routeSettings,
      );

    default:
      return MaterialPageRoute(
          builder: (context) => const Text("Error! Page not found"));
  }
}
