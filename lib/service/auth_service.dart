import 'dart:convert';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:http/http.dart' as http;
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
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
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
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
      );

      handleHttpResponse(
        response: response,
        context: context,
        onSuccess: () async {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          preferences.setString('auth-token', jsonDecode(response.body)['token']);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
