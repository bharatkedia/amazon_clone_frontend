import 'package:amazon_clone/constants/color_util.dart';
import 'package:amazon_clone/feature/auth/screens/auth_screen.dart';
import 'package:amazon_clone/router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amazon Clone',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: ColorUtil.secondaryColor,
        )
      ),
      onGenerateRoute: generateRoute,
      initialRoute: AuthScreen.routeName,
      home: const Text('Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}