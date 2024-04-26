import 'package:easy_infinite_pagination/easy_infinite_pagination.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

extension on WidgetTester {
  Future<void> pumpSliver(Widget sliver) async {
    await pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: AppBar(),
          body: CustomScrollView(slivers: [sliver]),
        ),
      ),
    );
    await pump();
  }

  Future<void> pumpPaginationLayoutWithSliverList(
    PaginationDelegate delegate, {
    bool useShrinkWrapForFirstPageIndicators = false,
  }) {
    return pumpSliver(
      PaginationLayoutBuilder(
        delegate: delegate,
        layoutStrategy: LayoutStrategy.sliver,
        useShrinkWrapForFirstPageIndicators:
            useShrinkWrapForFirstPageIndicators,
        layoutChildBuilder: (
          context,
          itemBuilder,
          itemCount,
          bottomLoaderBuilder,
        ) =>
            SliverList(
          delegate: PaginationLayoutBuilder.createSliverChildDelegate(
            builder: itemBuilder,
            childCount: itemCount,
            bottomLoaderBuilder: bottomLoaderBuilder,
          ),
        ),
      ),
    );
  }
}
