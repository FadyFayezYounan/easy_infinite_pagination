import 'package:flutter/material.dart';

class DefaultListTile extends StatelessWidget {
  const DefaultListTile({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Item $index'),
    );
  }
}
