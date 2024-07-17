import 'package:amazon_clone/common/widgets/no_prodcuts_widget.dart';
import 'package:amazon_clone/feature/product_details/product_details_screen.dart';
import 'package:amazon_clone/service/product_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/global_variables.dart';
import '../../../model/product.dart';

class CategoryScreen extends StatefulWidget {
  final String category;

  const CategoryScreen({Key? key, required this.category}) : super(key: key);

  static const String routeName = "/categoryScreen";

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  ProductService productService = ProductService();
  List<Product>? products;

  void getProductByCategory() async {
    products =
        await productService.getProductsByCategory(context, widget.category);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getProductByCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          foregroundColor: Colors.black,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Text(widget.category),
        ),
      ),
      body: products == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
                vertical: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      "Keep shopping for ${widget.category}",
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  products!.isEmpty
                      ? const NoProductsWidget()
                      : SizedBox(
                          height: 170,
                          child: GridView.builder(
                            itemCount: products!.length,
                            padding: const EdgeInsets.only(
                              left: 15,
                            ),
                            scrollDirection: Axis.horizontal,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              mainAxisSpacing: 10,
                              childAspectRatio: 1.4,
                            ),
                            itemBuilder: (context, index) {
                              Product product = products!.elementAt(index);
                              return GestureDetector(
                                onTap: () => Navigator.pushNamed(
                                  context,
                                  ProductDetailsScreen.routeName,
                                  arguments: product,
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 130,
                                      child: Image.network(product.images[0]),
                                    ),
                                    Text(
                                      product.name,
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                ],
              ),
            ),
    );
  }
}
