import 'package:easy_infinite_pagination/easy_infinite_pagination.dart';
import 'package:flutter/material.dart';

import 'page_view_item.dart';

class PageViewExampleScreen extends StatefulWidget {
  const PageViewExampleScreen({super.key});

  @override
  State<PageViewExampleScreen> createState() => _PageViewExampleScreenState();
}

class _PageViewExampleScreenState extends State<PageViewExampleScreen> {
  List<String> _items = [];
  bool _isLoading = false;

  void _fetchData() async {
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
      // Add 5 more items to the list. This could be a network request, a database query, etc.
      _items = List.generate(_items.length + 5, (i) => 'Page ${i + 1}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PageView Example')),
      body: InfinitePageView(
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
    );
  }
}
