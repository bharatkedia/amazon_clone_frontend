import 'constants/global_variables.dart';
import 'package:amazon_clone/feature/auth/screens/auth_screen.dart';
import 'package:amazon_clone/router/router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amazon Clone',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: GlobalVariables.secondaryColor,
        )
      ),
      onGenerateRoute: generateRoute,
      initialRoute: AuthScreen.routeName,
      home: const Text('Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}