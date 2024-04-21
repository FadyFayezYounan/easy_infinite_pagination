import 'package:flutter/material.dart';

/// A mixin that can be used by a `State` to invoke a function after the
/// layout of the widget has completed.
///
/// This is typically useful for widgets that need to perform an action
/// after they have been laid out, such as scrolling to a specific position.
mixin LayoutCompleteMixin<T extends StatefulWidget> on State<T> {
  /// The function to invoke after the layout of the widget has completed.
  ///
  /// Subclasses should override this method and perform the desired action.
  void onLayoutComplete();

  /// Override the `initState` method to add a `postFrameCallback` to the
  /// `WidgetsBinding` instance.
  ///
  /// The `postFrameCallback` will invoke the `onLayoutComplete` method after
  /// the layout of the widget has completed.
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) onLayoutComplete();
    });
  }
}
