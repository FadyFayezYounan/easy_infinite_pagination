import 'package:flutter/material.dart';

class CustomErrorScreen extends StatelessWidget {
  const CustomErrorScreen({
    super.key,
    required this.errorMessage,
  });
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.error,
              color: Colors.red,
              size: 64.0,
            ),
            const SizedBox(height: 16.0),
            Text(errorMessage),
          ],
        ),
      ),
    );
  }
}
