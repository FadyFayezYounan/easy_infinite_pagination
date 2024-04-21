import 'package:flutter/material.dart';

import '../../models/models.dart';
import 'sliver_infinite_list_view.dart';

class InfiniteListView extends BoxScrollView {
  /// The InfiniteListView widget is a paginated layout that allows you to display a large number of items efficiently.
  /// It is designed to be used with a PaginationDelegate, which provides the necessary information for the layout,
  /// such as the item count, item builder, loading indicator builder, error indicator builder, no more items indicator builder,
  /// loading state, error state, and more.
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
        _useShrinkWrapForFirstPageIndicators = shrinkWrap,
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
    this.prototypeItem,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    required this.delegate,
    required IndexedWidgetBuilder separatorBuilder,
    super.shrinkWrap,
  })  : assert(
          itemExtent == null || prototypeItem == null,
          'You can only pass itemExtent or prototypeItem, not both',
        ),
        _useShrinkWrapForFirstPageIndicators = shrinkWrap,
        _separatorBuilder = separatorBuilder;

  /// [PaginationDelegate] contains all the necessary information for a paginated layout, such as
  /// the item count, item builder, loading indicator builder, error indicator
  /// builder, no more items indicator builder, loading state, error state,
  /// and more.
  final PaginationDelegate delegate;

  /// A [IndexedWidgetBuilder] that is used to separate the items of the list.
  final IndexedWidgetBuilder? _separatorBuilder;

  /// Matches [SliverChildBuilderDelegate.addAutomaticKeepAlives].
  final bool addAutomaticKeepAlives;

  /// Matches [SliverChildBuilderDelegate.addRepaintBoundaries].
  final bool addRepaintBoundaries;

  /// Matches [SliverChildBuilderDelegate.addSemanticIndexes].
  final bool addSemanticIndexes;

  /// Matches [SliverFixedExtentList.itemExtent].
  ///
  /// If this is not null, [prototypeItem] must be null, and vice versa.
  final double? itemExtent;

  /// Matches [SliverPrototypeExtentList.prototypeItem].
  ///
  /// If this is not null, [itemExtent] must be null, and vice versa.
  final Widget? prototypeItem;

  /// Whether to use shrink wrap for first page indicators.
  final bool _useShrinkWrapForFirstPageIndicators;

  @override
  Widget buildChildLayout(BuildContext context) {
    final hasSeparatorBuilder = _separatorBuilder != null;
    if (hasSeparatorBuilder) {
      return SliverInfiniteListView.separated(
        delegate: delegate,
        separatorBuilder: _separatorBuilder,
        addAutomaticKeepAlives: addAutomaticKeepAlives,
        addRepaintBoundaries: addRepaintBoundaries,
        addSemanticIndexes: addSemanticIndexes,
        itemExtent: itemExtent,
        useShrinkWrapForFirstPageIndicators:
            _useShrinkWrapForFirstPageIndicators,
      );
    }
    return SliverInfiniteListView(
      delegate: delegate,
      addAutomaticKeepAlives: addAutomaticKeepAlives,
      addRepaintBoundaries: addRepaintBoundaries,
      addSemanticIndexes: addSemanticIndexes,
      itemExtent: itemExtent,
      prototypeItem: prototypeItem,
      useShrinkWrapForFirstPageIndicators: _useShrinkWrapForFirstPageIndicators,
    );
  }
}
