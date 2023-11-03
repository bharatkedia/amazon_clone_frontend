import 'dart:convert';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/feature/home/screens/home_screen.dart';
import 'package:amazon_clone/provider/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/user.dart';

class AuthService {
  void signUp({
    required BuildContext context,
    required String email,
    required String name,
    required String password,
  }) async {
    try {
      User user = User(
        id: '',
        email: email,
        password: password,
        name: name,
        type: '',
        address: '',
        token: '',
      );

      http.Response response = await http.post(
        Uri.parse('${GlobalVariables.baseUrl}/auth/signUp'),
        body: user.toJson(),
        headers: {GlobalVariables.contentType: GlobalVariables.contentTypeValue},
      );
      handleHttpResponse(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBar(context,
              'Account created successfully, Please login with same credentials');
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void signIn({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      User user = User(
        id: '',
        email: email,
        password: password,
        type: '',
        name: '',
        address: '',
        token: '',
      );
      http.Response response = await http.post(
        Uri.parse('${GlobalVariables.baseUrl}/auth/signIn'),
        body: user.toJson(),
        headers: {GlobalVariables.contentType: GlobalVariables.contentTypeValue},
      );

      handleHttpResponse(
        response: response,
        context: context,
        onSuccess: () async {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          Provider.of<UserProvider>(context, listen: false)
              .setUser(response.body);
          preferences.setString(
              'auth-token', jsonDecode(response.body)['token']);
          Navigator.pushNamedAndRemoveUntil(
              context, HomeScreen.routeName, (route) => false);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void getUserData({
    required BuildContext context,
  }) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString("auth-token");

      //In Tutorial, They are calling one more API "/isTokenValid".
      //Correction: avoiding replication of functionality

      if (token == null) return;

      http.Response userResponse = await http.get(
        Uri.parse('${GlobalVariables.baseUrl}/'),
        headers: <String, String>{
          'x-auth-token': token,
          GlobalVariables.contentType: GlobalVariables.contentTypeValue
        },
      );
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.setUser(userResponse.body);
    } catch (e) {
      // TODO: If execution comes inside the catch block, app will get crash. Handle this
      showSnackBar(context, e.toString());
    }
  }
}
