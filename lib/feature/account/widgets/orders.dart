import 'package:amazon_clone/common/widgets/single_product.dart';
import 'package:flutter/material.dart';


class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<String> images = [
    'https://images.unsplash.com/photo-1696794754344-5a44bf0663a2?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxMHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1696794754344-5a44bf0663a2?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxMHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1696794754344-5a44bf0663a2?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxMHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1696794754344-5a44bf0663a2?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxMHx8fGVufDB8fHx8fA%3D%3D'
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.only(
                  left: 15,
                ),
                child: const Text(
                  'Your Orders',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                  right: 15,
                ),
                child: const Text(
                  'See all',
                  style: TextStyle(
                      //GlobalVariables.selectedNavbarColor not working!!!
                      color: Colors.cyan),
                ),
              )
            ],
          ),
          Container(
            //TODO: Doubt : *'height:170'* is it correct ? we should not hardcode such values.
            height: 170,
            padding: const EdgeInsets.only(
              left: 10,
              top: 20,
              right: 0,
            ),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: images.length,
              itemBuilder: ((context, index) {
                return SingleProduct(
                  image: images.elementAt(index),
                );
              }),
            ),
          )
        ],
      ),
    );
  }
}
