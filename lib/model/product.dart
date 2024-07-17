import 'dart:convert';

import 'package:amazon_clone/model/rating.dart';

class Product {
  final String name;
  final String description;
  final double price;
  final double quantity;
  final String category;
  final List<String> images;
  final String? id;
  final String? userId;
  final List<Rating>? ratings;

  Product(
      {required this.name,
      required this.description,
      required this.price,
      required this.quantity,
      required this.category,
      required this.images,
      required this.id,
      required this.userId,
      this.ratings});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'quantity': quantity,
      'category': category,
      'images': images,
      'userId': userId,
      'rating': ratings
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
        name: map['name'],
        description: map['description'],
        price: map['price'].toDouble(),
        quantity: map['quantity'].toDouble(),
        category: map['category'],
        images: List<String>.from(map['images']),
        id: map['_id'],
        userId: map['userId'],
        ratings: map['rating'] != null
            ? List<Rating>.from(map['rating']?.map((x) => Rating.fromMap(x)))
            : null);
  }

  String toJson() => jsonEncode(toMap());

  factory Product.fromJson(String json) => Product.fromMap(jsonDecode(json));
}
