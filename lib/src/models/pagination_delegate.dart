import 'dart:developer';

import 'package:flutter/material.dart'
    show IndexedWidgetBuilder, WidgetBuilder, VoidCallback;

import '../utils/utils.dart';
import 'pagination_status.dart';

final class PaginationDelegate {
  /// A class that represents a pagination delegate for building paginated layouts.
  ///
  /// It contains all the necessary information for a paginated layout, such as
  /// the item count, item builder, loading indicator builder, error indicator
  /// builder, no more items indicator builder, loading state, error state,
  /// and more.
  PaginationDelegate({
    required this.itemCount,
    required this.itemBuilder,
    this.loadMoreLoadingBuilder,
    this.loadMoreErrorBuilder,
    this.loadMoreNoMoreItemsBuilder,
    this.firstPageLoadingBuilder,
    this.firstPageErrorBuilder,
    this.firstPageNoItemsBuilder,
    this.isLoading = false,
    this.hasError = false,
    this.hasReachedMax = false,
    required this.onFetchData,
    this.debounceDuration = defaultDebounceDuration,
    this.invisibleItemsThreshold = defaultInvisibleItemsThreshold,
    this.fetchDataOnStart = true,
  });

  /// The total number of items in the paginated layout.
  final int itemCount;

  /// A builder function that builds an item widget at the given index.
  final IndexedWidgetBuilder itemBuilder;

  /// A builder function that builds a loading indicator widget.
  final WidgetBuilder? loadMoreLoadingBuilder;

  /// A builder function that builds an error indicator widget.
  final WidgetBuilder? loadMoreErrorBuilder;

  /// A builder function that builds a no more items indicator widget.
  final WidgetBuilder? loadMoreNoMoreItemsBuilder;

  /// A builder function that builds a loading indicator widget for the first page.
  final WidgetBuilder? firstPageLoadingBuilder;

  /// A builder function that builds an error indicator widget for the first page.
  final WidgetBuilder? firstPageErrorBuilder;

  /// A builder function that builds a no items found indicator widget for the first page.
  final WidgetBuilder? firstPageNoItemsBuilder;

  /// Indicates whether the paginated layout is in a loading state.
  final bool isLoading;

  /// Indicates whether the paginated layout has encountered an error.
  final bool hasError;

  /// Indicates whether the paginated layout has reached the maximum page.
  final bool hasReachedMax;

  /// A callback function that is called when data needs to be fetched.
  final VoidCallback onFetchData;

  /// The duration for debouncing the fetch data call.
  final Duration debounceDuration;

  /// The threshold for the number of invisible items to trigger fetching more data.
  final int invisibleItemsThreshold;

  /// Indicates whether data should be fetched when the paginated layout is created.
  final bool fetchDataOnStart;

  @override
  String toString() {
    return 'PaginationDelegate(itemCount: $itemCount, itemBuilder: $itemBuilder, loadMoreLoadingBuilder: $loadMoreLoadingBuilder, loadMoreErrorBuilder: $loadMoreErrorBuilder, loadMoreNoMoreItemsBuilder: $loadMoreNoMoreItemsBuilder, firstPageLoadingBuilder: $firstPageLoadingBuilder, firstPageErrorBuilder: $firstPageErrorBuilder, firstPageNoItemsBuilder: $firstPageNoItemsBuilder, isLoading: $isLoading, hasError: $hasError, hasReachedMax: $hasReachedMax, onFetchData: $onFetchData, debounceDuration: $debounceDuration, invisibleItemsThreshold: $invisibleItemsThreshold, fetchDataOnStart: $fetchDataOnStart)';
  }

  /// Returns whether the pagination delegate has not reached the maximum page.
  bool get notReachedMax => !hasReachedMax;

  /// Returns whether the pagination delegate is not in a loading state.

  bool get notLoading => !isLoading;

  /// Returns whether the pagination delegate has not encountered an error.
  bool get notError => !hasError;

  /// Returns whether the pagination delegate is not in a loading state.
  bool get _notLoading => !isLoading;

  /// Returns whether the pagination delegate has any items.
  bool get _hasItems => itemCount != 0;

  /// Returns whether the pagination delegate has no items.
  bool get _hasNoItems => !_hasItems;

  /// Returns whether the pagination delegate should show a bottom empty indicator.
  ///
  /// This is based on the following conditions:
  /// - The pagination delegate is not in a loading state.
  /// - The pagination delegate has no items.
  /// - The pagination delegate has a bottom empty indicator builder.
  bool get _shouldShowBottomEmpty =>
      _notLoading && _hasNoItems && loadMoreNoMoreItemsBuilder != null;

  /// Returns whether the pagination delegate should show a bottom loader widget.
  ///
  /// This is based on the following conditions:
  /// - The pagination delegate should show a bottom empty indicator or...
  /// - The pagination delegate is in a loading state.
  /// - The pagination delegate has encountered an error.
  bool get _shouldShowBottomLoader =>
      _shouldShowBottomEmpty || isLoading || hasError;

  /// Returns the effective count of items for the pagination delegate.
  ///
  /// This is based on the following rules:
  /// - If the pagination delegate has items, return the count of items.
  /// - If the pagination delegate has no items, return 0.
  /// - If the pagination delegate should show a bottom loader, add 1 to the count.
  int get effectiveItemCount =>
      (_hasNoItems ? 0 : itemCount) + (_shouldShowBottomLoader ? 1 : 0);

  /// Returns the index of the last item in the pagination delegate's items.
  ///
  /// This is the effective count of items minus 1.
  int get lastItemIndex => effectiveItemCount - 1;

  /// Returns the index at which data should be fetched.
  ///
  /// This is the index of the last item minus the invisible items threshold.
  int get fetchAtIndex => lastItemIndex - invisibleItemsThreshold;

  /// Returns the current status of the pagination delegate.
  ///
  /// The status can be one of the following:
  /// - [PaginationStatus.firstPageLoading] if the delegate is in the process of loading the first page.
  /// - [PaginationStatus.firstPageError] if the delegate has encountered an error while loading the first page.
  /// - [PaginationStatus.firstPageNoItemsFound] if the delegate has not found any items while loading the first page.
  /// - [PaginationStatus.loadMoreLoading] if the delegate is in the process of loading more items.
  /// - [PaginationStatus.loadMoreError] if the delegate has encountered an error while loading more items.
  /// - [PaginationStatus.loadMoreReachedLastPage] if the delegate has reached the maximum page.
  ///
  /// The status is determined based on the values of [isLoading], [hasError], [hasReachedMax] and [effectiveItemCount].
  PaginationStatus get paginationStatus {
    // If the delegate is loading the first page and there is only one item
    if (isLoading && effectiveItemCount == 1) {
      return PaginationStatus.firstPageLoading;
    }
    // If the delegate has encountered an error while loading the first page and there is only one item
    else if (hasError && effectiveItemCount == 1) {
      return PaginationStatus.firstPageError;
    }

    // If the delegate has not found any items while loading the first page.
    else if (_hasNoItems) {
      return PaginationStatus.firstPageNoItemsFound;
    }
    // If the delegate is in the process of loading more items
    else if (isLoading) {
      return PaginationStatus.loadMoreLoading;
    }
    // If the delegate has encountered an error while loading more items
    else if (hasError) {
      return PaginationStatus.loadMoreError;
    }
    // If the delegate has reached the maximum page
    else if (hasReachedMax) {
      return PaginationStatus.loadMoreReachedLastPage;
    }
    // If none of the above conditions are met, default to [PaginationStatus.loadMoreLoading]
    return PaginationStatus.loadMoreLoading;
  }

  @override
  bool operator ==(covariant PaginationDelegate other) {
    if (identical(this, other)) return true;

    return other.itemCount == itemCount &&
        other.itemBuilder == itemBuilder &&
        other.loadMoreLoadingBuilder == loadMoreLoadingBuilder &&
        other.loadMoreErrorBuilder == loadMoreErrorBuilder &&
        other.loadMoreNoMoreItemsBuilder == loadMoreNoMoreItemsBuilder &&
        other.firstPageLoadingBuilder == firstPageLoadingBuilder &&
        other.firstPageErrorBuilder == firstPageErrorBuilder &&
        other.firstPageNoItemsBuilder == firstPageNoItemsBuilder &&
        other.isLoading == isLoading &&
        other.hasError == hasError &&
        other.hasReachedMax == hasReachedMax &&
        other.onFetchData == onFetchData &&
        other.debounceDuration == debounceDuration &&
        other.invisibleItemsThreshold == invisibleItemsThreshold &&
        other.fetchDataOnStart == fetchDataOnStart;
  }

  @override
  int get hashCode {
    return itemCount.hashCode ^
        itemBuilder.hashCode ^
        loadMoreLoadingBuilder.hashCode ^
        loadMoreErrorBuilder.hashCode ^
        loadMoreNoMoreItemsBuilder.hashCode ^
        firstPageLoadingBuilder.hashCode ^
        firstPageErrorBuilder.hashCode ^
        firstPageNoItemsBuilder.hashCode ^
        isLoading.hashCode ^
        hasError.hashCode ^
        hasReachedMax.hashCode ^
        onFetchData.hashCode ^
        debounceDuration.hashCode ^
        invisibleItemsThreshold.hashCode ^
        fetchDataOnStart.hashCode;
  }
}
