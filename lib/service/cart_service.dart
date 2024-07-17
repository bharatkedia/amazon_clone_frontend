import 'dart:convert';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/provider/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../model/user.dart';

class CartService {
  Future<User> addCardItem(
      BuildContext context, String productId, int quantity) async {
    User user = Provider.of<UserProvider>(context, listen: false).user;
    try {
      http.Response response = await http.put(
        Uri.parse('${GlobalVariables.baseUrl}/api/user/cartItems'),
        headers: {
          GlobalVariables.contentType: GlobalVariables.contentTypeValue,
          'x-auth-token': user.token,

        },
        body : jsonEncode({
          'id': productId,
          'quantity': quantity
        }),
      );
      handleHttpResponse(
          response: response,
          context: context,
          onSuccess: () {
            user = User.fromJson(response.body);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return user;
  }
}
