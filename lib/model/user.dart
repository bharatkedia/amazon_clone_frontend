import 'dart:convert';

import 'package:amazon_clone/model/cart.dart';

class User {
  final String id;
  final String email;
  final String password;
  final String type;
  final String name;
  final String address;
  final String token;
  final List<Cart>? cart;

  User({
    required this.id,
    required this.email,
    required this.password,
    required this.type,
    required this.name,
    required this.address,
    required this.token,
    this.cart
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'type': type,
      'name': name,
      'address': address,
      'token': token,
      'cart': cart
    };
  }

  factory User.fromMap(Map<String, dynamic> map){
    return User(
      id: map['_id'],
      email: map['email'],
      password: map['password'],
      type: map['type'],
      name: map['name'],
      address: map['address'],
      token: map['token'],
      cart: map['cart'] != null ? List<Cart>.from(map['cart'].map((c) => Cart.fromMap(c))) : null
    );
  }

  String toJson() => jsonEncode(toMap());

  factory User.fromJson(String source) => User.fromMap(jsonDecode(source));


}
