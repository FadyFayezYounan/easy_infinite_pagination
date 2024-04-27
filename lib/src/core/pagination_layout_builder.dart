import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../models/models.dart';
import '../utils/utils.dart';
import '../widgets/widgets.dart';
import 'appended_bottom_loader_sliver_child_builder_delegate.dart';

class PaginationLayoutBuilder extends StatefulWidget {
  /// A widget that builds a layout based on pagination status using a custom layout strategy.
  ///
  /// This widget is designed to handle pagination logic and build the appropriate layout based on the pagination status,
  /// such as loading indicators, error messages, or the actual list of items.
  ///
  /// The [layoutStrategy] parameter determines the strategy used to build the
  /// layout.
  /// [delegate] provides the pagination delegate which contains necessary information for pagination logic.
  /// [layoutChildBuilder] parameter builds the child widgets of the scrollable widget.
  /// [enableShrinkWrapForFirstPageIndicators] determines whether to use shrink wrap for first page indicators.
  ///
  /// Example:
  /// ```dart
  /// PaginationLayoutBuilder(
  /// layoutStrategy: LayoutStrategy.sliver,
  /// delegate: PaginationDelegate(...),
  ///   layoutChildBuilder: (context, itemBuilder, itemCount, bottomLoaderBuilder) {
  ///     return SliverList(
  ///       delegate: PaginationLayoutBuilder.createSliverChildDelegate(
  ///          builder: itemBuilder,
  ///          childCount: itemCount,
  ///          bottomLoaderBuilder: bottomLoaderBuilder,
  ///       ),
  ///     );
  ///   },
  /// )
  /// ```
  const PaginationLayoutBuilder({
    super.key,
    required this.layoutStrategy,
    required this.delegate,
    required this.layoutChildBuilder,
    this.enableShrinkWrapForFirstPageIndicators = false,
  });

  /// The layout strategy used to build the layout (sliver or box).
  final LayoutStrategy layoutStrategy;

  /// The pagination delegate which contains necessary information for pagination logic.
  final PaginationDelegate delegate;

  /// The layout child builder builds the child widgets of the scrollable widget.
  final LayoutChildBuilder layoutChildBuilder;

  /// Whether to use shrink wrap for first page indicators.
  final bool enableShrinkWrapForFirstPageIndicators;

  /// Creates a new [AppendedBottomLoaderSliverChildBuilderDelegate] with the provided parameters.
  ///
  /// The [builder] parameter is used to build the item widget for each index.
  /// The [childCount] parameter is the total number of children.
  /// The [bottomLoaderBuilder] parameter is used to build the bottom loader widget.
  /// The [addAutomaticKeepAlives] parameter determines whether to add automatic keep alives.
  /// The [addRepaintBoundaries] parameter determines whether to add repaint boundaries.
  /// The [addSemanticIndexes] parameter determines whether to add semantic indexes.
  /// The [semanticIndexCallback] parameter is used to generate semantic indexes.
  ///
  /// Returns an instance of [AppendedBottomLoaderSliverChildBuilderDelegate].
  static AppendedBottomLoaderSliverChildBuilderDelegate
      createSliverChildDelegate({
    required IndexedWidgetBuilder builder,
    required int childCount,
    WidgetBuilder? bottomLoaderBuilder,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    SemanticIndexCallback? semanticIndexCallback,
  }) {
    return AppendedBottomLoaderSliverChildBuilderDelegate(
      builder: builder,
      childCount: childCount,
      bottomLoaderBuilder: bottomLoaderBuilder,
      addAutomaticKeepAlives: addAutomaticKeepAlives,
      addRepaintBoundaries: addRepaintBoundaries,
      addSemanticIndexes: addSemanticIndexes,
      semanticIndexCallback: semanticIndexCallback,
    );
  }

  static AppendedBottomLoaderSliverChildBuilderDelegate
      createSeparatedSliverChildDelegate({
    required IndexedWidgetBuilder builder,
    required IndexedWidgetBuilder separatorBuilder,
    required int childCount,
    WidgetBuilder? bottomLoaderBuilder,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    SemanticIndexCallback? semanticIndexCallback,
  }) {
    return AppendedBottomLoaderSliverChildBuilderDelegate.separated(
      builder: builder,
      separatorBuilder: separatorBuilder,
      childCount: childCount,
      bottomLoaderBuilder: bottomLoaderBuilder,
      addAutomaticKeepAlives: addAutomaticKeepAlives,
      addRepaintBoundaries: addRepaintBoundaries,
      addSemanticIndexes: addSemanticIndexes,
    );
  }

  @override
  State<PaginationLayoutBuilder> createState() =>
      _PaginationLayoutBuilderState();
}

class _PaginationLayoutBuilderState extends State<PaginationLayoutBuilder>
    with LayoutCompleteMixin<PaginationLayoutBuilder> {
  /// The [_debouncer] is used to debounce the pagination loading.
  ///
  /// It's initialized in the [onLayoutComplete] method.
  late final Debouncer _debouncer;

  /// [_lastItemIndex] represents the index of the last item in the data list.
  ///
  /// It's used to keep track of the last item index in the data list.
  /// This value is used to determine whether to fetch more data or not.
  /// It's updated in the [_buildItemBuilder] method.
  ///
  /// This value can be null if no item is built yet.
  int? _lastItemIndex;

  /// Getter methods for easier access to delegate.
  PaginationDelegate get _delegate => widget.delegate;

  /// Getter methods for easier access to layout strategy.
  LayoutStrategy get _layoutStrategy => widget.layoutStrategy;

  /// Getter methods for easier access to shrink wrap value.
  bool get _enableShrinkWrapForFirstPageIndicators =>
      widget.enableShrinkWrapForFirstPageIndicators;

  /// [_firstPageLoadingBuilder] is a getter method that returns a builder
  /// function for the first page loading indicator.
  ///
  /// This method retrieves the builder function from [_delegate.firstPageLoadingBuilder].
  /// If it's null, it falls back to the [firstPageLoadingBuilder] function.
  ///
  /// The [firstPageLoadingBuilder] function is responsible for building the
  /// widget that represents the first page loading indicator.
  WidgetBuilder get _firstPageLoadingBuilder =>
      _delegate.firstPageLoadingBuilder ?? firstPageLoadingBuilder;

  /// [_firstPageErrorBuilder] is a getter method that returns a builder
  /// function for the first page error indicator.
  ///
  /// This method retrieves the builder function from [_delegate.firstPageErrorBuilder].
  /// If it's null, it falls back to the [firstPageErrorBuilder] function.
  ///
  /// The [firstPageErrorBuilder] function is responsible for building the
  /// widget that represents the first page error indicator.
  ///
  /// The [firstPageErrorBuilder] function takes a single argument, which is a
  /// function. This function can be called to trigger the re-attempt of fetching
  /// data.
  ///
  /// The [_delegate.onFetchData] function is passed as an argument to the
  /// [firstPageErrorBuilder] function so that it can be called when the user
  /// wants to re-attempt fetching data.
  WidgetBuilder get _firstPageErrorBuilder =>
      _delegate.firstPageErrorBuilder ??
      (_) => firstPageErrorBuilder(context, _delegate.onFetchData);

  /// [_firstPageNoItemsBuilder] is a getter method that returns a builder
  /// function for the first page no items found indicator.
  ///
  /// This method retrieves the builder function from [_delegate.firstPageNoItemsBuilder].
  /// If it's null, it falls back to the [firstPageNoItemsBuilder] function.
  ///
  /// The [firstPageNoItemsBuilder] function is responsible for building the
  /// widget that represents the first page no items found indicator. It is
  /// used when there are no items to display in the first page.
  WidgetBuilder get _firstPageNoItemsBuilder =>
      _delegate.firstPageNoItemsBuilder ?? firstPageNoItemsBuilder;

  /// [_loadMoreLoadingBuilder] is a getter method that returns a builder
  /// function for the load more loading indicator.
  ///
  /// This method retrieves the builder function from [_delegate.loadMoreLoadingBuilder].
  /// If it's null, it falls back to the [loadMoreLoadingBuilder] function.
  ///
  /// The [loadMoreLoadingBuilder] function is responsible for building the
  /// widget that represents the load more loading indicator. It is
  /// used when the system is in the process of fetching more data.
  WidgetBuilder get _loadMoreLoadingBuilder =>
      _delegate.loadMoreLoadingBuilder ?? loadMoreLoadingBuilder;

  /// [_loadMoreErrorBuilder] is a getter method that returns a builder
  /// function for the load more error indicator.
  ///
  /// This method retrieves the builder function from [_delegate.loadMoreErrorBuilder].
  /// If it's null, it falls back to the [loadMoreErrorBuilder] function.
  ///
  /// The [loadMoreErrorBuilder] function is responsible for building the
  /// widget that represents the load more error indicator. It is
  /// used when there was an error while fetching more data.
  ///
  /// The [loadMoreErrorBuilder] function takes a single argument, which is a
  /// function. This function can be called to trigger the re-attempt of fetching
  /// more data.
  ///
  /// The [_delegate.onFetchData] function is passed as an argument to the
  /// [loadMoreErrorBuilder] function so that it can be called when the user
  /// wants to re-attempt fetching more data.
  WidgetBuilder get _loadMoreErrorBuilder =>
      _delegate.loadMoreErrorBuilder ??
      (_) => loadMoreErrorBuilder(context, _delegate.onFetchData);

  /// [_loadMoreNoMoreItemsBuilder] is a getter method that returns a builder
  /// function for the load more no more items indicator.
  ///
  /// This method retrieves the builder function from [_delegate.loadMoreNoMoreItemsBuilder].
  ///
  /// The [_loadMoreNoMoreItemsBuilder] is responsible for building the
  /// widget that represents the load more no more items indicator. It is
  /// used when there is no more data to fetch.
  WidgetBuilder? get _loadMoreNoMoreItemsBuilder =>
      _delegate.loadMoreNoMoreItemsBuilder;

  @override
  void onLayoutComplete() {
    _debouncer = Debouncer(_delegate.debounceDuration);
    if (_delegate.fetchDataOnStart) {
      _delegate.onFetchData();
    }
  }

  @override
  void didUpdateWidget(covariant PaginationLayoutBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!widget.delegate.hasReachedMax && oldWidget.delegate.hasReachedMax) {
      _fetchData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return switch (_delegate.paginationStatus) {
      PaginationStatus.firstPageLoading => FirstPageIndicatorWidgetBuilder(
          builder: _firstPageLoadingBuilder,
          layoutStrategy: _layoutStrategy,
          enableShrinkWrapForFirstPageIndicators:
              _enableShrinkWrapForFirstPageIndicators,
        ),
      PaginationStatus.firstPageError => FirstPageIndicatorWidgetBuilder(
          builder: _firstPageErrorBuilder,
          layoutStrategy: _layoutStrategy,
          enableShrinkWrapForFirstPageIndicators:
              _enableShrinkWrapForFirstPageIndicators,
        ),
      PaginationStatus.firstPageNoItemsFound => FirstPageIndicatorWidgetBuilder(
          builder: _firstPageNoItemsBuilder,
          layoutStrategy: _layoutStrategy,
          enableShrinkWrapForFirstPageIndicators:
              _enableShrinkWrapForFirstPageIndicators,
        ),
      PaginationStatus.loadMoreReachedLastPage => widget.layoutChildBuilder(
          context,
          _buildItemBuilder,
          _delegate.itemCount,
          _loadMoreNoMoreItemsBuilder,
        ),
      PaginationStatus.loadMoreLoading => widget.layoutChildBuilder(
          context,
          _buildItemBuilder,
          _delegate.itemCount,
          _loadMoreLoadingBuilder,
        ),
      PaginationStatus.loadMoreError => widget.layoutChildBuilder(
          context,
          _buildItemBuilder,
          _delegate.itemCount,
          _loadMoreErrorBuilder,
        ),
    };
  }

  /// Builds an item at the specified index.
  ///
  /// If the [index] is equal to [_delegate.fetchAtIndex], it invokes [_onBuiltLastItem].
  ///
  /// Parameters:
  ///   - [context]: The build context.
  ///   - [index]: The index of the item to build.
  /// Returns a widget.
  Widget _buildItemBuilder(BuildContext context, int index) {
    // Check if the current index is equal to the index to fetch.
    // If it is, invoke [_onBuiltLastItem].
    if (index == _delegate.fetchAtIndex) {
      _onBuiltLastItem(_delegate.fetchAtIndex);
    }

    // Build the item using the delegate's item builder.
    return _delegate.itemBuilder(context, index);
  }

  /// Called when the last item has been built.
  ///
  /// If the [lastItemIndex] is different from the previous [lastItemIndex],
  /// it fetches data.
  ///
  /// Parameters:
  ///   - [lastItemIndex]: The index of the last item that was built.
  void _onBuiltLastItem(int lastItemIndex) {
    // If the last item index is different from the previous one,
    // it fetches data.
    if (_lastItemIndex != lastItemIndex) {
      // Updates the last item index.
      _lastItemIndex = lastItemIndex;
      // Fetches data.
      _fetchData();
    }
  }

  /// Fetches data if the conditions are met.
  ///
  /// The conditions are:
  ///  - The data source has not reached its max.
  ///  - The data source is not currently loading.
  ///  - The data source does not have an error.
  ///
  /// If all the conditions are met, it invokes the [_delegate.onFetchData]
  /// callback after the next frame.
  void _fetchData() {
    // Checks if the conditions are met.
    if (_delegate.notReachedMax && _delegate.notLoading && _delegate.notError) {
      // Invokes the [_delegate.onFetchData] callback after the next frame.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _debouncer.run(_delegate.onFetchData);
      });
    }
  }

  @override
  void dispose() {
    /// Disposes the debouncer.
    ///
    /// This is called when the state is disposed, and it ensures that
    /// the debouncer is also disposed, to prevent memory leaks.
    /// It is important to dispose the debouncer, as it holds a timer
    /// that needs to be cancelled when the state is disposed.
    _debouncer.dispose();
    super.dispose();
  }
}
