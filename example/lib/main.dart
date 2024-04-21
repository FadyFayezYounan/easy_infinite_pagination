import 'dart:developer';

import 'package:easy_infinite_pagination/easy_infinite_pagination.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'examples/examples.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final List<Widget> _examples = [
    const SimpleExample(),
    const BlocExample(),
    const SimpleExample(),
    const SimpleExample(),
  ];

  void _onDestinationSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _examples[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onDestinationSelected,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.abc), label: "Simple "),
          NavigationDestination(icon: Icon(Icons.abc), label: "Bloc"),
          NavigationDestination(icon: Icon(Icons.abc), label: "Simple "),
          NavigationDestination(
              icon: Icon(Icons.grid_4x4_rounded), label: "Grid"),
        ],
      ),
    );
  }
}
// import 'dart:developer';

// import 'package:easy_infinite_pagination/easy_infinite_pagination.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // TRY THIS: Try running your application with "flutter run". You'll see
//         // the application has a purple toolbar. Then, without quitting the app,
//         // try changing the seedColor in the colorScheme below to Colors.green
//         // and then invoke "hot reload" (save your changes or press the "hot
//         // reload" button in a Flutter-supported IDE, or press "r" if you used
//         // the command line to start the app).
//         //
//         // Notice that the counter didn't reset back to zero; the application
//         // state is not lost during the reload. To reset the state, use hot
//         // restart instead.
//         //
//         // This works for code too, not just values: Most code changes can be
//         // tested with just a hot reload.
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   var _items = <String>[
//     // "Item 1",
//     // "Item 2",
//     // "Item 3",
//     // "Item 4",
//     // "Item 5",
//     // "Item 6",
//     // "Item 7",
//     // "Item 8",
//     // "Item 9",
//     // "Item 10",
//     // "Item 11",
//     // "Item 12",
//     // "Item 13",
//     // "Item 15",
//     // "Item 16",
//     // "Item 17",
//     // "Item 18",
//     // "Item 19",
//     // "Item 20",
//     // "Item 21",
//     // "Item 22",
//     // "Item 23",
//     // "Item 24",
//     // "Item 25",
//   ];

//   var _isLoading = false;
//   var _hasError = false;
//   var _hasReachedMax = false;

//   void _fetchData() async {
//     setState(() {
//       _isLoading = true;
//     });
//     log("Fetch data called");
//     await Future.delayed(const Duration(seconds: 5));
//     // setState(() {
//     //   _hasError = true;
//     //   _isLoading = false;
//     // });
//     // throw Exception('Failed to fetch data');

//     if (!mounted) {
//       return;
//     }

//     setState(() {
//       _isLoading = false;
//       _hasError = false;
//       //_hasReachedMax = true;
//       _items = List.generate(_items.length + 10, (i) => 'Item ${i + 1}');
//     });
//   }

//   void _fetchData2() async {
//     await Future.delayed(const Duration(seconds: 5));

//     setState(() {
//       _items = List.generate(_items.length + 20, (i) => 'Item ${i + 1}');
//     });
//   }

//   void _incrementCounter() {
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//       ),
//       body: InfinitePageView(
//         delegate: PaginationDelegate(
//           isLoading: _isLoading,
//           itemCount: _items.length,
//           hasError: _hasError,

//           //loadMoreNoMoreItemsBuilder: (context) => Text("reach max"),
//           // fetchDataOnStart: false,
//           hasReachedMax: _hasReachedMax,
//           itemBuilder: (context, index) {
//             //log("build item ${index + 1}");
//             return _buildItem(index);
//           },
//           onFetchData: _fetchData,
//         ),
//       ),
//     );
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: CustomScrollView(slivers: [
//         // SliverGrid.builder(
//         //   gridDelegate: gridDelegate,
//         //   itemBuilder: itemBuilder,
//         //   addSemanticIndexes: ,
//         // ),
//         SliverPadding(
//           padding: const EdgeInsets.all(16.0),
//           sliver: SliverInfiniteGridView(
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               mainAxisSpacing: 16,
//               crossAxisSpacing: 16,
//             ),
//             delegate: PaginationDelegate(
//               isLoading: _isLoading,
//               itemCount: _items.length,
//               hasError: _hasError,

//               //loadMoreNoMoreItemsBuilder: (context) => Text("reach max"),
//               // fetchDataOnStart: false,
//               hasReachedMax: _hasReachedMax,
//               itemBuilder: (context, index) {
//                 //log("build item ${index + 1}");
//                 return _buildItem(index);
//               },
//               onFetchData: _fetchData,
//             ),
//           ),
//         ),
//         // SliverPadding(
//         //   padding: const EdgeInsets.all(16.0),
//         //   sliver: SliverInfiniteListView.separated(
//         //     separatorBuilder: (context, index) => SizedBox(height: 16),
//         //     delegate: PaginationDelegate(
//         //       isLoading: _isLoading,
//         //       itemCount: _items.length,
//         //       hasError: _hasError,

//         //       //loadMoreNoMoreItemsBuilder: (context) => Text("reach max"),
//         //       // fetchDataOnStart: false,
//         //       hasReachedMax: _hasReachedMax,
//         //       itemBuilder: (context, index) {
//         //         //log("build item ${index + 1}");
//         //         return _buildItem(index);
//         //       },
//         //       onFetchData: _fetchData,
//         //     ),
//         //   ),
//         // ),
//       ]),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }

//   Container _buildItem(int index) {
//     return Container(
//       height: 120,
//       color: Colors.teal,
//       child: ListTile(
//         title: Text(
//           _items[index],
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//     );
//   }
// }
