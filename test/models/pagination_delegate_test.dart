import 'package:easy_infinite_pagination/src/models/models.dart';
import 'package:easy_infinite_pagination/src/utils/utils.dart';
import 'package:flutter/material.dart' show Container;
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'PaginationDelegate Tests',
    () {
      test(
        'creates a PaginationDelegate with default values',
        () {
          // Arrange
          final delegate = PaginationDelegate(
            itemCount: 0,
            itemBuilder: (context, index) => Container(),
            onFetchData: () {},
          );

          // Assert
          expect(delegate.itemCount, equals(0));
          expect(delegate.itemBuilder, isNotNull);
          expect(delegate.loadMoreLoadingBuilder, isNull);
          expect(delegate.loadMoreErrorBuilder, isNull);
          expect(delegate.loadMoreNoMoreItemsBuilder, isNull);
          expect(delegate.firstPageLoadingBuilder, isNull);
          expect(delegate.firstPageErrorBuilder, isNull);
          expect(delegate.firstPageNoItemsBuilder, isNull);
          expect(delegate.isLoading, isFalse);
          expect(delegate.hasError, isFalse);
          expect(delegate.hasReachedMax, isFalse);
          expect(delegate.onFetchData, isNotNull);
          expect(delegate.debounceDuration, equals(defaultDebounceDuration));
          expect(delegate.invisibleItemsThreshold,
              equals(defaultInvisibleItemsThreshold));
          expect(delegate.fetchDataOnStart, isTrue);
        },
      );

      test('creates a PaginationDelegate with custom values', () {
        // Arrange
        final delegate = PaginationDelegate(
          itemCount: 10,
          itemBuilder: (context, index) => Container(),
          loadMoreLoadingBuilder: (context) => Container(),
          loadMoreErrorBuilder: (context) => Container(),
          loadMoreNoMoreItemsBuilder: (context) => Container(),
          firstPageLoadingBuilder: (context) => Container(),
          firstPageErrorBuilder: (context) => Container(),
          firstPageNoItemsBuilder: (context) => Container(),
          isLoading: true,
          hasError: true,
          hasReachedMax: true,
          onFetchData: () {},
          debounceDuration: const Duration(seconds: 1),
          invisibleItemsThreshold: 5,
          fetchDataOnStart: false,
        );

        // Assert
        expect(delegate.itemCount, equals(10));
        expect(delegate.itemBuilder, isNotNull);
        expect(delegate.loadMoreLoadingBuilder, isNotNull);
        expect(delegate.loadMoreErrorBuilder, isNotNull);
        expect(delegate.loadMoreNoMoreItemsBuilder, isNotNull);
        expect(delegate.firstPageLoadingBuilder, isNotNull);
        expect(delegate.firstPageErrorBuilder, isNotNull);
        expect(delegate.firstPageNoItemsBuilder, isNotNull);
        expect(delegate.isLoading, isTrue);
        expect(delegate.hasError, isTrue);
        expect(delegate.hasReachedMax, isTrue);
        expect(delegate.onFetchData, isNotNull);
        expect(delegate.debounceDuration, equals(const Duration(seconds: 1)));
        expect(delegate.invisibleItemsThreshold, equals(5));
        expect(delegate.fetchDataOnStart, isFalse);
      });

      test('returns notReachedMax when hasReachedMax is false', () {
        // Arrange
        final delegate = PaginationDelegate(
          itemCount: 0,
          itemBuilder: (context, index) => Container(),
          onFetchData: () {},
          hasReachedMax: false,
        );

        // Act
        final result = delegate.notReachedMax;

        // Assert
        expect(result, isTrue);
      });

      test('returns notLoading when isLoading is false', () {
        // Arrange
        final delegate = PaginationDelegate(
          itemCount: 0,
          itemBuilder: (context, index) => Container(),
          onFetchData: () {},
          isLoading: false,
        );

        // Act
        final result = delegate.notLoading;

        // Assert
        expect(result, isTrue);
      });

      test('returns notError when hasError is false', () {
        // Arrange
        final delegate = PaginationDelegate(
          itemCount: 0,
          itemBuilder: (context, index) => Container(),
          onFetchData: () {},
          hasError: false,
        );

        // Act
        final result = delegate.notError;

        // Assert
        expect(result, isTrue);
      });

      test('returns effectiveItemCount when hasItems or shouldShowBottomLoader',
          () {
        // Arrange
        final delegate = PaginationDelegate(
          itemCount: 10,
          itemBuilder: (context, index) => Container(),
          onFetchData: () {},
          isLoading: true,
        );

        // Act
        final result = delegate.effectiveItemCount;

        // Assert
        expect(result, equals(11));
      });

      test('returns lastItem when effectiveItemCount minus 1', () {
        // Arrange
        final delegate = PaginationDelegate(
          itemCount: 10,
          itemBuilder: (context, index) => Container(),
          onFetchData: () {},
          isLoading: true,
        );

        // Act
        final result = delegate.lastItem;

        // Assert
        expect(result, equals(10));
      });

      test('returns fetchAtIndex when lastItem minus invisibleItemsThreshold',
          () {
        // Arrange
        final delegate = PaginationDelegate(
          itemCount: 10,
          itemBuilder: (context, index) => Container(),
          onFetchData: () {},
          isLoading: true,
          invisibleItemsThreshold: 5,
        );

        // Act
        final result = delegate.fetchAtIndex;

        // Assert
        expect(result, equals(5));
      });

      test(
          'returns firstPageLoading when isLoading and effectiveItemCount is 1',
          () {
        // Arrange
        final delegate = PaginationDelegate(
          itemCount: 0,
          itemBuilder: (context, index) => Container(),
          onFetchData: () {},
          isLoading: true,
        );

        // Act
        final result = delegate.paginationStatus;

        // Assert
        expect(result, equals(PaginationStatus.firstPageLoading));
      });

      test('returns firstPageError when hasError and effectiveItemCount is 1',
          () {
        // Arrange
        final delegate = PaginationDelegate(
          itemCount: 0,
          itemBuilder: (context, index) => Container(),
          onFetchData: () {},
          hasError: true,
        );

        // Act
        final result = delegate.paginationStatus;

        // Assert
        expect(result, equals(PaginationStatus.firstPageError));
      });

      test('returns firstPageNoItemsFound when hasNoItems', () {
        // Arrange
        final delegate = PaginationDelegate(
          itemCount: 0,
          itemBuilder: (context, index) => Container(),
          onFetchData: () {},
        );

        // Act
        final result = delegate.paginationStatus;

        // Assert
        expect(result, equals(PaginationStatus.firstPageNoItemsFound));
      });
      test(
          'returns firstPageNoItemsFound when hasNoItems amd hasReachedMax is true',
          () {
        // Arrange
        final delegate = PaginationDelegate(
          itemCount: 0,
          hasReachedMax: true,
          itemBuilder: (context, index) => Container(),
          onFetchData: () {},
        );

        // Act
        final result = delegate.paginationStatus;

        // Assert
        expect(result, equals(PaginationStatus.firstPageNoItemsFound));
      });

      test('returns loadMoreLoading when isLoading and hasItems', () {
        // Arrange
        final delegate = PaginationDelegate(
          itemCount: 10,
          itemBuilder: (context, index) => Container(),
          onFetchData: () {},
          isLoading: true,
        );

        // Act
        final result = delegate.paginationStatus;

        // Assert
        expect(result, equals(PaginationStatus.loadMoreLoading));
      });

      test('returns loadMoreError when hasError and hasItems', () {
        // Arrange
        final delegate = PaginationDelegate(
          itemCount: 10,
          itemBuilder: (context, index) => Container(),
          onFetchData: () {},
          hasError: true,
        );

        // Act
        final result = delegate.paginationStatus;

        // Assert
        expect(result, equals(PaginationStatus.loadMoreError));
      });

      test('returns loadMoreReachedLastPage when hasReachedMax and hasItems',
          () {
        // Arrange
        final delegate = PaginationDelegate(
          itemCount: 10,
          itemBuilder: (context, index) => Container(),
          onFetchData: () {},
          hasReachedMax: true,
        );

        // Act
        final result = delegate.paginationStatus;

        // Assert
        expect(result, equals(PaginationStatus.loadMoreReachedLastPage));
      });
    },
  );
}
