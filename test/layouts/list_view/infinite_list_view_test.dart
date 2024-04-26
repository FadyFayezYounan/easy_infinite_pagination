import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:easy_infinite_pagination/src/layouts/list_view/infinite_list_view.dart';
import 'package:easy_infinite_pagination/src/models/models.dart';

void main() {
  group('InfiniteListView', () {
    testWidgets('renders correctly', (tester) async {
      // Arrange
      final delegate = PaginationDelegate(
        itemBuilder: (context, index) => Text('Item $index'),
        itemCount: 10,
        onFetchData: () {},
      );
      // Act
      await tester.pumpApp(
        InfiniteListView(delegate: delegate),
      );
      // Assert
      expect(find.text('Item 0'), findsOneWidget);
      expect(find.text('Item 9'), findsOneWidget);
    });

    testWidgets('renders separator correctly when hasReachedMax is true',
        (tester) async {
      // Arrange
      final delegate = PaginationDelegate(
        itemBuilder: (context, index) => Text('Item $index'),
        itemCount: 10,
        hasReachedMax: true,
        onFetchData: () {},
      );
      // Act
      await tester.pumpApp(
        InfiniteListView.separated(
          delegate: delegate,
          separatorBuilder: (context, index) => const Divider(),
        ),
      );
      // Assert
      expect(find.byType(Divider), findsNWidgets(9));
    });

    testWidgets('renders separator correctly when isLoading is true',
        (tester) async {
      // Arrange
      final delegate = PaginationDelegate(
        itemBuilder: (context, index) => Text('Item $index'),
        itemCount: 10,
        isLoading: true,
        onFetchData: () {},
      );
      // Act
      await tester.pumpApp(
        InfiniteListView.separated(
          delegate: delegate,
          separatorBuilder: (context, index) => const Divider(),
        ),
      );

      /// Assert
      expect(find.byType(Divider), findsNWidgets(10));
    });
    testWidgets('renders separator correctly when hasError is true',
        (tester) async {
      // Arrange
      final delegate = PaginationDelegate(
        itemBuilder: (context, index) => Text('Item $index'),
        itemCount: 10,
        hasError: true,
        onFetchData: () {},
      );
      // Act
      await tester.pumpApp(
        InfiniteListView.separated(
          delegate: delegate,
          separatorBuilder: (context, index) => const Divider(),
        ),
      );
      // Assert
      expect(find.byType(Divider), findsNWidgets(10));
    });
  });
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
