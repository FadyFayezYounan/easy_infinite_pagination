# Easy Infinite Pagination

A simple and customizable infinite pagination package for Flutter applications.
The Easy Infinite Pagination package makes it easy to add infinite pagination to your apps. With just a few lines of code, you can create beautiful and efficient paginated lists, grids, and page views.

<img width="300" src="https://raw.githubusercontent.com/FadyFayezYounan/easy_infinite_pagination/main/screenshots/easy_infinite_demo.gif"/>

## Features

- **Easy to use**: Simply provide the package with a `PaginationDelegate` object, which contains all the necessary information for a paginated layout, such as the item count, item builder, loading indicator builder, error indicator builder, no more items indicator builder, loading state, error state, and more.

- **Customizable:**: You can customize the appearance of the pagination indicators as you like, Include `firstPageLoading`, `firstPageError`, `firstPageNoItemsFound`, `loadMoreLoading`, `loadMoreError`, and `loadMoreReachedLastPage`.

- **Supports list view, grid view, and page view layouts**: The package can be used to create infinite lists, infinite grids, and infinite page views.

- **Works with any state management**: The package is designed to work with any state management such as `Bloc`, `Riverpod`, `Provider` and even the `setState`.

- **Efficient**: The package uses a number of optimizations to ensure that it is efficient, even for large datasets.

- **Extensible**: The package can be extended to support custom pagination scenarios for example suppose that you want to add pagination for [flutter_staggered_grid_view](https://pub.dev/packages/flutter_staggered_grid_view) you can do that by wrapping your widget with `PaginationLayoutBuilder` see [Support Custom Pagination Layouts](#customLayout-example).  

## Getting started

Import the following package in your dart file

```dart
import 'package:easy_infinite_pagination/easy_infinite_pagination.dart';
```

## Usage

```dart
class SimpleExample extends StatefulWidget {
  const SimpleExample({super.key});
  
  @override
  State<SimpleExample> createState() => _SimpleExampleState();
}

class _SimpleExampleState extends State<SimpleExample> {
  List<String> _items = [];
  bool _isLoading = true;

  void _fetchData() async {
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      _isLoading = false;
      // Add 20 more items to the list. This could be a network request, a database query, etc.
      _items = List.generate(_items.length + 20, (i) => 'Item ${i + 1}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Example'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: InfiniteListView(
        delegate: PaginationDelegate(
          itemCount: _items.length,
          itemBuilder: (_, index) => ListTile(
            title: Text(_items[index]),
          ),
          isLoading: _isLoading,
          onFetchData: _fetchData,
        ),
      ),
    );
  }
}
```

## Available Widgets

- `InfiniteListView` and `InfiniteListView.separated`
- `SliverInfiniteListView` and `SliverInfiniteListView.separated`
- `InfiniteGridView`
- `SliverInfiniteGridView`
- `InfinitePageView`
- `PaginationLayoutBuilder`: for custom pagination layouts scenarios

## Customizable Indicators

- With `easy_infinite_pagination` you can customize the appearance of the pagination indicators as you like. Include `firstPageLoading`, `firstPageError`, `firstPageNoItemsFound`, `loadMoreLoading`, `loadMoreError`, and `loadMoreReachedLastPage`.
- see full example [custom indicators example](example/lib/examples/custom_indicators_example/custom_indicators_example.dart).

```dart
InfiniteListView(
  delegate: PaginationDelegate(
    itemCount: _items.length,
    itemBuilder: (context, index) => ListTile(
      title: DefaultListTile(index: index),
    ),
    isLoading: _isLoading,
    onFetchData: _fetchData,
    firstPageLoadingBuilder: (context) =>
        const FirstPageLoadingIndicator(),
    firstPageErrorBuilder: (context) => FirstPageErrorIndicator(
      onRetry: _fetchData,
    ),
    firstPageNoItemsBuilder: (context) =>
        const FirstPageNoItemsFoundedIndicator(),
    loadMoreLoadingBuilder: (context) => const LoadMoreLoadingIndicator(),
    loadMoreErrorBuilder: (context) => LoadMoreErrorIndicator(
      onRetry: _fetchData,
    ),
    loadMoreNoMoreItemsBuilder: (context) =>
        const LoadMoreNoMoreItemsIndicator(),
    ),
  ),
  ```

## Control when to fetch data

- With `easy_infinite_pagination` you can control when to fetch data. by using the `invisibleItemsThreshold` parameter and `fetchDataOnStart` parameter.
- `invisibleItemsThreshold` is used as a threshold to determine when to fetch more data default value is 3.
- `fetchDataOnStart` is used to determine whether to fetch data on start or not default value is true.

```dart
InfiniteListView(
  delegate: PaginationDelegate(
    // The number of remaining invisible items that should trigger a new fetch.
    // The default value is 3.
    invisibleItemsThreshold: 5,
    // If true, it will fetch data on start.
    fetchDataOnStart: true,
    ....
    ),
  )
```

## How to use `easy_infinite_pagination` with Bloc

- The `easy_infinite_pagination` package is designed to work with any state management such as `Bloc`, `Riverpod`, `Provider` and even the `setState`.
- see full example [bloc example](example/lib/examples/bloc_example/screens/posts_list_view_screen.dart).

```dart
InfiniteListView.separated(
  delegate: PaginationDelegate(
    isLoading: state is PostsFetchLoading,
    hasError: state is PostsFetchError,
    hasReachedMax: context.read<PostsListCubit>().hasReachedMax,
    // The number of remaining invisible items that should trigger a new fetch.
    // The default value is 3.
    invisibleItemsThreshold: 5,
    itemCount: posts.length,
    itemBuilder: (context, index) {
    final post = posts[index];
    return PostWidget(post: post);
    },
    // here we add a custom error screen if the state is an error state.
    // and this screen will be shown if an error occurs while fetching data for the first page.
    firstPageErrorBuilder: state is PostsFetchError
      ? (context) =>
      CustomErrorScreen(errorMessage: state.message)
      : null,
    // this method will be called when the user reaches the end of the list or for the first page.
    onFetchData: () async {
      await context.read<PostsListCubit>().fetchPosts();
      },
    ),
    separatorBuilder: (context, index) => const Divider(),
  )
```

## How to use `easy_infinite_pagination` with `Sliver`

- The package supports `sliver` layouts such as `SliverInfiniteListView`, `SliverInfiniteListView.separated` and `SliverInfiniteGridView`.
- see full example [sliver grid view example](example/lib/examples/bloc_example/screens/posts_sliver_grid_view_screen.dart).

```dart
SliverPadding(
  padding: const EdgeInsets.all(16.0),
  sliver: SliverInfiniteGridView(
    gridDelegate:
      const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    crossAxisSpacing: 10.0,
    mainAxisSpacing: 10.0,
  ),
  delegate: PaginationDelegate(
    isLoading: state.isLoading,
    hasError: state.hasError,
    hasReachedMax: state.hasReachedMax,
    // The number of remaining invisible items that should trigger a new fetch.
    // The default value is 3.
    invisibleItemsThreshold: 5,
    itemCount: state.posts.length,
    itemBuilder: (context, index) {
      final post = state.posts[index];
      return PostGridWidget(post: post);
    },
    // this method will be called when the user reaches the end of the list or for the first page.
    onFetchData: () async {
      await context.read<PostsGridCubit>().fetchPosts();
      },
    ),
  ),
)
```

## How to use `easy_infinite_pagination` with `InfinitePageView`

- The package supports `InfinitePageView`.
- see full example [page view example](example/lib/examples/page_view_example/page_view_example_screen.dart).

```dart
InfinitePageView(
  scrollDirection: Axis.vertical,
  delegate: PaginationDelegate(
  itemCount: _items.length,
  itemBuilder: (_, index) => ListTile(
    title: PageViewItem(index: index),
  ),
  isLoading: _isLoading,
  invisibleItemsThreshold: 1,
  onFetchData: _fetchData,
 ),
),
```

<a id="customLayout-example"></a>

## Support Custom Pagination Layouts

- To create a new sliver layout, if `InfiniteListView`, `SliverInfiniteListView`, `InfiniteGridView`,`SliverInfiniteGridView`, and`InfinitePageView` do not meet your requirements, with `easy_infinite_pagination` you can make your own pagination layout.
- For example suppose that you want to add pagination for [flutter_staggered_grid_view](https://pub.dev/packages/flutter_staggered_grid_view) you can do that by wrapping your widget with `PaginationLayoutBuilder`.
- see full example [custom pagination example](example/lib/examples/custom_example/infinite_masonry_grid_view.dart).

```dart
return PaginationLayoutBuilder(
  // Provider the layout strategy (box or sliver).
  // In this case we used the box strategy.
  // because the child not sliver widget.
  layoutStrategy: LayoutStrategy.box,
  delegate: paginationDelegate,
  useShrinkWrapForFirstPageIndicators: _useShrinkWrapForFirstPageIndicators,
  layoutChildBuilder: (
    context,
    itemBuilder,
    itemCount,
    bottomLoaderBuilder,
    ) =>
        MasonryGridView.custom(
      gridDelegate: gridDelegate,
      mainAxisSpacing: mainAxisSpacing,
      crossAxisSpacing: crossAxisSpacing,
      padding: padding,
      // Here we create a predefined sliver delegate by the package
      // this delegate is used to handle the bottom loader widget while loading, success and error state.
      childrenDelegate: PaginationLayoutBuilder.createSliverChildDelegate(
        builder: itemBuilder,
        childCount: itemCount,
        bottomLoaderBuilder: bottomLoaderBuilder,
        addAutomaticKeepAlives: addAutomaticKeepAlives,
        addRepaintBoundaries: addRepaintBoundaries,
        addSemanticIndexes: addSemanticIndexes,
      ),
    ),
  )
```

## Additional information

<!-- - **Documentation**: For more information on how to use the Easy Infinite Pagination package, please see the [documentation](https://pub.dev/documentation/easy_infinite_pagination/latest/). -->
- **Contributing**: Contributions to the Easy Infinite Pagination package are welcome! [GitHub repository](https://github.com/FadyFayezYounan/easy_infinite_pagination/pulls).
- **Filing issues**: If you encounter any issues with the Easy Infinite Pagination package, please file an issue on the [GitHub repository](https://github.com/FadyFayezYounan/easy_infinite_pagination/issues).
- **Support**: If you have any questions or need help using the Easy Infinite Pagination package, please feel free to reach out to the package authors on [GitHub](https://github.com/FadyFayezYounan).

We hope you find the Easy Infinite Pagination package helpful!
