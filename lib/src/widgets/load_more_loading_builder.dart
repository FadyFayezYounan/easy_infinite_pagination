import 'package:flutter/material.dart';

import 'bottom_loader_padding.dart';

/// A function that builds a widget that displays a circular progress indicator
/// in a centered and padded container, used to indicate that more items are being loaded.
///
/// The function takes a [BuildContext] as a parameter and returns a [LoadMoreLoadingBuilder] widget.
Widget loadMoreLoadingBuilder(BuildContext context) {
  return const LoadMoreLoadingBuilder();
}

class LoadMoreLoadingBuilder extends StatelessWidget {
  /// A stateless widget that displays a circular progress indicator
  /// in a centered and padded container.
  ///
  /// The [BottomLoaderPadding] widget is used to add vertical padding to the bottom of the widget.
  const LoadMoreLoadingBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return const BottomLoaderPadding(
      child: CircularProgressIndicator.adaptive(),
    );
  }
}
