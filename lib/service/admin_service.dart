import 'dart:convert';
import 'dart:io';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/model/product.dart';
import 'package:amazon_clone/model/user.dart';
import 'package:amazon_clone/provider/user_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AdminService {
  void addProduct(
      {required BuildContext context,
      required String name,
      required String description,
      required double price,
      required double quantity,
      required String category,
      required List<File> images}) async {
    User user = Provider.of<UserProvider>(context, listen: false).user;
    List<String> imageUrls = [];
    try {
      imageUrls = await Future.wait(images.map((image) async {
        CloudinaryPublic cloudinary = CloudinaryPublic('dqiipvdwh', 'cwxqfwpx');
        CloudinaryResponse response = await cloudinary
            .uploadFile(CloudinaryFile.fromFile(image.path, folder: name));
        return response.url;
      }).toList());
      Product product = Product(
        name: name,
        description: description,
        price: price,
        quantity: quantity,
        category: category,
        images: imageUrls,
        id: null,
        userId: null,
      );
      http.Response response = await http.post(
        Uri.parse('${GlobalVariables.baseUrl}/admin/addProduct'),
        headers: {
          'x-auth-token': user.token,
          GlobalVariables.contentType: GlobalVariables.contentTypeValue
        },
        body: product.toJson(),
      );

      handleHttpResponse(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBar(context, "Product added successfully");
          Navigator.pop(context);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Product>> fetchAllProducts(BuildContext context) async {
    User user = Provider.of<UserProvider>(context, listen: false).user;
    List<Product> products = [];
    try {
      http.Response response = await http.get(
        Uri.parse('${GlobalVariables.baseUrl}/admin/getProducts'),
        headers: {
          GlobalVariables.contentType: GlobalVariables.contentTypeValue,
          'x-auth-token': user.token
        },
      );
      for (int i = 0; i < jsonDecode(response.body).length; i++) {
        Product product =
            Product.fromJson(jsonEncode(jsonDecode(response.body)[i]));
        products.add(product);
      }
      handleHttpResponse(
          response: response,
          context: context,
          onSuccess: () {});
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return products;
  }

  void deleteProductById(BuildContext context, String id, VoidCallback onSuccess) async {
    User user = Provider.of<UserProvider>(context, listen: false).user;
    try {
      http.Response response = await http.delete(
        Uri.parse('${GlobalVariables.baseUrl}/admin/$id'),
        headers: {
          GlobalVariables.contentType: GlobalVariables.contentTypeValue,
          'x-auth-token': user.token
        },
      );
      handleHttpResponse(
        response: response,
        context: context,
        onSuccess: () {
          onSuccess();
          showSnackBar(context, response.body);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
