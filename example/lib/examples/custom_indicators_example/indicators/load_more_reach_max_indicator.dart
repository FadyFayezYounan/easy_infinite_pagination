import 'package:flutter/material.dart';

class LoadMoreNoMoreItemsIndicator extends StatelessWidget {
  const LoadMoreNoMoreItemsIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      leading: Icon(Icons.inventory_2_outlined, color: Colors.grey, size: 32.0),
      title: Text("No more data!"),
    );
  }
}
