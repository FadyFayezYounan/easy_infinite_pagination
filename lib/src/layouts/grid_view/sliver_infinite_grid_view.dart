import 'package:flutter/material.dart';

import '../../core/core.dart';
import '../../models/models.dart';

class SliverInfiniteGridView extends StatelessWidget {
  /// The `SliverInfiniteGridView` is similar to [SliverGrid.builder], but it allows for infinite scrolling.
  ///
  /// The `SliverInfiniteGridView` widget is a paginated layout that displays items in a grid view.
  /// It uses a PaginationDelegate to manage the data and state of the layout, and a SliverGridDelegate to control the layout of the items.
  ///
  /// The `SliverInfiniteGridView` can be used to create layouts with an infinite number of items,
  /// and it supports features such as loading indicators, error indicators, and no more items indicators.
  ///
  /// The `SliverInfiniteGridView` widget is a good choice for creating paginated layouts that are visually appealing and easy to use.
  /// It is also a good choice for layouts that need to support a large number of items.
  const SliverInfiniteGridView({
    super.key,
    required this.delegate,
    required this.gridDelegate,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
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
  Widget build(BuildContext context) {
    return PaginationLayoutBuilder(
      layoutStrategy: LayoutStrategy.sliver,
      delegate: delegate,
      layoutChildBuilder: _buildSliverGrid,
    );
  }

  SliverMultiBoxAdaptorWidget _buildSliverGrid(
    BuildContext context,
    IndexedWidgetBuilder itemBuilder,
    int itemCount,
    WidgetBuilder? bottomLoaderBuilder,
  ) {
    return SliverGrid(
      delegate: PaginationLayoutBuilder.createSliverChildDelegate(
        builder: itemBuilder,
        childCount: itemCount,
        bottomLoaderBuilder: bottomLoaderBuilder,
        addAutomaticKeepAlives: addAutomaticKeepAlives,
        addRepaintBoundaries: addRepaintBoundaries,
        addSemanticIndexes: addSemanticIndexes,
      ),
      gridDelegate: gridDelegate,
    );
  }
}
