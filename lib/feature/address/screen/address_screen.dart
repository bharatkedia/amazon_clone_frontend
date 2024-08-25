import 'package:amazon_clone/common/widgets/custom_text_field.dart';
import 'package:amazon_clone/provider/user_provider.dart';
import 'package:flutter/material.dart';
// import 'package:pay/pay.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../../../constants/global_variables.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({Key? key}) : super(key: key);

  static const String routeName = "/addressScreen";

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController flatHouseController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();
  final TextEditingController townCityController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    flatHouseController.dispose();
    areaController.dispose();
    pinCodeController.dispose();
    townCityController.dispose();
  }

  void onGooglePayResult(res) {}

  void onApplePayResult(res) {}

  // List<PaymentItem> paymentItems = [];

  String androidConfigJson = "";

  @override
  void initState() {
    super.initState();
    loadJson();
  }

  Future<void> loadJson() async {
    String jsonString = await rootBundle.loadString('assets/gpay.json');
    setState(() {
      androidConfigJson = jsonString;
    });
  }

  @override
  Widget build(BuildContext context) {
    String userAddress = context.watch<UserProvider>().user.address;
    // const _paymentItems = [
    //   PaymentItem(
    //     label: 'Total',
    //     amount: '99.99',
    //     status: PaymentItemStatus.final_price,
    //   )
    // ];
    return androidConfigJson.isEmpty
        ? const Scaffold(
            body: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: AppBar(
                foregroundColor: Colors.black,
                flexibleSpace: Container(
                  decoration: const BoxDecoration(
                    gradient: GlobalVariables.appBarGradient,
                  ),
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    if (userAddress.isNotEmpty)
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                              ),
                            ),
                            child: Text(
                              userAddress,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "OR",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    Form(
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: flatHouseController,
                            hint: "Flat, House no. Building",
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                            controller: areaController,
                            hint: "Area, Street",
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                            controller: pinCodeController,
                            hint: "Pincode",
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                            controller: townCityController,
                            hint: "Town/City",
                          ),
                        ],
                      ),
                    ),
                    // GooglePayButton(
                    //   onPaymentResult: onGooglePayResult,
                    //   paymentItems: paymentItems,
                    //   paymentConfigurationAsset: 'gpay.json',
                    //   width: double.infinity,
                    // )
                    // GooglePayButton(
                    //   paymentConfiguration:
                    //       PaymentConfiguration.fromJsonString(androidConfigJson),
                    //   paymentItems: _paymentItems,
                    //   type: GooglePayButtonType.buy,
                    //   margin: const EdgeInsets.only(top: 15.0),
                    //   onPaymentResult: onGooglePayResult,
                    //   loadingIndicator: const Center(
                    //     child: CircularProgressIndicator(),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          );
  }
}
