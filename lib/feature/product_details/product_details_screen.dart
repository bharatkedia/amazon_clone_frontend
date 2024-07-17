import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/rating.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/model/product.dart';
import 'package:amazon_clone/provider/user_provider.dart';
import 'package:amazon_clone/service/cart_service.dart';
import 'package:amazon_clone/service/product_service.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../../constants/global_variables.dart';
import '../../model/user.dart';
import '../search/screens/search_screen.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const String routeName = "/productDetailsScreen";
  final Product product;

  const ProductDetailsScreen({Key? key, required this.product})
      : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final double dividerHeight = 5.0;
  double avgRating = 0;
  double userRating = 0;

  final ProductService productService = ProductService();
  final CartService cardService = CartService();


  void navigateToSearchScreen(String? searchQuery) {
    Navigator.pushNamed(context, SearchScreen.routeName,
        arguments: searchQuery);
  }

  void updateRating(double rating) {
    productService.addRating(context, widget.product.id!, rating);
  }

  void calculateAvgRating(){
    double sum = 0;
    Product p = widget.product;
    if(p.ratings != null) {
      for (var e in widget.product.ratings!) {
        sum += e.rating;
      }
      if(sum != 0 ) {
        avgRating = sum / p.ratings!.length;
      }
    }
  }

  void getUserRating(){
    User u = Provider.of<UserProvider>(context, listen: false).user;
    Product p = widget.product;
    if(p.ratings != null){
      userRating = p.ratings!.where((element) => element.userId == u.id).first.rating;
    }
  }

  @override
  void initState() {
    calculateAvgRating();
    getUserRating();
    super.initState();
  }

  void addToCart() async{
    User user = await cardService.addCardItem(context, widget.product.id!, 1);
    showSnackBar(context, "Added to cart");
    Provider.of<UserProvider>(context, listen: false)
        .setUser(user);
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
                      onFieldSubmitted: navigateToSearchScreen,
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.product.id!,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  Rating(rating: avgRating)
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.product.name,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            CarouselSlider(
              items: widget.product.images
                  .map((e) => Builder(builder: (context) {
                        return Image.network(
                          e,
                          fit: BoxFit.contain,
                          height: 200,
                        );
                      }))
                  .toList(),
              options: CarouselOptions(height: 300, viewportFraction: 1),
            ),
            Container(
              height: dividerHeight,
              color: Colors.black12,
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                text: TextSpan(
                  text: "Deal Price: ",
                  children: [
                    TextSpan(
                        text: "\$${widget.product.price}",
                        style: const TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ))
                  ],
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.product.description,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            Container(
              height: dividerHeight,
              color: Colors.black12,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 20,
              ),
              child: CustomButton(
                text: "Buy Now",
                onTap: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              child: CustomButton(
                text: "Add To Cart",
                onTap: addToCart,
                btnColor: Colors.yellow,
              ),
            ),
            Container(
              height: dividerHeight,
              color: Colors.black12,
            ),
            const Padding(
              padding: EdgeInsets.all(5.0),
              child: Text(
                "Rate the Product",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: RatingBar.builder(
                allowHalfRating: true,
                initialRating: userRating,
                minRating: 1,
                itemCount: 5,
                direction: Axis.horizontal,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.yellow,
                ),
                onRatingUpdate: updateRating,
              ),
            )
          ],
        ),
      ),
    );
  }
}
