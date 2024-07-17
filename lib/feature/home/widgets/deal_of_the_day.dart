import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/model/product.dart';
import 'package:amazon_clone/service/product_service.dart';
import 'package:flutter/material.dart';

class DealOfTheDay extends StatefulWidget {
  const DealOfTheDay({Key? key}) : super(key: key);

  @override
  State<DealOfTheDay> createState() => _DealOfTheDayState();
}

class _DealOfTheDayState extends State<DealOfTheDay> {
  ProductService productService = ProductService();

  Product? product;

  @override
  void initState() {
    getDealOfTheDay();
    super.initState();
  }

  void getDealOfTheDay() async {
    product = await productService.getDealOfDay(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return product == null
        ? const Loader()
        : product!.name.isEmpty
            ? const SizedBox()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: const Text(
                      "Deal of the Day",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: Image.network(
                      product!.images[0],
                      fit: BoxFit.fitHeight,
                      height: 235,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      left: 15,
                      top: 5,
                    ),
                    alignment: Alignment.topLeft,
                    child: Text(
                      '\$${product!.price}',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      left: 15,
                      top: 5,
                      right: 40,
                    ),
                    alignment: Alignment.topLeft,
                    child: Text(
                      product!.description,
                      style: const TextStyle(fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: product!.images
                          .map((e) => Image.network(
                                e,
                                fit: BoxFit.fitWidth,
                                width: 100,
                                height: 100,
                              ))
                          .toList(),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 15)
                        .copyWith(left: 15),
                    alignment: Alignment.topLeft,
                    child: const Text(
                      'See all deals',
                      style: TextStyle(color: Colors.cyan),
                    ),
                  )
                ],
              );
  }
}
