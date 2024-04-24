import 'package:flutter/material.dart';

class MasonryItem extends StatelessWidget {
  const MasonryItem({
    super.key,
    required this.index,
  });
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (index % 5 + 1) * 100,
      color: const Color(0xFF34568B),
      padding: const EdgeInsets.all(32),
      child: Center(
        child: CircleAvatar(
          minRadius: 24,
          maxRadius: 24,
          backgroundColor: Colors.white,
          child: Text(
            "$index",
          ),
        ),
      ),
    );
  }
}
