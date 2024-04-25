import 'package:flutter/material.dart';

class FirstPageLoadingIndicator extends StatelessWidget {
  const FirstPageLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator.adaptive(),
        SizedBox(
          height: 16.0,
        ),
        Text("Loading..."),
      ],
    );
  }
}
