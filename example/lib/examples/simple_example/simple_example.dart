import 'package:easy_infinite_pagination/easy_infinite_pagination.dart';
import 'package:flutter/material.dart';

class SimpleExample extends StatefulWidget {
  const SimpleExample({super.key});

  @override
  State<SimpleExample> createState() => _SimpleExampleState();
}

class _SimpleExampleState extends State<SimpleExample> {
  List<String> _items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
  bool _isLoading = true;

  void _fetchData() async {
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2));
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
          itemCount: 5,
          // itemBuilder: (_, index) => ListTile(
          //   title: Text(_items[index]),
          // ),
          itemBuilder: (context, index) => Container(),
          isLoading: true,
          loadMoreLoadingBuilder: (context) => const Text('Loading...'),
          onFetchData: _fetchData,
        ),
      ),
    );
  }
}
// import 'package:easy_infinite_pagination/easy_infinite_pagination.dart';
// import 'package:flutter/material.dart';

// class SimpleExample extends StatefulWidget {
//   const SimpleExample({super.key});

//   @override
//   State<SimpleExample> createState() => _SimpleExampleState();
// }

// class _SimpleExampleState extends State<SimpleExample> {
//   List<String> _items = [];
//   bool _isLoading = true;

//   void _fetchData() async {
//     setState(() {
//       _isLoading = true;
//     });
//     await Future.delayed(const Duration(seconds: 2));
//     setState(() {
//       _isLoading = false;
//       // Add 20 more items to the list. This could be a network request, a database query, etc.
//       _items = List.generate(_items.length + 20, (i) => 'Item ${i + 1}');
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Simple Example'),
//       ),
//       body: InfiniteListView(
//         delegate: PaginationDelegate(
//           itemCount: _items.length,
//           itemBuilder: (_, index) => ListTile(
//             title: Text(_items[index]),
//           ),
//           isLoading: _isLoading,
//           onFetchData: _fetchData,
//         ),
//       ),
//     );
//   }
// }
