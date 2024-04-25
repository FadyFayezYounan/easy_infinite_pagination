import 'package:easy_infinite_pagination/easy_infinite_pagination.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

// THE FOLLOWING CODE SHOW HOW TO IMPLEMENT A CUSTOM PAGINATION,
// IF YOU ARE USING MASONRY GRID VIEW IN YOUR APP, YOU CAN USE THE FOLLOWING CODE
// TO ADD INFINITE PAGINATION TO MASONRY GRID VIEW.

class SliverInfiniteMasonryGridView extends StatelessWidget {
  /// A widget that displays a masonry grid view with infinite pagination.
  ///
  /// This widget uses the [PaginationLayoutBuilder] to handle the pagination
  /// logic and display the items in a masonry grid view.
  const SliverInfiniteMasonryGridView({
    super.key,
    required this.paginationDelegate,
    required this.gridDelegate,
    this.mainAxisSpacing = 0.0,
    this.crossAxisSpacing = 0.0,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
  });

  /// The `PaginationDelegate` contains all the necessary information for a paginated layout, such as
  /// the item count, item builder, loading indicator builder, error indicator
  /// builder, no more items indicator builder, loading state, error state,
  /// and more.
  final PaginationDelegate paginationDelegate;

  /// The grid delegate used by this widget.
  final SliverSimpleGridDelegate gridDelegate;

  /// The spacing between the grid's main axis.
  final double mainAxisSpacing;

  /// The spacing between the grid's cross axis.
  final double crossAxisSpacing;

  /// The `addAutomaticKeepAlives` argument corresponds to the
  /// [SliverChildBuilderDelegate.addAutomaticKeepAlives] property.
  final bool addAutomaticKeepAlives;

  /// The `addRepaintBoundaries` argument corresponds to the
  /// [SliverChildBuilderDelegate.addRepaintBoundaries] property.
  final bool addRepaintBoundaries;

  /// The `addSemanticIndexes` argument corresponds to the
  /// [SliverChildBuilderDelegate.addSemanticIndexes] property.
  final bool addSemanticIndexes;

  /// Creates a widget that equivalent to [SliverMasonryGrid.count] but with infinite pagination.
  SliverInfiniteMasonryGridView.count({
    super.key,
    required this.paginationDelegate,
    required int crossAxisCount,
    this.mainAxisSpacing = 0.0,
    this.crossAxisSpacing = 0.0,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
  }) : gridDelegate = SliverSimpleGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
        );

  /// Creates a widget that equivalent to [SliverMasonryGrid.extent] but with infinite pagination.
  SliverInfiniteMasonryGridView.extent({
    required this.paginationDelegate,
    required double maxCrossAxisExtent,
    this.mainAxisSpacing = 0.0,
    this.crossAxisSpacing = 0.0,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    super.key,
  }) : gridDelegate = SliverSimpleGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: maxCrossAxisExtent,
        );

  @override
  Widget build(BuildContext context) {
    return PaginationLayoutBuilder(
      // Provider the layout strategy (box or sliver).
      // In this case we used the sliver strategy.
      // because the child is sliver widget.
      layoutStrategy: LayoutStrategy.sliver,
      delegate: paginationDelegate,
      layoutChildBuilder: (
        context,
        itemBuilder,
        itemCount,
        bottomLoaderBuilder,
      ) =>
          SliverMasonryGrid(
        gridDelegate: gridDelegate,
        mainAxisSpacing: mainAxisSpacing,
        crossAxisSpacing: crossAxisSpacing,
        // Here we create a predefined sliver delegate by the package
        // this delegate is used to handle the bottom loader widget while loading, success and error state.
        delegate: PaginationLayoutBuilder.createSliverChildDelegate(
          builder: itemBuilder,
          childCount: itemCount,
          bottomLoaderBuilder: bottomLoaderBuilder,
          addAutomaticKeepAlives: addAutomaticKeepAlives,
          addRepaintBoundaries: addRepaintBoundaries,
          addSemanticIndexes: addSemanticIndexes,
        ),
      ),
    );
  }
}
