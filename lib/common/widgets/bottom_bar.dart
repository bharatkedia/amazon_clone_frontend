import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/feature/account/screens/account_screen.dart';
import 'package:amazon_clone/feature/cart/screens/cart_screen.dart';
import 'package:badges/badges.dart' as badge;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../feature/home/screens/home_screen.dart';
import '../../provider/user_provider.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);
  static const String routeName = '/bottomBar';

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

  final List<Widget> _widgetList = [
    const HomeScreen(),
    const AccountScreen(),
    const CartScreen(),
  ];

  void updateItem(int page) {
    setState(() {
      this.page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    int cartItemCount = context.watch<UserProvider>().user.cart?.length?? 0;
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        currentIndex: page,
        iconSize: 28,
        onTap: updateItem,
        items: [
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: bottomBarBorderWidth,
                    color: page == 0
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                  ),
                ),
              ),
              child: const Icon(Icons.home_outlined),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: bottomBarBorderWidth,
                    color: page == 1
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                  ),
                ),
              ),
              child: const Icon(Icons.person_outline_outlined),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: bottomBarBorderWidth,
                    color: page == 2
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                  ),
                ),
              ),
              child: badge.Badge(
                badgeContent: Text(cartItemCount.toString()),
                child: const Icon(Icons.shopping_cart_outlined),
                badgeColor: Colors.white,
                elevation: 0,
              ),
            ),
            label: '',
          ),
        ],
      ),
      body: _widgetList.elementAt(page),
    );
  }
}
