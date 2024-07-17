import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/common/widgets/single_product.dart';
import 'package:amazon_clone/feature/admin/screens/add_product_screen.dart';
import 'package:flutter/material.dart';

import '../../../model/product.dart';
import '../../../service/admin_service.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  AdminService adminService = AdminService();
  List<Product>? products;

  @override
  void initState() {
    super.initState();
    fetchProduct();
  }

  void fetchProduct() async {
    products = await adminService.fetchAllProducts(context);
    setState(() {});
  }

  void deleteProduct(String productId) {
    adminService.deleteProductById(context, productId, () {
      products!.removeWhere((element) => element.id == productId);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: products == null
          ? const Loader()
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: GridView.builder(
                  itemCount: products!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    Product product = products![index];
                    return Column(
                      children: [
                        SizedBox(
                            height: 140,
                            child: SingleProduct(image: product.images[0])),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                product.name,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete_outlined),
                              onPressed: () {
                                deleteProduct(product.id!);
                              },
                            ),
                          ],
                        )
                      ],
                    );
                  }),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddProductScreen.routeName);
        },
        child: const Icon(Icons.add),
        tooltip: "Add Product",
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
