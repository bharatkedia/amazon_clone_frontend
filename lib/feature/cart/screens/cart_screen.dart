import 'package:amazon_clone/feature/cart/widget/total_amount_screen.dart';
import 'package:amazon_clone/model/cart.dart';
import 'package:amazon_clone/provider/user_provider.dart';
import 'package:amazon_clone/service/cart_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/widgets/loader.dart';
import '../../../common/widgets/product_item.dart';
import '../../../constants/global_variables.dart';
import '../../../model/product.dart';
import '../../../model/user.dart';
import '../../home/widgets/address_box.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  static const String routeName = "/cartScreen";

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double height = 32;
  double width = 35;

  final CartService cartService = CartService();

  void updateItemCount(String productId, int quantity) async{
    User user = await cartService.addCardItem(context, productId, quantity);
    Provider.of<UserProvider>(context, listen: false)
        .setUser(user);
    print(user.cart.toString());
  }

  @override
  Widget build(BuildContext context) {
    List<Cart>? carts = context.watch<UserProvider>().user.cart;
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
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 10),
                  height: 42,
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      onFieldSubmitted: (String? searchQuery) {},
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.only(
                              left: 6,
                            ),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 25,
                            ),
                          ),
                        ),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black38,
                            width: 1,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(
                          top: 10,
                        ),
                        hintText: "Search Amazon.in",
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 5,
                ),
                height: 42,
                color: Colors.transparent,
                child: const Icon(
                  Icons.mic,
                  color: Colors.black,
                  size: 25,
                ),
              )
            ],
          ),
        ),
      ),
      body: carts == null
          ? const Loader()
          : Column(
              children: [
                const AddressBox(),
                const SizedBox(
                  height: 10,
                ),
                TotalAmountScreen(),
                const Divider(
                  color: Colors.grey,
                  thickness: 0.8,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: carts.length,
                    itemBuilder: (context, index) {
                      Product product = carts.elementAt(index).product;
                      int quantity = carts.elementAt(index).quantity;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ProductItem(product: product),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                color: Colors.black12,
                              ),
                              width: 120,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    height: height,
                                    width: width,
                                    alignment: Alignment.center,
                                    child: GestureDetector(
                                      child: const Icon(Icons.remove),
                                      onTap: () {
                                        if(quantity > 0) {
                                          updateItemCount(product.id!, -1);
                                          --quantity;
                                        }
                                      },
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    height: height,
                                    width: width,
                                    child: Text(quantity.toString(),),
                                    alignment: Alignment.center,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    height: height,
                                    width: width,
                                    child: GestureDetector(
                                      child: const Icon(Icons.add),
                                      onTap: () {
                                        updateItemCount(product.id!, 1);
                                        ++quantity;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
