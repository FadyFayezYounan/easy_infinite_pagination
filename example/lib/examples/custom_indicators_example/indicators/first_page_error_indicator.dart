import 'package:flutter/material.dart';

class FirstPageErrorIndicator extends StatelessWidget {
  const FirstPageErrorIndicator({super.key, required this.onRetry});
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.error,
            color: Colors.red,
            size: 64.0,
          ),
          const SizedBox(height: 16.0),
          const Text("Something went wrong!"),
          const SizedBox(height: 16.0),
          TextButton(onPressed: onRetry, child: const Text("Retry")),
        ],
      ),
    );
  }
}
