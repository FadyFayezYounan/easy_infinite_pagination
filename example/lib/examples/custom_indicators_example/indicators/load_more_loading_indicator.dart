import 'package:flutter/material.dart';

class LoadMoreLoadingIndicator extends StatelessWidget {
  const LoadMoreLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      leading: CircularProgressIndicator.adaptive(),
      title: Text("Loading..."),
    );
  }
}
