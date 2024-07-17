import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Rating extends StatelessWidget {
  final double rating;

  const Rating({Key? key, required this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      itemCount: 5,
      direction: Axis.horizontal,
      rating: rating,
      itemSize: 15,
      itemPadding: const EdgeInsets.symmetric(vertical: 5),
      itemBuilder: (context, index) => const Icon(
        Icons.star,
        color: Colors.yellow,
      ),
    );
  }
}
