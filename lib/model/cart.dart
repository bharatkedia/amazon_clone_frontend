import 'dart:convert';

import 'package:amazon_clone/model/product.dart';

class Cart {
  final Product product;
  final int quantity;

  Cart({required this.product, required this.quantity});

  Map<String, dynamic> toMap() {
    return {'product': product.toMap(), 'quantity': quantity};
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      product: Product.fromMap(map['product']),
      quantity: map['quantity'],
    );
  }

  String toJson() => jsonEncode(toMap());

  factory Cart.fromJson(String json) => Cart.fromMap(jsonDecode(json));
}
