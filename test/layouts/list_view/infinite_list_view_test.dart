import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:easy_infinite_pagination/src/layouts/list_view/infinite_list_view.dart';
import 'package:easy_infinite_pagination/src/models/models.dart';

void main() {
  group('InfiniteListView', () {
    testWidgets('renders correctly', (tester) async {
      final delegate = PaginationDelegate(
        itemBuilder: (context, index) => Text('Item $index'),
        itemCount: 10,
        onFetchData: () {},
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: InfiniteListView(delegate: delegate),
          ),
        ),
      );

      expect(find.text('Item 0'), findsOneWidget);
      expect(find.text('Item 9'), findsOneWidget);
    });

    testWidgets('renders separator correctly', (tester) async {
      final delegate = PaginationDelegate(
        itemBuilder: (context, index) => Text('Item $index'),
        itemCount: 10,
        onFetchData: () {},
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: InfiniteListView.separated(
              delegate: delegate,
              separatorBuilder: (context, index) => const Divider(),
            ),
          ),
        ),
      );

      expect(find.byType(Divider), findsNWidgets(9));
    });

    testWidgets('uses shrink wrap for first page indicators', (tester) async {
      final delegate = PaginationDelegate(
        itemBuilder: (context, index) => Text('Item $index'),
        itemCount: 10,
        onFetchData: () {},
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: InfiniteListView(
              delegate: delegate,
              shrinkWrap: true,
            ),
          ),
        ),
      );

      expect(find.byType(SliverToBoxAdapter), findsOneWidget);
    });
  });
}
