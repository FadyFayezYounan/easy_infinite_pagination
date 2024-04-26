import 'package:easy_infinite_pagination/easy_infinite_pagination.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

const _itemCount = 10;
void main() {
  group('InfinitePageView - ', () {
    testWidgets('renders correctly', (tester) async {
      // Arrange
      final delegate = PaginationDelegate(
        itemBuilder: (context, index) => Text('Item $index'),
        itemCount: _itemCount,
        onFetchData: () {},
      );
      // Act
      await tester.pumpApp(
        InfinitePageView(delegate: delegate),
      );
      // Assert
      expect(find.byType(InfinitePageView), findsOneWidget);
    });
  });
  testWidgets('renders the correct number of children', (tester) async {
    const lastItemKey = ValueKey(9);
    var childrenCount = 0;
    // Arrange
    final delegate = PaginationDelegate(
      itemBuilder: (context, index) {
        childrenCount++;
        return Container(
          key: ValueKey(index),
        );
      },
      itemCount: _itemCount,
      onFetchData: () {},
    );
    // Act
    await tester.pumpApp(
      InfinitePageView(delegate: delegate),
    );
    await tester.scrollUntilVisible(
      find.byKey(lastItemKey),
      250,
    );

    // Assert
    expect(childrenCount, equals(_itemCount));
    expect(find.byKey(lastItemKey), findsOneWidget);
  });

  testWidgets(
    'calls onFetchData in the initState',
    (tester) async {
      // Arrange
      var onFetchDataCalledCount = 0;
      final delegate = PaginationDelegate(
        itemCount: _itemCount,
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
      await tester.pumpApp(
        InfinitePageView(delegate: delegate),
      );

      // Assert
      // the first call should in the initState
      expect(onFetchDataCalledCount, equals(1));
    },
  );
}

extension on WidgetTester {
  Future<void> pumpApp(Widget child) {
    return pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: AppBar(),
          body: child,
        ),
      ),
    );
  }
}
