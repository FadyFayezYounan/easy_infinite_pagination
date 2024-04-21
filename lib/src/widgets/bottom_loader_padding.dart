import 'package:flutter/material.dart';

import '../utils/utils.dart';

class BottomLoaderPadding extends StatelessWidget {
  /// A widget that center and adds a padding to the bottom and top of its child widget,
  /// typically used to add space for a loading indicator.
  ///
  /// The [child] argument must not be null.
  const BottomLoaderPadding({
    super.key,
    required this.child,
  });

  /// The widget below this widget in the tree.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    // Returns a Padding widget that centers the [child] widget and
    // adds vertical padding to the bottom of the widget.
    //
    // The vertical padding is the value of [defaultBottomLoaderPadding].
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: defaultBottomLoaderPadding,
      ),
      child: Center(child: child),
    );
  }
}
