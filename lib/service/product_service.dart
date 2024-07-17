import 'dart:convert';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/model/product.dart';
import 'package:amazon_clone/provider/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../model/user.dart';

class ProductService {
  Future<List<Product>> getProductsByCategory(
      BuildContext context, String category) async {
    List<Product> products = [];
    try {
      User user = Provider.of<UserProvider>(context, listen: false).user;
      http.Response response = await http.get(
          Uri.parse(
              '${GlobalVariables.baseUrl}/api/product?category=$category'),
          headers: {
            GlobalVariables.contentType: GlobalVariables.contentTypeValue,
            'x-auth-token': user.token
          });
      for (int i = 0; i < jsonDecode(response.body).length; i++) {
        Product product =
            Product.fromJson(jsonEncode(jsonDecode(response.body)[i]));
        products.add(product);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return products;
  }

  Future<List<Product>> getSearchedProduct(
      BuildContext context, String searchQuery) async {
    List<Product> products = [];
    User user = Provider.of<UserProvider>(context, listen: false).user;
    try {
      http.Response response = await http.get(
          Uri.parse(
              '${GlobalVariables.baseUrl}/api/product/search/$searchQuery'),
          headers: {
            GlobalVariables.contentType: GlobalVariables.contentTypeValue,
            'x-auth-token': user.token
          });
      for (int i = 0; i < jsonDecode(response.body).length; i++) {
        Product product =
            Product.fromJson(jsonEncode(jsonDecode(response.body)[i]));
        products.add(product);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return products;
  }

  void addRating(BuildContext context, String productId, double rating) async {
    try {
      User user = Provider.of<UserProvider>(context, listen: false).user;
      Response response = await http.put(
        Uri.parse("${GlobalVariables.baseUrl}/api/product/rating"),
        headers: {
          GlobalVariables.contentType: GlobalVariables.contentTypeValue,
          'x-auth-token': user.token
        },
        body: jsonEncode({'id': productId, 'rating': rating}),
      );

      handleHttpResponse(
        response: response,
        context: context,
        onSuccess: () {},
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<Product> getDealOfDay(BuildContext context) async {
    User user = Provider.of<UserProvider>(context, listen: false).user;
    Product product = Product(
      name: '',
      description: '',
      price: 0,
      quantity: 0,
      category: '',
      images: [],
      id: '',
      userId: '',
    );
    try {
      http.Response response = await http.get(
        Uri.parse('${GlobalVariables.baseUrl}/api/product/dealOfDay'),
        headers: {
          GlobalVariables.contentType: GlobalVariables.contentTypeValue,
          'x-auth-token': user.token
        },
      );
      handleHttpResponse(
        response: response,
        context: context,
        onSuccess: () {
          product = Product.fromJson(response.body);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return product;
  }
}
