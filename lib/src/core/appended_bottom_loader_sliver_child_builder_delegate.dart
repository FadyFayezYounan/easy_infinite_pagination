import 'dart:math' as math show max;

import 'package:flutter/material.dart';

/// A custom implementation of [SliverChildBuilderDelegate] that allows the
/// addition of a bottom loader widget.
class AppendedBottomLoaderSliverChildBuilderDelegate
    extends SliverChildBuilderDelegate {
  /// Creates a [AppendedBottomLoaderSliverChildBuilderDelegate].
  ///
  /// The [builder] parameter is required and must not be null.
  /// The [childCount] parameter is required and must be greater than zero.
  /// The [bottomLoaderBuilder] parameter is optional and can be null.
  AppendedBottomLoaderSliverChildBuilderDelegate({
    required IndexedWidgetBuilder builder,
    required int childCount,
    WidgetBuilder? bottomLoaderBuilder,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    SemanticIndexCallback? semanticIndexCallback,
  }) : super(
          // If a bottom loader widget is provided, wrap the original builder
          // with a function that returns the bottom loader widget when the
          // index is equal to the child count. Otherwise, return the original
          // builder.
          bottomLoaderBuilder == null
              ? builder
              : (context, index) {
                  if (index == childCount) {
                    return bottomLoaderBuilder(context);
                  }
                  return builder(context, index);
                },
          // If a bottom loader widget is provided, add 1 to the child count
          // to account for the bottom loader. Otherwise, use the provided
          // child count.
          childCount: bottomLoaderBuilder == null ? childCount : childCount + 1,
          addAutomaticKeepAlives: addAutomaticKeepAlives,
          addRepaintBoundaries: addRepaintBoundaries,
          addSemanticIndexes: addSemanticIndexes,
          semanticIndexCallback: semanticIndexCallback ?? (_, index) => index,
        );

  /// Creates a [AppendedBottomLoaderSliverChildBuilderDelegate] with a separator widget.
  ///
  /// The [builder] parameter is required and must not be null.
  /// The [childCount] parameter is required and must be greater than zero.
  /// The [separatorBuilder] parameter is required and must not be null.
  /// The [bottomLoaderBuilder] parameter is optional and can be null.
  AppendedBottomLoaderSliverChildBuilderDelegate.separated({
    required IndexedWidgetBuilder builder,
    required int childCount,
    required IndexedWidgetBuilder separatorBuilder,
    WidgetBuilder? bottomLoaderBuilder,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
  }) : this(
          // If the index is even, return the item builder. Otherwise, return
          // the separator builder.
          builder: (context, index) {
            final itemIndex = index ~/ 2;
            if (index.isEven) {
              return builder(context, itemIndex);
            }
            return separatorBuilder(context, itemIndex);
          },
          childCount:
              _computeActualChildCount(childCount, bottomLoaderBuilder != null),
          bottomLoaderBuilder: bottomLoaderBuilder,
          addAutomaticKeepAlives: addAutomaticKeepAlives,
          addRepaintBoundaries: addRepaintBoundaries,
          addSemanticIndexes: addSemanticIndexes,
          semanticIndexCallback: (_, index) => index.isEven ? index ~/ 2 : null,
        );

  /// Computes the actual child count based on the provided child count
  /// and whether or not an bottomLoaderBuilder widget is provided.
  static int _computeActualChildCount(int itemCount, bool hasBottomLoader) {
    return math.max(0, itemCount * 2 - (hasBottomLoader ? 0 : 1));
  }
}
