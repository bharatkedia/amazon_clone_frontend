import 'dart:convert';

class Rating {
  final String userId;
  final double rating;

  Rating({required this.userId, required this.rating});

  factory Rating.fromMap(Map<String, dynamic> map) {
    return Rating(
      userId: map['userId'],
      rating: map['rating'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'userId': userId, 'rating': rating};
  }

  String toJson() => jsonEncode(toMap());

  factory Rating.fromJson(String json) => Rating.fromMap(jsonDecode(json));
}
