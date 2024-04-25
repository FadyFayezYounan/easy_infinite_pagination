import 'package:flutter/material.dart';

class LoadMoreErrorIndicator extends StatelessWidget {
  const LoadMoreErrorIndicator({
    super.key,
    required this.onRetry,
  });
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.error, color: Colors.red, size: 32.0),
      title: const Text("Something went wrong!"),
      trailing: TextButton(onPressed: onRetry, child: const Text("Retry")),
    );
  }
}
