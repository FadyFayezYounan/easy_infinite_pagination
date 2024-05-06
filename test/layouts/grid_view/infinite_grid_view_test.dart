import 'package:easy_infinite_pagination/easy_infinite_pagination.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late SliverGridDelegateWithFixedCrossAxisCount gridDelegate;

  setUpAll(() {
    gridDelegate = const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
    );
  });

  group(
    'InfiniteGridView - ',
    () {
      testWidgets(
        'renders correctly',
        (tester) async {
          // Arrange
          final delegate = PaginationDelegate(
            itemCount: 10,
            itemBuilder: (context, index) => Text(
              'Item $index',
              key: ValueKey(index),
            ),
            onFetchData: () {},
          );

          // Act
          await tester.pumpAppWithFixedHeight(
            InfiniteGridView(
              delegate: delegate,
              gridDelegate: gridDelegate,
            ),
          );

          // Assert
          expect(find.text('Item 0'), findsOneWidget);
          expect(find.text('Item 9'), findsNothing);

          await tester.scrollUntilVisible(
            find.byKey(const ValueKey(9)),
            100.0,
          );

          expect(find.text('Item 9'), findsOneWidget);
        },
      );
      testWidgets(
        'calls onFetchData in the initState and  when scrolled to the end',
        (tester) async {
          // Arrange
          var onFetchDataCalledCount = 0;
          final delegate = PaginationDelegate(
            itemCount: 10,
            invisibleItemsThreshold: 1,
            itemBuilder: (context, index) => Text(
              'Item $index',
              key: ValueKey(index),
            ),
            onFetchData: () {
              onFetchDataCalledCount++;
            },
          );

          // Act
          await tester.pumpAppWithFixedHeight(
            InfiniteGridView(
              delegate: delegate,
              gridDelegate: gridDelegate,
            ),
          );

          // Assert
          // the first call should in the initState
          expect(onFetchDataCalledCount, equals(1));
          await tester.scrollUntilVisible(
            find.byKey(const ValueKey(9)),
            100.0,
          );
          // the second call should in the pagination
          expect(onFetchDataCalledCount, equals(2));
        },
      );
      testWidgets(
        'calls onFetchData when scrolled to the invisibleItemsThreshold value',
        (tester) async {
          // Arrange
          const itemCount = 20;
          const invisibleItemsThreshold = 5;
          const shouldFetchAtIndex = (itemCount - invisibleItemsThreshold) - 1;
          var onFetchDataCalledCount = 0;
          final delegate = PaginationDelegate(
            itemCount: itemCount,
            invisibleItemsThreshold: invisibleItemsThreshold,
            itemBuilder: (context, index) => Text(
              'Item $index',
              key: ValueKey(index),
            ),
            onFetchData: () {
              onFetchDataCalledCount++;
            },
          );

          // Act
          await tester.pumpAppWithFixedHeight(
            InfiniteGridView(
              delegate: delegate,
              gridDelegate: gridDelegate,
            ),
          );

          // Assert
          // the first call should in the initState
          expect(onFetchDataCalledCount, equals(1));

          await tester.scrollUntilVisible(
            find.byKey(const ValueKey(shouldFetchAtIndex)),
            100.0,
          );
          // the second call should in the pagination
          expect(onFetchDataCalledCount, equals(2));
        },
      );

      testWidgets(
        'calls onFetchData immediately if the first page is not enough',
        (tester) async {
          // Arrange
          var onFetchDataCalledCount = 0;
          final delegate = PaginationDelegate(
            itemCount: 2,
            invisibleItemsThreshold: 1,
            isLoading: true,
            itemBuilder: (context, index) => Text(
              'Item $index',
              key: ValueKey(index),
            ),
            onFetchData: () {
              onFetchDataCalledCount++;
            },
          );

          // Act
          await tester.pumpAppWithFixedHeight(
            InfiniteListView(delegate: delegate),
          );

          // Assert
          expect(onFetchDataCalledCount, equals(1));
        },
      );
    },
  );
}

extension on WidgetTester {
  Future<void> pumpAppWithFixedHeight(Widget child) {
    return pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: AppBar(),
          body: SizedBox(
            height: 500,
            child: child,
          ),
        ),
      ),
    );
  }
}
