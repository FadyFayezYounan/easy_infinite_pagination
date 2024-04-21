import 'package:flutter/material.dart';

import '../../core/core.dart';
import '../../models/models.dart';

class SliverInfiniteListView extends StatelessWidget {
  /// A customizable sliver list that supports infinite scrolling.
  ///
  /// This widget is designed to be used within a CustomScrollView to display a list of items with various features such as separators,
  /// bottom loader.
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

  /// [PaginationDelegate] contains all the necessary information for a paginated layout, such as
  /// the item count, item builder, loading indicator builder, error indicator
  /// builder, no more items indicator builder, loading state, error state,
  /// and more.
  final PaginationDelegate delegate;

  /// Matches [SliverChildBuilderDelegate.addAutomaticKeepAlives].
  final bool addAutomaticKeepAlives;

  /// Matches [SliverChildBuilderDelegate.addRepaintBoundaries].
  final bool addRepaintBoundaries;

  /// Matches [SliverChildBuilderDelegate.addSemanticIndexes].
  final bool addSemanticIndexes;

  /// A callback used to determine the semantic index for a given index.
  final SemanticIndexCallback? semanticIndexCallback;

  /// Matches [SliverFixedExtentList.itemExtent].
  ///
  /// If this is not null, [prototypeItem] must be null, and vice versa.
  final double? itemExtent;

  /// Matches [SliverPrototypeExtentList.prototypeItem].
  ///
  /// If this is not null, [itemExtent] must be null, and vice versa.
  final Widget? prototypeItem;

  /// Whether to use shrink wrap for first page indicators.
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
    final itemExtent = this.itemExtent;
    if ((itemExtent == null && prototypeItem == null) ||
        _separatorBuilder != null) {
      // If not, return a sliver list widget.
      return SliverList(
        delegate: delegate,
      );
    } else if (itemExtent != null) {
      // If it has a fixed extent, return a sliver fixed extent list widget.
      return SliverFixedExtentList(
        itemExtent: itemExtent,
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
    final separatorBuilder = _separatorBuilder;
    return separatorBuilder == null
        // Build the regular delegate.
        ? AppendedBottomLoaderSliverChildBuilderDelegate(
            builder: itemBuilder,
            childCount: itemCount,
            bottomLoaderBuilder: bottomLoaderBuilder,
            addAutomaticKeepAlives: addAutomaticKeepAlives,
            addRepaintBoundaries: addRepaintBoundaries,
            addSemanticIndexes: addSemanticIndexes,
            semanticIndexCallback: semanticIndexCallback,
          )
        // Build the delegate with a separator builder.
        : AppendedBottomLoaderSliverChildBuilderDelegate.separated(
            builder: itemBuilder,
            childCount: itemCount,
            bottomLoaderBuilder: bottomLoaderBuilder,
            separatorBuilder: separatorBuilder,
            addAutomaticKeepAlives: addAutomaticKeepAlives,
            addRepaintBoundaries: addRepaintBoundaries,
            addSemanticIndexes: addSemanticIndexes,
          );
  }
}
