import 'package:flutter/material.dart';

/// A function type that takes in several parameters and returns a [Widget].
///
/// This function is used to build a [Widget] that represents a layout of child widgets.
///
/// The [BuildContext] is the current build context of the widget tree.
/// The [IndexedWidgetBuilder] is a function that builds a widget for each item in the layout.
/// The [int] is the number of items in the layout.
/// The optional [WidgetBuilder] is used to build a widget at the end of the layout,
/// which is often used to indicate that there are more items to load or that an error occurred or the data is loading.
typedef LayoutChildBuilder = Widget Function(
  /// The current build context of the widget tree.
  BuildContext context,

  /// A function that builds a widget for each item in the layout.
  IndexedWidgetBuilder itemBuilder,

  /// The number of items in the layout.
  int itemCount,

  /// An optional widget builder for a widget at the end of the layout.
  /// This is often used to indicate that there are more items to load or that an error occurred.
  WidgetBuilder? bottomLoaderBuilder,
);
