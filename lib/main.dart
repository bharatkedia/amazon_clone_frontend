import 'package:amazon_clone/common/widgets/bottom_bar.dart';
import 'package:amazon_clone/feature/admin/screens/admin_screen.dart';
import 'package:amazon_clone/feature/auth/screens/auth_screen.dart';
import 'package:amazon_clone/provider/user_provider.dart';
import 'package:amazon_clone/service/auth_service.dart';
import 'package:provider/provider.dart';

import 'constants/global_variables.dart';
import 'package:amazon_clone/router/router.dart';
import 'package:flutter/material.dart';

import 'model/user.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => UserProvider(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _authService.getUserData(context: context);
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context).user;
    return MaterialApp(
      title: 'Amazon Clone',
      theme: ThemeData(
          colorScheme: const ColorScheme.light(
        primary: GlobalVariables.secondaryColor,
      )),
      onGenerateRoute: generateRoute,
      home: user.token.isNotEmpty
          ? user.type == 'admin'
              ? const AdminScreen()
              : const BottomBar()
          : const AuthScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
