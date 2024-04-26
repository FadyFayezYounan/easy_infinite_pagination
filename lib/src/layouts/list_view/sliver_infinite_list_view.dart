import 'package:flutter/material.dart';

import '../../core/core.dart';
import '../../models/models.dart';

class SliverInfiniteListView extends StatelessWidget {
  /// The `SliverInfiniteListView` widget in Flutter is a specialized version of the `SliverList.builder` widget that is designed for handling large datasets efficiently.
  /// It uses a pagination approach to load and display data in pages as the user scrolls down the list.
  /// This helps to improve performance and reduce memory usage, especially when dealing with large datasets that cannot be fully loaded into memory at once.
  ///
  /// The `SliverInfiniteListView` widget takes a `PaginationDelegate` as its main parameter, which defines the behavior of the list,
  /// including the item count, item builder, loading indicator builder, error indicator builder, no more items indicator builder,
  /// loading state, error state, and more.
  ///
  /// Overall, the `SliverInfiniteListView` widget is a powerful and efficient solution for building paginated lists in Flutter applications, especially when dealing with large datasets.
  const SliverInfiniteListView({
    super.key,
    required this.delegate,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.semanticIndexCallback,
    this.itemExtent,
    this.prototypeItem,
    this.useShrinkWrapForFirstPageIndicators = false,
  })  : assert(
          itemExtent == null || prototypeItem == null,
          'You can only pass itemExtent or prototypeItem, not both',
        ),
        _separatorBuilder = null;

  const SliverInfiniteListView.separated({
    super.key,
    required this.delegate,
    required IndexedWidgetBuilder separatorBuilder,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.semanticIndexCallback,
    this.itemExtent,
    this.useShrinkWrapForFirstPageIndicators = false,
  })  : prototypeItem = null,
        _separatorBuilder = separatorBuilder;

  /// A [IndexedWidgetBuilder] that is used to separate the items of the list.
  final IndexedWidgetBuilder? _separatorBuilder;

  /// The `PaginationDelegate` contains all the necessary information for a paginated layout, such as
  /// the item count, item builder, loading indicator builder, error indicator
  /// builder, no more items indicator builder, loading state, error state,
  /// and more.
  final PaginationDelegate delegate;

  /// The `addAutomaticKeepAlives` argument corresponds to the
  /// [SliverChildBuilderDelegate.addAutomaticKeepAlives] property.
  final bool addAutomaticKeepAlives;

  /// The `addRepaintBoundaries` argument corresponds to the
  /// [SliverChildBuilderDelegate.addRepaintBoundaries] property.
  final bool addRepaintBoundaries;

  /// The `addSemanticIndexes` argument corresponds to the
  /// [SliverChildBuilderDelegate.addSemanticIndexes] property.
  final bool addSemanticIndexes;

  /// A [SemanticIndexCallback] which is used when [addSemanticIndexes] is true.
  ///Defaults to providing an index for each widget.
  final SemanticIndexCallback? semanticIndexCallback;

  /// If non-null, forces the children to have the given extent in the scroll
  /// direction.
  ///
  /// Specifying an [itemExtent] is more efficient than letting the children
  /// determine their own extent because the scrolling machinery can make use of
  /// the foreknowledge of the children's extent to save work, for example when
  /// the scroll position changes drastically.
  /// The `itemExtent` argument corresponds to the [SliverFixedExtentList.itemExtent].
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
  /// The `prototypeItem` argument corresponds to the [SliverPrototypeExtentList.prototypeItem].
  ///
  /// If this is not null, [itemExtent] must be null, and vice versa.
  final Widget? prototypeItem;

  /// Whether to use shrink wrap for first page indicators or not.
  final bool useShrinkWrapForFirstPageIndicators;

  @override
  Widget build(BuildContext context) {
    return PaginationLayoutBuilder(
      layoutStrategy: LayoutStrategy.sliver,
      delegate: delegate,
      layoutChildBuilder: _buildSliverList,
      useShrinkWrapForFirstPageIndicators: useShrinkWrapForFirstPageIndicators,
    );
  }

  /// Builds a sliver list widget based on the given parameters.
  ///
  /// This method builds a sliver list widget based on the provided [BuildContext],
  /// [itemBuilder], [itemCount], and [bottomLoaderBuilder]. It also handles the logic
  /// for separating the items in the sliver, if needed, and configures the delegate
  /// with the appropriate parameters.
  ///
  /// Parameters:
  ///   * [context] - The build context.
  ///   * [itemBuilder] - The builder responsible for building the child widgets of the sliver.
  ///   * [itemCount] - The total number of items in the sliver.
  ///   * [bottomLoaderBuilder] - The optional builder for the bottom loader widget.
  ///
  /// Returns:
  ///   * A [SliverList], [SliverFixedExtentList], or [SliverPrototypeExtentList] widget.
  SliverMultiBoxAdaptorWidget _buildSliverList(
    BuildContext context,
    IndexedWidgetBuilder itemBuilder,
    int itemCount,
    WidgetBuilder? bottomLoaderBuilder,
  ) {
    // Build the sliver delegate.
    final delegate = _buildSliverDelegate(
      itemBuilder,
      itemCount,
      bottomLoaderBuilder: bottomLoaderBuilder,
    );

    // Check if the item has a fixed extent or a prototype item.
    final shouldReturnSliverList =
        (itemExtent == null && prototypeItem == null) ||
            _separatorBuilder != null;
    if (shouldReturnSliverList) {
      // If not, return a sliver list widget.
      return SliverList(
        delegate: delegate,
      );
    } else if (itemExtent != null) {
      // If it has a fixed extent, return a sliver fixed extent list widget.
      return SliverFixedExtentList(
        itemExtent: itemExtent!,
        delegate: delegate,
      );
    } else {
      // If it has a prototype item, return a sliver prototype extent list widget.
      return SliverPrototypeExtentList(
        prototypeItem: prototypeItem!,
        delegate: delegate,
      );
    }
  }

  /// Builds a [SliverChildBuilderDelegate] for the Sliver with the given parameters.
  ///
  /// This method is responsible for building the Sliver delegate based on the given
  /// [itemBuilder], [itemCount], and [bottomLoaderBuilder]. It handles the logic for
  /// separating the items in the Sliver, if needed, and configures the delegate with
  /// the appropriate parameters.
  ///
  /// Parameters:
  ///   * [itemBuilder]: The builder responsible for building the child widgets of the Sliver.
  ///   * [itemCount]: The total number of items in the Sliver.
  ///   * [bottomLoaderBuilder]: The optional builder for the bottom loader widget.

  SliverChildBuilderDelegate _buildSliverDelegate(
    IndexedWidgetBuilder itemBuilder,
    int itemCount, {
    WidgetBuilder? bottomLoaderBuilder,
  }) {
    // Check if a separator builder is provided. If not, use the regular delegate.
    return switch (_separatorBuilder) {
      null => PaginationLayoutBuilder.createSliverChildDelegate(
          builder: itemBuilder,
          childCount: itemCount,
          bottomLoaderBuilder: bottomLoaderBuilder,
          addAutomaticKeepAlives: addAutomaticKeepAlives,
          addRepaintBoundaries: addRepaintBoundaries,
          addSemanticIndexes: addSemanticIndexes,
          semanticIndexCallback: semanticIndexCallback,
        ),
      _ => PaginationLayoutBuilder.createSeparatedSliverChildDelegate(
          builder: itemBuilder,
          childCount: itemCount,
          bottomLoaderBuilder: bottomLoaderBuilder,
          separatorBuilder: _separatorBuilder,
          addAutomaticKeepAlives: addAutomaticKeepAlives,
          addRepaintBoundaries: addRepaintBoundaries,
          addSemanticIndexes: addSemanticIndexes,
        ),
    };
  }
}
