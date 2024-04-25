import 'package:flutter/material.dart';

class FirstPageNoItemsFoundedIndicator extends StatelessWidget {
  const FirstPageNoItemsFoundedIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.inventory_rounded,
            color: Colors.grey,
            size: 64.0,
          ),
          SizedBox(height: 16.0),
          Text("No items founded!"),
        ],
      ),
    );
  }
}
