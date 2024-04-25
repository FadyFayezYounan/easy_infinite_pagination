import 'package:flutter/material.dart';

class PageViewItem extends StatelessWidget {
  const PageViewItem({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Card(
        child: Center(
          child: CircleAvatar(
            radius: 48.0,
            child: Text("Page ${index + 1}"),
          ),
        ),
      ),
    );
  }
}
