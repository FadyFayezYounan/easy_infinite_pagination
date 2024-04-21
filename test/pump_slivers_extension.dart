import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

extension PumpSliversExtension on WidgetTester {
  Future<void> pumpSlivers(
    List<Widget> slivers, {
    double? cacheExtent,
  }) async {
    await pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SizedBox(
            height: 500.0,
            child: CustomScrollView(
              cacheExtent: cacheExtent,
              slivers: slivers,
            ),
          ),
        ),
      ),
    );
    await pump();
  }
}
