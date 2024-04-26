import 'package:easy_infinite_pagination/easy_infinite_pagination.dart';
import 'package:example/examples/custom_indicators_example/indicators/first_page_loading_indicator.dart';
import 'package:flutter/material.dart';

import '../default_list_tile.dart';
import 'indicators/first_page_error_indicator.dart';
import 'indicators/first_page_no_items_founded_indicator.dart';
import 'indicators/load_more_error_indicator.dart';
import 'indicators/load_more_loading_indicator.dart';
import 'indicators/load_more_reach_max_indicator.dart';

class CustomIndicatorsExample extends StatefulWidget {
  const CustomIndicatorsExample({super.key});

  @override
  State<CustomIndicatorsExample> createState() =>
      _CustomIndicatorsExampleState();
}

class _CustomIndicatorsExampleState extends State<CustomIndicatorsExample> {
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
      ),
      body: InfiniteListView(
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
    );
  }
}
