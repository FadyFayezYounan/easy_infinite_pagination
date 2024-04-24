import 'package:example/examples/bloc_example/screens/posts_grid_view_screen.dart';
import 'package:example/examples/bloc_example/screens/posts_list_view_screen.dart';
import 'package:flutter/material.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final List<Widget> _examples = [
    const SimpleExample(),
    const PostListViewScreen(),
    //const PostListViewScreen(),
    const PostsGridViewScreen(),
    const CustomPaginationExampleScreen(),
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
          NavigationDestination(icon: Icon(Icons.abc), label: "Simple"),
          NavigationDestination(
              icon: Icon(Icons.list_alt_rounded), label: "ListView"),
          // NavigationDestination(
          //     icon: Icon(Icons.reorder_rounded), label: "Sliver"),
          NavigationDestination(
              icon: Icon(Icons.apps_rounded), label: "GridView"),
          NavigationDestination(
              icon: Icon(Icons.dashboard_customize_rounded), label: "Custom"),
        ],
      ),
    );
  }
}
