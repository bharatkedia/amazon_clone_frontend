import 'package:flutter/cupertino.dart';

class NoProductsWidget extends StatelessWidget {
  const NoProductsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Center(
        child: Text("Currently, Products are not available", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),),
      ),
    );
  }
}
