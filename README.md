# Easy Infinite Pagination

A simple and customizable infinite pagination package for Flutter applications.
The Easy Infinite Pagination package provides a simple and customizable way to implement infinite pagination in your Flutter applications. It supports both list and grid layouts in addition to Page view, and provides a variety of options to customize the appearance of the pagination indicators.

<img width="300" src="https://raw.githubusercontent.com/FadyFayezYounan/easy_infinite_pagination/main/screenshots/easy_infinite_demo.gif"/>

## Features

- **Easy to use**: Simply provide the package with a `PaginationDelegate` object, which contains all the necessary information for a paginated layout, such as the item count, item builder, loading indicator builder, error indicator builder, no more items indicator builder, loading state, error state, and more.

- **Customizable:**: You can customize the appearance of the pagination indicators as you like, Include `firstPageLoading`, `firstPageError`, `firstPageNoItemsFound`, `loadMoreLoading`, `loadMoreError`, and `loadMoreReachedLastPage`.

- **Supports list view, grid view, and page view layouts**: The package can be used to create infinite lists, infinite grids, and infinite page views.

- **Works with any state management**: The package is designed to work with any state management such as `Bloc`, `Riverpod`, `Provider` and even the `setState`.

- **Efficient**: The package uses a number of optimizations to ensure that it is efficient, even for large datasets.

- **Extensible**: The package can be extended to support custom pagination scenarios for example suppose that you want to add pagination for `flutter_staggered_grid_view` you can do that by wrapping your widget with `PaginationLayoutBuilder` see full example [custom pagination example](example/lib/examples/custom_example/infinite_masonry_grid_view.dart).  

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

## Additional information

<!-- - **Documentation**: For more information on how to use the Easy Infinite Pagination package, please see the [documentation](https://pub.dev/documentation/easy_infinite_pagination/latest/). -->
- **Contributing**: Contributions to the Easy Infinite Pagination package are welcome! [GitHub repository](https://github.com/FadyFayezYounan/easy_infinite_pagination/pulls).
- **Filing issues**: If you encounter any issues with the Easy Infinite Pagination package, please file an issue on the [GitHub repository](https://github.com/FadyFayezYounan/easy_infinite_pagination/issues).
- **Support**: If you have any questions or need help using the Easy Infinite Pagination package, please feel free to reach out to the package authors on [GitHub](https://github.com/FadyFayezYounan).

We hope you find the Easy Infinite Pagination package helpful!
