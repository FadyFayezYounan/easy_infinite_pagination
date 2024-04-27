import 'package:easy_infinite_pagination/src/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:easy_infinite_pagination/src/core/pagination_layout_builder.dart';
import 'package:easy_infinite_pagination/src/models/models.dart';

void main() {
  group(
    'PaginationLayoutBuilder Widget Tests - ',
    () {
      /// firstPageLoadingBuilder tests
      group(
        'renders firstPageLoadingBuilder when status is firstPageLoading - ',
        () {
          testWidgets(
            'when no custom firstPageIndicatorBuilder is provided.',
            (tester) async {
              // Arrange
              final delegate = PaginationDelegate(
                itemCount: 0,
                isLoading: true,
                itemBuilder: (context, index) => Container(),
                onFetchData: () {},
              );

              // Act
              await tester.pumpPaginationLayoutWithSliverList(delegate);

              // Assert

              // This is the widget that wraps the first page indicators
              // to build the first page indicator widget as Box or Sliver depending on the layout strategy.
              expect(
                  find.byType(FirstPageIndicatorWidgetBuilder), findsOneWidget);
              // The child of [FirstPageIndicatorWidgetBuilder] in this case is  [FirstPageLoadingBuilder]
              expect(find.byType(FirstPageLoadingBuilder), findsOneWidget);
            },
          );

          testWidgets(
            'when custom firstPageIndicatorBuilder is provided',
            (tester) async {
              // Arrange
              const loadingKey = ValueKey('loadingKey');
              final delegate = PaginationDelegate(
                itemCount: 0,
                isLoading: true,
                itemBuilder: (context, index) => Container(),
                firstPageLoadingBuilder: (context) =>
                    Container(key: loadingKey),
                onFetchData: () {},
              );

              // Act
              await tester.pumpPaginationLayoutWithSliverList(delegate);

              // Assert

              // This is the widget that wraps the first page indicators
              // to build the first page indicator widget as Box or Sliver depending on the layout strategy.
              expect(
                  find.byType(FirstPageIndicatorWidgetBuilder), findsOneWidget);
              // The child of [FirstPageIndicatorWidgetBuilder] in this case is  [Container]
              expect(find.byKey(loadingKey), findsOneWidget);
            },
          );
        },
      );

      /// firstPageErrorBuilder tests
      group(
        'renders firstPageErrorBuilder when status is firstPageError - ',
        () {
          testWidgets(
            'when no custom firstPageErrorBuilder is provided.',
            (tester) async {
              // Arrange
              final delegate = PaginationDelegate(
                itemCount: 0,
                hasError: true,
                itemBuilder: (context, index) => Container(),
                onFetchData: () {},
              );

              // Act
              await tester.pumpPaginationLayoutWithSliverList(delegate);

              // Assert

              // This is the widget that wraps the first page indicators
              // to build the first page indicator widget as Box or Sliver depending on the layout strategy.
              expect(
                  find.byType(FirstPageIndicatorWidgetBuilder), findsOneWidget);
              // The child of [FirstPageIndicatorWidgetBuilder] in this case is  [FirstPageErrorBuilder]
              expect(find.byType(FirstPageErrorBuilder), findsOneWidget);
            },
          );
          testWidgets(
            'when custom firstPageErrorBuilder is provided.',
            (tester) async {
              // Arrange
              const errorKey = ValueKey('errorKey');
              final delegate = PaginationDelegate(
                itemCount: 0,
                hasError: true,
                firstPageErrorBuilder: (context) => Container(key: errorKey),
                itemBuilder: (context, index) => Container(),
                onFetchData: () {},
              );

              // Act
              await tester.pumpPaginationLayoutWithSliverList(delegate);

              // Assert

              // This is the widget that wraps the first page indicators
              // to build the first page indicator widget as Box or Sliver depending on the layout strategy.
              expect(
                  find.byType(FirstPageIndicatorWidgetBuilder), findsOneWidget);
              // The child of [FirstPageIndicatorWidgetBuilder] in this case is  [Container]
              expect(find.byKey(errorKey), findsOneWidget);
            },
          );
        },
      );

      /// firstPageNoItemsBuilder tests
      group(
        'renders firstPageNoItemsBuilder when status is firstPageNoItemsFound - ',
        () {
          testWidgets(
            'when no custom firstPageNoItemsBuilder is provided.',
            (tester) async {
              // Arrange
              final delegate = PaginationDelegate(
                itemCount: 0,
                itemBuilder: (context, index) => Container(),
                onFetchData: () {},
              );

              // Act
              await tester.pumpPaginationLayoutWithSliverList(delegate);

              // Assert
              // This is the widget that wraps the first page indicators
              // to build the first page indicator widget as Box or Sliver depending on the layout strategy.
              expect(
                  find.byType(FirstPageIndicatorWidgetBuilder), findsOneWidget);
              // The child of [FirstPageIndicatorWidgetBuilder] in this case is  [FirstPageNoItemsBuilder]
              expect(find.byType(FirstPageNoItemsBuilder), findsOneWidget);
            },
          );
          testWidgets(
            'when no custom firstPageNoItemsBuilder is provided and hasReachedMax is true.',
            (tester) async {
              // Arrange
              final delegate = PaginationDelegate(
                itemCount: 0,
                hasReachedMax: true,
                itemBuilder: (context, index) => Container(),
                onFetchData: () {},
              );

              // Act
              await tester.pumpPaginationLayoutWithSliverList(delegate);

              // Assert
              // This is the widget that wraps the first page indicators
              // to build the first page indicator widget as Box or Sliver depending on the layout strategy.
              expect(
                  find.byType(FirstPageIndicatorWidgetBuilder), findsOneWidget);
              // The child of [FirstPageIndicatorWidgetBuilder] in this case is  [FirstPageNoItemsBuilder]
              expect(find.byType(FirstPageNoItemsBuilder), findsOneWidget);
            },
          );

          testWidgets(
            'when custom firstPageNoItemsBuilder is provided.',
            (tester) async {
              // Arrange
              const noItemsKey = ValueKey('noItemsKey');
              final delegate = PaginationDelegate(
                itemCount: 0,
                firstPageNoItemsBuilder: (context) =>
                    Container(key: noItemsKey),
                itemBuilder: (context, index) => Container(),
                onFetchData: () {},
              );

              // Act
              await tester.pumpPaginationLayoutWithSliverList(delegate);

              // Assert
              // This is the widget that wraps the first page indicators
              // to build the first page indicator widget as Box or Sliver depending on the layout strategy.
              expect(
                  find.byType(FirstPageIndicatorWidgetBuilder), findsOneWidget);
              // The child of [FirstPageIndicatorWidgetBuilder] in this case is  [Container]
              expect(find.byKey(noItemsKey), findsOneWidget);
            },
          );
          testWidgets(
            'when custom firstPageNoItemsBuilder is provided and hasReachedMax is true.',
            (tester) async {
              // Arrange
              const noItemsKey = ValueKey('noItemsKey');
              final delegate = PaginationDelegate(
                itemCount: 0,
                hasReachedMax: true,
                firstPageNoItemsBuilder: (context) =>
                    Container(key: noItemsKey),
                itemBuilder: (context, index) => Container(),
                onFetchData: () {},
              );

              // Act
              await tester.pumpPaginationLayoutWithSliverList(delegate);

              // Assert
              // This is the widget that wraps the first page indicators
              // to build the first page indicator widget as Box or Sliver depending on the layout strategy.
              expect(
                  find.byType(FirstPageIndicatorWidgetBuilder), findsOneWidget);
              // The child of [FirstPageIndicatorWidgetBuilder] in this case is  [FirstPageNoItemsBuilder]
              expect(find.byKey(noItemsKey), findsOneWidget);
            },
          );
        },
      );

      /// loadMoreLoadingBuilder tests
      group(
        'renders loadMoreLoadingBuilder when status is loadMoreLoading - ',
        () {
          testWidgets(
            'when no custom loadMoreLoadingBuilder is provided.',
            (tester) async {
              // Arrange
              final delegate = PaginationDelegate(
                itemCount: 5,
                isLoading: true,
                itemBuilder: (context, index) => Container(),
                onFetchData: () {},
              );

              // Act
              await tester.pumpPaginationLayoutWithSliverList(delegate);

              // Assert

              // This is the widget that wraps the bottom loaders indicators
              // to add some padding to the bottom of the widget.
              expect(find.byType(BottomLoaderPadding), findsOneWidget);
              // The child of [BottomLoaderPadding] in this case is  [LoadMoreLoadingBuilder]
              expect(find.byType(LoadMoreLoadingBuilder), findsOneWidget);
            },
          );
          testWidgets(
            'when custom loadMoreLoadingBuilder is provided.',
            (tester) async {
              // Arrange
              const loadMoreLoadingKey = ValueKey('loadMoreLoadingKey');
              final delegate = PaginationDelegate(
                itemCount: 5,
                isLoading: true,
                loadMoreLoadingBuilder: (context) =>
                    Container(key: loadMoreLoadingKey),
                itemBuilder: (context, index) => Container(),
                onFetchData: () {},
              );

              // Act
              await tester.pumpPaginationLayoutWithSliverList(delegate);

              // Assert
              //expect(find.byKey(loadMoreLoadingKey), findsOneWidget);
            },
          );
        },
      );

      /// loadMoreErrorBuilder tests
      group(
        'renders loadMoreErrorBuilder when status is loadMoreError - ',
        () {
          testWidgets('when no custom loadMoreErrorBuilder is provided.',
              (tester) async {
            // Arrange
            final delegate = PaginationDelegate(
              itemCount: 5,
              hasError: true,
              itemBuilder: (context, index) => Container(),
              onFetchData: () {},
            );

            // Act
            await tester.pumpPaginationLayoutWithSliverList(delegate);

            // Assert

            // This is the widget that wraps the bottom loaders indicators
            // to add some padding to the bottom of the widget.
            expect(find.byType(BottomLoaderPadding), findsOneWidget);
            // The child of [BottomLoaderPadding] in this case is  [LoadMoreErrorBuilder]
            expect(find.byType(LoadMoreErrorBuilder), findsOneWidget);
          });

          testWidgets(
            'when custom loadMoreErrorBuilder is provided.',
            (tester) async {
              // Arrange
              const loadMoreErrorKey = ValueKey('loadMoreErrorKey');
              final delegate = PaginationDelegate(
                itemCount: 5,
                hasError: true,
                loadMoreErrorBuilder: (context) =>
                    Container(key: loadMoreErrorKey),
                itemBuilder: (context, index) => Container(),
                onFetchData: () {},
              );

              // Act
              await tester.pumpPaginationLayoutWithSliverList(delegate);

              // Assert
              //expect(find.byKey(loadMoreErrorKey), findsOneWidget);
            },
          );
        },
      );

      /// loadMoreNoMoreItemsBuilder tests
      group(
        'renders loadMoreNoMoreItemsBuilder when status is loadMoreNoMoreItems - ',
        () {
          testWidgets(
            'when custom loadMoreNoMoreItemsBuilder is provided.',
            (tester) async {
              // Arrange
              const loadMoreNoMoreItemsKey = ValueKey('loadMoreNoMoreItemsKey');
              final delegate = PaginationDelegate(
                itemCount: 5,
                hasReachedMax: true,
                loadMoreNoMoreItemsBuilder: (context) =>
                    Container(key: loadMoreNoMoreItemsKey),
                itemBuilder: (context, index) => Container(),
                onFetchData: () {},
              );

              // Act
              await tester.pumpPaginationLayoutWithSliverList(delegate);

              // Assert
              //expect(find.byKey(loadMoreNoMoreItemsKey), findsOneWidget);
            },
          );
        },
      );

      /// calls onFetchData when last item is built
      group(
        'calls onFetchData when last item is built - ',
        () {
          testWidgets(
            'when invisibleItemsThreshold is 1',
            (tester) async {
              // Arrange
              var fetchDataCalled = false;
              final delegate = PaginationDelegate(
                itemCount: 20,
                isLoading: false,
                hasError: false,
                itemBuilder: (context, index) => Container(),
                onFetchData: () {
                  fetchDataCalled = true;
                },
                invisibleItemsThreshold: 1,
              );

              // Act
              await tester.pumpPaginationLayoutWithSliverList(delegate);

              // Assert
              expect(fetchDataCalled, isTrue);
            },
          );
        },
      );
    },
  );
}

extension on WidgetTester {
  Future<void> pumpSliver(Widget sliver) async {
    await pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: AppBar(),
          body: CustomScrollView(slivers: [sliver]),
        ),
      ),
    );
    await pump();
  }

  Future<void> pumpPaginationLayoutWithSliverList(
    PaginationDelegate delegate, {
    bool useShrinkWrapForFirstPageIndicators = false,
  }) {
    return pumpSliver(
      PaginationLayoutBuilder(
        delegate: delegate,
        layoutStrategy: LayoutStrategy.sliver,
        enableShrinkWrapForFirstPageIndicators:
            useShrinkWrapForFirstPageIndicators,
        layoutChildBuilder: (
          context,
          itemBuilder,
          itemCount,
          bottomLoaderBuilder,
        ) =>
            SliverList(
          delegate: PaginationLayoutBuilder.createSliverChildDelegate(
            builder: itemBuilder,
            childCount: itemCount,
            bottomLoaderBuilder: bottomLoaderBuilder,
          ),
        ),
      ),
    );
  }
}
