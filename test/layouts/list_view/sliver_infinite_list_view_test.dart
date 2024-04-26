import 'package:easy_infinite_pagination/easy_infinite_pagination.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

const _listItemHeight = 100.0;
void main() {
  group('SliverInfiniteListView', () {
    testWidgets('renders correctly', (tester) async {
      // Arrange
      final delegate = PaginationDelegate(
        itemBuilder: (context, index) => _ListItem(
          data: 'Item $index',
        ),
        itemCount: 10,
        onFetchData: () {},
      );
      // Act
      await tester.pumpSliverWithFixedHeight(
          SliverInfiniteListView(delegate: delegate));

      // Assert
      expect(find.text('Item 0'), findsOneWidget);
      expect(find.text('Item 9'), findsNothing);

      final listViewFinder = find.descendant(
        of: find.byType(CustomScrollView),
        matching: find.byType(Scrollable),
      );

      final lastItemInTheListToScroll = find.byWidgetPredicate(
          (widget) => widget is _ListItem && widget.data == 'Item 9');

      // Scroll through the list until the last EasyDayWidget is visible
      await tester.scrollUntilVisible(
        lastItemInTheListToScroll,
        _listItemHeight,
        scrollable: listViewFinder,
      );
      expect(find.text('Item 9'), findsOneWidget);
    });

    testWidgets('renders separator correctly when hasReachedMax is true',
        (tester) async {
      // Arrange
      final delegate = PaginationDelegate(
        itemBuilder: (context, index) => Container(),
        itemCount: 10,
        hasReachedMax: true,
        onFetchData: () {},
      );

      // Act
      await tester.pumpSliver(SliverInfiniteListView.separated(
        delegate: delegate,
        separatorBuilder: (context, index) => const Divider(),
      ));

      expect(find.byType(Divider), findsAtLeast(9));
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
      await tester.pumpSliverWithFixedHeight(SliverInfiniteListView.separated(
        delegate: delegate,
        separatorBuilder: (context, index) => const Divider(),
      ));

      // Assert
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
      await tester.pumpSliverWithFixedHeight(SliverInfiniteListView.separated(
        delegate: delegate,
        separatorBuilder: (context, index) => const Divider(),
      ));

      // Assert
      expect(find.byType(Divider), findsNWidgets(10));
    });
  });
}

class _ListItem extends StatelessWidget {
  const _ListItem({required this.data});
  final String data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _listItemHeight,
      child: Text(data),
    );
  }
}

extension on WidgetTester {
  Future<void> pumpSliverWithFixedHeight(Widget sliver) {
    return pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: AppBar(),
          body: SizedBox(
            height: 500,
            child: CustomScrollView(
              slivers: [sliver],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> pumpSliver(Widget sliver) {
    return pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: AppBar(),
          body: CustomScrollView(
            slivers: [sliver],
          ),
        ),
      ),
    );
  }
}
