import 'dart:ffi';

import 'package:amazon_clone/common/widgets/rating.dart';
import 'package:amazon_clone/feature/product_details/product_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/product.dart';

class ProductItem extends StatefulWidget {
  final Product product;

  const ProductItem({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, ProductDetailsScreen.routeName, arguments: widget.product),
      child: Row(
        children: [
          Image.network(
            widget.product.images[0],
            height: 135,
            width: 135,
            fit: BoxFit.fitHeight,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 235,
                  child: Text(
                    widget.product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const Rating(rating: 4),
                Text(
                  '\$${widget.product.price}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 5.0),
                  child: Text('Eligible for Free Shipping'),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 5.0),
                  child: Text(
                    'In Stock',
                    style: TextStyle(color: Colors.teal),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
