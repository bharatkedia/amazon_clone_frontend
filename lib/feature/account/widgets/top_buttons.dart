import 'package:amazon_clone/feature/account/widgets/account_button.dart';
import 'package:flutter/material.dart';

class TopButtons extends StatelessWidget {
  const TopButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              AccountButton(
                text: 'Your Order',
                onTap: () {},
              ),
              AccountButton(
                text: 'Turn Seller',
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              AccountButton(
                text: 'Log Out',
                onTap: () {},
              ),
              AccountButton(
                text: 'Your Wish List',
                onTap: () {},
              ),
            ],
          )
        ],
      ),
    );
  }
}
