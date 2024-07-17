import 'package:amazon_clone/provider/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressBox extends StatefulWidget {
  const AddressBox({Key? key}) : super(key: key);

  @override
  State<AddressBox> createState() => _AddressBoxState();
}

class _AddressBoxState extends State<AddressBox> {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context).user;
    return Container(
      height: 42,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 114, 226, 221),
            Color.fromARGB(255, 162, 236, 233),
          ],
        ),
      ),
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        children: [
          const Icon(
            Icons.location_on_outlined,
            color: Colors.black,
            size: 20,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 5,
              ),
              child: Text(
                "Delivery to ${user.name} - ${user.address}",
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 5.0, top: 2.0),
            child: Icon(
              Icons.arrow_drop_down_outlined,
              color: Colors.black,
              size: 18,
            ),
          )
        ],
      ),
    );
  }
}
