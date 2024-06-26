import 'package:flutter/material.dart';

import '../../models/models.dart';
import 'sliver_infinite_list_view.dart';

class InfiniteListView extends BoxScrollView {
  /// The `InfiniteListView` widget in Flutter is a specialized version of the `ListView.builder` widget that is designed for handling large datasets efficiently.
  /// It uses a pagination approach to load and display data in pages as the user scrolls down the list.
  /// This helps to improve performance and reduce memory usage, especially when dealing with large datasets that cannot be fully loaded into memory at once.
  ///
  /// The `InfiniteListView` widget takes a `PaginationDelegate` as its main parameter, which defines the behavior of the list,
  /// including the item count, item builder, loading indicator builder, error indicator builder, no more items indicator builder,
  /// loading state, error state, and more.
  ///
  /// Overall, the `InfiniteListView` widget is a powerful and efficient solution for building paginated lists in Flutter applications, especially when dealing with large datasets.
  const InfiniteListView({
    super.key,
    super.scrollDirection,
    super.reverse,
    super.controller,
    super.primary,
    super.physics,
    super.padding,
    super.cacheExtent,
    super.dragStartBehavior,
    super.keyboardDismissBehavior,
    super.restorationId,
    super.clipBehavior,
    this.itemExtent,
    this.prototypeItem,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    required this.delegate,
    super.shrinkWrap,
  })  : assert(
          itemExtent == null || prototypeItem == null,
          'You can only pass itemExtent or prototypeItem, not both',
        ),
        _enableShrinkWrapForFirstPageIndicators = shrinkWrap,
        _separatorBuilder = null;
  const InfiniteListView.separated({
    super.key,
    super.scrollDirection,
    super.reverse,
    super.controller,
    super.primary,
    super.physics,
    super.padding,
    super.cacheExtent,
    super.dragStartBehavior,
    super.keyboardDismissBehavior,
    super.restorationId,
    super.clipBehavior,
    this.itemExtent,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    required this.delegate,
    required IndexedWidgetBuilder separatorBuilder,
    super.shrinkWrap,
  })  : prototypeItem = null,
        _enableShrinkWrapForFirstPageIndicators = shrinkWrap,
        _separatorBuilder = separatorBuilder;

  /// The `PaginationDelegate` contains all the necessary information for a paginated layout, such as
  /// the item count, item builder, loading indicator builder, error indicator
  /// builder, no more items indicator builder, loading state, error state,
  /// and more.
  final PaginationDelegate delegate;

  /// The `separatorBuilder` argument is used to separate the items of the list.
  final IndexedWidgetBuilder? _separatorBuilder;

  /// The `addAutomaticKeepAlives` argument corresponds to the
  /// [SliverChildBuilderDelegate.addAutomaticKeepAlives] property.
  final bool addAutomaticKeepAlives;

  /// The `addRepaintBoundaries` argument corresponds to the
  /// [SliverChildBuilderDelegate.addRepaintBoundaries] property.
  final bool addRepaintBoundaries;

  /// The `addSemanticIndexes` argument corresponds to the
  /// [SliverChildBuilderDelegate.addSemanticIndexes] property.
  final bool addSemanticIndexes;

  /// If non-null, forces the children to have the given extent in the scroll
  /// direction.
  ///
  /// Specifying an [itemExtent] is more efficient than letting the children
  /// determine their own extent because the scrolling machinery can make use of
  /// the foreknowledge of the children's extent to save work, for example when
  /// the scroll position changes drastically.
  /// The `itemExtent` argument corresponds to the [SliverFixedExtentList.itemExtent] property.
  ///
  /// If this is not null, [prototypeItem] must be null, and vice versa.
  final double? itemExtent;

  /// If non-null, forces the children to have the same extent as the given
  /// widget in the scroll direction.
  ///
  /// Specifying an [prototypeItem] is more efficient than letting the children
  /// determine their own extent because the scrolling machinery can make use of
  /// the foreknowledge of the children's extent to save work, for example when
  /// the scroll position changes drastically.
  ///
  /// The `prototypeItem` argument corresponds to the [SliverPrototypeExtentList.prototypeItem] property.
  ///
  /// If this is not null, [itemExtent] must be null, and vice versa.
  final Widget? prototypeItem;

  /// Whether to use shrink wrap for first page indicators.
  final bool _enableShrinkWrapForFirstPageIndicators;

  @override
  Widget buildChildLayout(BuildContext context) {
    return switch (_separatorBuilder) {
      null => SliverInfiniteListView(
          delegate: delegate,
          addAutomaticKeepAlives: addAutomaticKeepAlives,
          addRepaintBoundaries: addRepaintBoundaries,
          addSemanticIndexes: addSemanticIndexes,
          itemExtent: itemExtent,
          prototypeItem: prototypeItem,
          enableShrinkWrapForFirstPageIndicators:
              _enableShrinkWrapForFirstPageIndicators,
        ),
      _ => SliverInfiniteListView.separated(
          delegate: delegate,
          separatorBuilder: _separatorBuilder,
          addAutomaticKeepAlives: addAutomaticKeepAlives,
          addRepaintBoundaries: addRepaintBoundaries,
          addSemanticIndexes: addSemanticIndexes,
          itemExtent: itemExtent,
          enableShrinkWrapForFirstPageIndicators:
              _enableShrinkWrapForFirstPageIndicators,
        ),
    };
  }
}
