import 'package:easy_infinite_pagination/easy_infinite_pagination.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

// THE FOLLOWING CODE SHOW HOW TO IMPLEMENT A CUSTOM PAGINATION,
// IF YOU ARE USING MASONRY GRID VIEW IN YOUR APP, YOU CAN USE THE FOLLOWING CODE
// TO ADD INFINITE PAGINATION TO MASONRY GRID VIEW.

class InfiniteMasonryGridView extends StatelessWidget {
  /// A widget that displays a masonry grid view with infinite pagination.
  ///
  /// This widget uses the [PaginationLayoutBuilder] to handle the pagination
  /// logic and display the items in a masonry grid view.
  const InfiniteMasonryGridView({
    super.key,
    required this.paginationDelegate,
    required this.gridDelegate,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.scrollController,
    this.primary,
    this.physics,
    this.padding,
    this.mainAxisSpacing = 0.0,
    this.crossAxisSpacing = 0.0,
    this.cacheExtent,
    this.dragStartBehavior = DragStartBehavior.start,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.restorationId,
    this.clipBehavior = Clip.hardEdge,
    bool shrinkWrap = false,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
  }) : _useShrinkWrapForFirstPageIndicators = shrinkWrap;

  /// The `PaginationDelegate` contains all the necessary information for a paginated layout, such as
  /// the item count, item builder, loading indicator builder, error indicator
  /// builder, no more items indicator builder, loading state, error state,
  /// and more.
  final PaginationDelegate paginationDelegate;

  /// The grid delegate used by this widget.
  final SliverSimpleGridDelegate gridDelegate;

  /// The scroll direction of this widget.
  final Axis scrollDirection;

  /// The `reverse` argument corresponds to the
  /// [ScrollView.reverse] property.
  final bool reverse;

  /// The scroll controller for this widget.
  final ScrollController? scrollController;

  /// The `primary` argument corresponds to the
  /// [ScrollView.primary] property.
  final bool? primary;

  /// The physics of the scroll view.
  final ScrollPhysics? physics;

  /// The padding of the scroll view.
  final EdgeInsetsGeometry? padding;

  /// The spacing between the grid's main axis.
  final double mainAxisSpacing;

  /// The spacing between the grid's cross axis.
  final double crossAxisSpacing;

  /// The `cacheExtent` argument corresponds to the
  /// [ScrollView.cacheExtent] property.
  final double? cacheExtent;

  /// The drag behavior for the scroll view.
  final DragStartBehavior dragStartBehavior;

  /// The behavior of the scroll view when a keyboard is connected.
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;

  /// The restoration id for the scroll view.
  final String? restorationId;

  /// The clip behavior for the scroll view.
  final Clip clipBehavior;

  /// The `addAutomaticKeepAlives` argument corresponds to the
  /// [SliverChildBuilderDelegate.addAutomaticKeepAlives] property.
  final bool addAutomaticKeepAlives;

  /// The `addRepaintBoundaries` argument corresponds to the
  /// [SliverChildBuilderDelegate.addRepaintBoundaries] property.
  final bool addRepaintBoundaries;

  /// The `addSemanticIndexes` argument corresponds to the
  /// [SliverChildBuilderDelegate.addSemanticIndexes] property.
  final bool addSemanticIndexes;

  /// Whether to use shrink wrap for the first page indicators.
  final bool _useShrinkWrapForFirstPageIndicators;

  /// Creates a widget that equivalent to [MasonryGridView.count] but with infinite pagination.
  InfiniteMasonryGridView.count({
    super.key,
    required this.paginationDelegate,
    required int crossAxisCount,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.scrollController,
    this.primary,
    this.physics,
    this.padding,
    this.mainAxisSpacing = 0.0,
    this.crossAxisSpacing = 0.0,
    this.cacheExtent,
    this.dragStartBehavior = DragStartBehavior.start,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.restorationId,
    this.clipBehavior = Clip.hardEdge,
    bool shrinkWrap = false,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
  })  : _useShrinkWrapForFirstPageIndicators = shrinkWrap,
        gridDelegate = SliverSimpleGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
        );

  /// Creates a widget that equivalent to [MasonryGridView.extent] but with infinite pagination.
  InfiniteMasonryGridView.extent({
    required this.paginationDelegate,
    required double maxCrossAxisExtent,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.scrollController,
    this.primary,
    this.physics,
    this.padding,
    this.mainAxisSpacing = 0.0,
    this.crossAxisSpacing = 0.0,
    this.cacheExtent,
    this.dragStartBehavior = DragStartBehavior.start,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.restorationId,
    this.clipBehavior = Clip.hardEdge,
    bool shrinkWrap = false,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    super.key,
  })  : _useShrinkWrapForFirstPageIndicators = shrinkWrap,
        gridDelegate = SliverSimpleGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: maxCrossAxisExtent,
        );

  @override
  Widget build(BuildContext context) {
    return PaginationLayoutBuilder(
      // Provider the layout strategy (box or sliver).
      // In this case we used the box strategy.
      // because the child not sliver widget.
      layoutStrategy: LayoutStrategy.box,
      delegate: paginationDelegate,
      useShrinkWrapForFirstPageIndicators: _useShrinkWrapForFirstPageIndicators,
      layoutChildBuilder: (
        context,
        itemBuilder,
        itemCount,
        bottomLoaderBuilder,
      ) =>
          MasonryGridView.custom(
        gridDelegate: gridDelegate,
        mainAxisSpacing: mainAxisSpacing,
        crossAxisSpacing: crossAxisSpacing,
        padding: padding,
        // Here we create a predefined sliver delegate by the package
        // this delegate is used to handle the bottom loader widget while loading, success and error state.
        childrenDelegate: PaginationLayoutBuilder.createSliverChildDelegate(
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
