import 'package:easy_infinite_pagination/easy_infinite_pagination.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

const _listItemHeight = 100.0;
void main() {
  group(
    'SliverInfiniteListView',
    () {
      testWidgets('renders correctly', (tester) async {
        // Arrange
        const lastItemKey = ValueKey(9);
        final delegate = PaginationDelegate(
          itemBuilder: (context, index) => ListItem(
            key: ValueKey(index),
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

        // Scroll through the list until the last EasyDayWidget is visible
        await tester.scrollUntilVisible(
          find.byKey(lastItemKey),
          _listItemHeight,
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

      testWidgets(
        'calls onFetchData in the initState and  when scrolled to the end',
        (tester) async {
          // Arrange
          var onFetchDataCalledCount = 0;
          final delegate = PaginationDelegate(
            itemCount: 10,
            invisibleItemsThreshold: 1,
            itemBuilder: (context, index) => ListItem(
              key: ValueKey(index),
              data: 'Item $index',
            ),
            onFetchData: () {
              onFetchDataCalledCount++;
            },
          );

          // Act
          await tester.pumpSliverWithFixedHeight(
            SliverInfiniteListView(delegate: delegate),
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
            itemBuilder: (context, index) => ListItem(
              key: ValueKey(index),
              data: 'Item $index',
            ),
            onFetchData: () {
              onFetchDataCalledCount++;
            },
          );

          // Act
          await tester.pumpSliverWithFixedHeight(
            SliverInfiniteListView(delegate: delegate),
          );

          // Assert
          // the first call should in the initState
          expect(onFetchDataCalledCount, equals(1));

          await tester.scrollUntilVisible(
            find.byKey(const ValueKey(shouldFetchAtIndex)),
            _listItemHeight,
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
            itemBuilder: (context, index) => ListItem(
              key: ValueKey(index),
              data: 'Item $index',
            ),
            onFetchData: () {
              onFetchDataCalledCount++;
            },
          );

          // Act
          await tester.pumpSliverWithFixedHeight(
            SliverInfiniteListView(delegate: delegate),
          );

          // Assert
          expect(onFetchDataCalledCount, equals(1));
        },
      );
    },
  );
}

class ListItem extends StatelessWidget {
  const ListItem({
    super.key,
    required this.data,
  });
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
