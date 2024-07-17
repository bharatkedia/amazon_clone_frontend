import 'dart:io';

import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/custom_text_field.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/service/admin_service.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../../constants/global_variables.dart';
import '../../../model/product.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  static const String routeName = "/addProduct";

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  AdminService adminService = AdminService();
  final _adminFormKey = GlobalKey<FormState>();
  TextEditingController productTextController = TextEditingController();
  TextEditingController descriptionTextController = TextEditingController();
  TextEditingController priceTextController = TextEditingController();
  TextEditingController quantityTextController = TextEditingController();
  TextEditingController categoryTextController = TextEditingController();

  List categories = ["Mobiles", "Essentials", "Appliances", "Books", "Fashion"];
  String category = "Mobiles";
  List<File> images = [];

  void selectImages() async {
    var files = await pickImage();
    setState(() {
      images = files;
    });
  }

  void addProduct() {
    if(_adminFormKey.currentState!.validate()) {
      adminService.addProduct(
        context: context,
        name: productTextController.text,
        description: descriptionTextController.text,
        price: double.parse(priceTextController.text),
        quantity: double.parse(quantityTextController.text),
        category: category,
        images: images,
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    productTextController.dispose();
    descriptionTextController.dispose();
    priceTextController.dispose();
    quantityTextController.dispose();
    categoryTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          foregroundColor: Colors.black,
          elevation: 0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: const Text(
            "Add Product",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Form(
            key: _adminFormKey,
            child: Column(
              children: [
                const SizedBox(height: 20),
                images.isNotEmpty
                    ? CarouselSlider(
                        items: images
                            .map((e) => Image.file(
                                  e,
                                  fit: BoxFit.cover,
                                  height: 190,
                                ))
                            .toList(),
                        options: CarouselOptions(
                          viewportFraction: 1,
                          height: 190,
                        ),
                      )
                    : GestureDetector(
                        onTap: selectImages,
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(10),
                          dashPattern: const [10, 4],
                          strokeCap: StrokeCap.round,
                          child: Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.folder_open),
                                const SizedBox(height: 20),
                                Text(
                                  "Select Product Image",
                                  style: TextStyle(color: Colors.grey.shade800),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                const SizedBox(height: 20),
                CustomTextField(
                  hint: "Product Name",
                  controller: productTextController,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  hint: "Description",
                  controller: descriptionTextController,
                  maxLines: 7,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  hint: "Price",
                  controller: priceTextController,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  hint: "Quantity",
                  controller: quantityTextController,
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButton(
                      value: category,
                      icon: const Icon(Icons.keyboard_arrow_down_outlined),
                      items: categories.map((item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                      onChanged: (val) {
                        setState(() {
                          category = val.toString();
                        });
                      }),
                ),
                const SizedBox(height: 10),
                CustomButton(
                  text: "Sell",
                  onTap: addProduct,
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
