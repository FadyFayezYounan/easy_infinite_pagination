import 'package:flutter/material.dart';
import 'package:easy_infinite_pagination/easy_infinite_pagination.dart';

import 'infinite_masonry_grid_view.dart';
import 'masonry_grid_item.dart';

class CustomPaginationExampleScreen extends StatefulWidget {
  const CustomPaginationExampleScreen({super.key});

  @override
  State<CustomPaginationExampleScreen> createState() =>
      _CustomPaginationExampleScreenState();
}

class _CustomPaginationExampleScreenState
    extends State<CustomPaginationExampleScreen> {
  List<String> _items = [];
  bool _isLoading = false;

  void _fetchData() async {
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _isLoading = false;
      // Add 20 more items to the list. This could be a network request, a database query, etc.
      _items = List.generate(_items.length + 20, (i) => 'Item ${i + 1}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Custom Pagination Example')),
      body: InfiniteMasonryGridView.count(
        padding: const EdgeInsets.all(16.0),
        paginationDelegate: PaginationDelegate(
          itemCount: _items.length,
          isLoading: _isLoading,
          itemBuilder: (context, index) {
            return MasonryItem(index: index);
          },
          onFetchData: _fetchData,
        ),
        mainAxisSpacing: 16.0,
        crossAxisSpacing: 16.0,
        crossAxisCount: 3,
      ),
    );
  }
}
