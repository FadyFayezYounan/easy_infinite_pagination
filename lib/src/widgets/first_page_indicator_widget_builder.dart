import 'package:flutter/material.dart';

import '../models/models.dart';

class FirstPageIndicatorWidgetBuilder extends StatelessWidget {
  /// A widget that conditionally builds a widget based on the [layoutStrategy].
  ///
  /// This widget is used to build widgets that are used to indicate that the
  /// first page is loading, error, or that there are no items found in the first page.
  const FirstPageIndicatorWidgetBuilder({
    super.key,
    required this.builder,
    required this.enableShrinkWrapForFirstPageIndicators,
    required this.layoutStrategy,
  });

  /// A builder function that is used to build the widget.
  final WidgetBuilder builder;

  /// Whether to use shrink wrap for first page indicators or not.
  final bool enableShrinkWrapForFirstPageIndicators;

  /// Specifies the layout strategy.
  final LayoutStrategy layoutStrategy;

  @override
  Widget build(BuildContext context) {
    // Based on the layout strategy, build the appropriate widget.
    return switch (layoutStrategy) {
      LayoutStrategy.sliver => _buildSliverBuilder(context),
      LayoutStrategy.box => _buildBoxBuilder(context),
    };
  }

  /// Builds a SliverToBoxAdapter widget or a SliverFillRemaining widget based on the [enableShrinkWrapForFirstPageIndicators] parameter.
  Widget _buildSliverBuilder(BuildContext context) {
    // If the widget should be used for first page indicators, build a SliverToBoxAdapter widget.
    if (enableShrinkWrapForFirstPageIndicators) {
      return SliverToBoxAdapter(
        child: builder(context),
      );
    }
    // If the widget should not be used for first page indicators, build a SliverFillRemaining widget.
    else {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: builder(context),
      );
    }
  }

  /// Builds a Center widget or the provided widget based on the [enableShrinkWrapForFirstPageIndicators] parameter.
  Widget _buildBoxBuilder(BuildContext context) {
    // If the widget should be used for first page indicators, build the provided widget.
    if (enableShrinkWrapForFirstPageIndicators) {
      return builder(context);
    }
    // If the widget should not be used for first page indicators, build a Center widget.
    else {
      return Center(child: builder(context));
    }
  }
}
