import 'package:flutter/material.dart';

import '../../models/models.dart';
import 'sliver_infinite_grid_view.dart';

class InfiniteGridView extends BoxScrollView {
  /// The `InfiniteGridView` is similar to [GridView.builder], but it allows for infinite scrolling in both directions.
  /// The `InfiniteGridView` widget is a paginated layout that displays items in a grid view.
  /// It uses a PaginationDelegate to manage the data and state of the layout,
  /// and a SliverGridDelegate to control the layout of the items.
  ///
  /// The `InfiniteGridView` can be used to create layouts with an infinite number of items,
  /// and it supports features such as loading indicators, error indicators, and no more items indicators.
  /// The `InfiniteGridView` widget is a good choice for creating paginated layouts that are visually appealing and easy to use.
  /// It is also a good choice for layouts that need to support a large number of items.
  const InfiniteGridView({
    super.key,
    super.scrollDirection,
    super.reverse,
    super.controller,
    super.primary,
    super.physics,
    super.shrinkWrap,
    super.padding,
    super.cacheExtent,
    int? semanticChildCount,
    super.dragStartBehavior,
    super.keyboardDismissBehavior,
    super.restorationId,
    super.clipBehavior,
    ChildIndexGetter? findChildIndexCallback,
    int? itemCount,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    required this.gridDelegate,
    required this.delegate,
  });

  /// The `PaginationDelegate` contains all the necessary information for a paginated layout, such as
  /// the item count, item builder, loading indicator builder, error indicator
  /// builder, no more items indicator builder, loading state, error state,
  /// and more.
  final PaginationDelegate delegate;

  /// The `gridDelegate` argument is a delegate that controls the layout of the children within the [GridView] and
  /// argument corresponds to the [GridView.gridDelegate].
  final SliverGridDelegate gridDelegate;

  /// The `addAutomaticKeepAlives` argument corresponds to the
  /// [SliverChildBuilderDelegate.addAutomaticKeepAlives] property.
  final bool addAutomaticKeepAlives;

  /// The `addRepaintBoundaries` argument corresponds to the
  /// [SliverChildBuilderDelegate.addRepaintBoundaries] property.
  final bool addRepaintBoundaries;

  /// The `addSemanticIndexes` argument corresponds to the
  /// [SliverChildBuilderDelegate.addSemanticIndexes] property.
  final bool addSemanticIndexes;

  @override
  Widget buildChildLayout(BuildContext context) {
    return SliverInfiniteGridView(
      delegate: delegate,
      gridDelegate: gridDelegate,
      addAutomaticKeepAlives: addAutomaticKeepAlives,
      addRepaintBoundaries: addRepaintBoundaries,
      addSemanticIndexes: addSemanticIndexes,
    );
  }
}
