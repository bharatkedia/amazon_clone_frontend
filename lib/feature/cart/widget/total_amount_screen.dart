import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/feature/address/screen/address_screen.dart';
import 'package:amazon_clone/model/cart.dart';
import 'package:amazon_clone/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class TotalAmountScreen extends StatefulWidget {
  const TotalAmountScreen({Key? key}) : super(key: key);

  @override
  State<TotalAmountScreen> createState() => _TotalAmountScreenState();
}

class _TotalAmountScreenState extends State<TotalAmountScreen> {
  @override
  Widget build(BuildContext context) {
    List<Cart>? cart = context.watch<UserProvider>().user.cart;
    int totalItemsCount = cart == null ? 0 : cart.length;
    double totalItemAmount = 0;
    if (cart != null) {
      for(Cart c in cart){
        totalItemAmount += (c.quantity * c.product.price);
      }
    }
    return Container(
      margin: const EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                'Subtotal ',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                '\$$totalItemAmount',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          CustomButton(
            text: "Proceed to buy ($totalItemsCount item)",
            onTap: () {
              if(cart != null || cart!.isNotEmpty){
                  Navigator.pushNamed(context, AddressScreen.routeName);
              }else{
                showSnackBar(context, "Please add item in the cart");
              }
            },
            btnColor: Colors.yellow,
          ),
        ],
      ),
    );
  }
}
