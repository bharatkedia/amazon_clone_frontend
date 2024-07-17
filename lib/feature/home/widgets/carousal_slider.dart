import 'package:amazon_clone/constants/global_variables.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';

class CarousalSlider extends StatelessWidget {
  const CarousalSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: GlobalVariables.carouselImages
          .map((e) => Image.network(
                e,
                fit: BoxFit.cover,
                height: 190
              ))
          .toList(),
      options: CarouselOptions(
        viewportFraction: 1,
        height: 190,
      ),
    );
  }
}
