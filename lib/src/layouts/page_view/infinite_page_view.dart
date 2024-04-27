import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';

import '../../core/core.dart';
import '../../models/models.dart';

class InfinitePageView extends StatelessWidget {
  /// The `InfinitePageView` is similar to [PageView],
  /// but it allows for infinite scrolling in both directions.
  ///
  /// The `InfinitePageView` widget is a paginated layout that allows for infinite scrolling in both directions.
  /// It uses a PageView internally to display the pages,
  /// and it manages the loading and display of items as the user scrolls.
  const InfinitePageView({
    super.key,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.allowImplicitScrolling = false,
    this.restorationId,
    this.controller,
    this.scrollBehavior,
    this.scrollDirection = Axis.horizontal,
    this.dragStartBehavior = DragStartBehavior.start,
    this.clipBehavior = Clip.hardEdge,
    this.reverse = false,
    this.physics,
    this.onPageChanged,
    this.pageSnapping = true,
    this.padEnds = true,
    this.enableShrinkWrapForFirstPageIndicators = false,
    required this.delegate,
  });

  /// The `PaginationDelegate` contains all the necessary information for a paginated layout, such as
  /// the item count, item builder, loading indicator builder, error indicator
  /// builder, no more items indicator builder, loading state, error state,
  /// and more.
  final PaginationDelegate delegate;

  /// The `addAutomaticKeepAlives` argument corresponds to the
  /// [SliverChildBuilderDelegate.addAutomaticKeepAlives] property.
  final bool addAutomaticKeepAlives;

  /// The `addRepaintBoundaries` argument corresponds to the
  /// [SliverChildBuilderDelegate.addRepaintBoundaries] property.
  final bool addRepaintBoundaries;

  /// The `addSemanticIndexes` argument corresponds to the
  /// [SliverChildBuilderDelegate.addSemanticIndexes] property.
  final bool addSemanticIndexes;

  /// Controls whether the widget's pages will respond to
  /// [RenderObject.showOnScreen], which will allow for implicit accessibility
  /// scrolling.
  ///
  /// With this flag set to false, when accessibility focus reaches the end of
  /// the current page and the user attempts to move it to the next element, the
  /// focus will traverse to the next widget outside of the page view.
  ///
  /// With this flag set to true, when accessibility focus reaches the end of
  /// the current page and user attempts to move it to the next element, focus
  /// will traverse to the next page in the page view.
  ///
  /// The `allowImplicitScrolling` argument corresponds to the [PageView.allowImplicitScrolling] property.
  final bool allowImplicitScrolling;

  /// The `restorationId` argument corresponds to the [PageView.restorationId] property.
  final String? restorationId;

  /// The `controller` argument corresponds to the [PageView.controller] property.
  final PageController? controller;

  /// How the page view should respond to user input.
  ///
  /// For example, determines how the page view continues to animate after the
  /// user stops dragging the page view.
  ///
  /// The physics are modified to snap to page boundaries using
  /// [PageScrollPhysics] prior to being used.
  ///
  /// If an explicit [ScrollBehavior] is provided to [scrollBehavior], the
  /// [ScrollPhysics] provided by that behavior will take precedence after
  /// [physics].
  ///
  /// Defaults to matching platform conventions.
  ///
  /// The `scrollBehavior` argument corresponds to the [PageView.scrollBehavior] property.
  final ScrollBehavior? scrollBehavior;

  /// The [Axis] along which the scroll view's offset increases with each page.
  ///
  /// For the direction in which active scrolling may be occurring, see
  /// [ScrollDirection].
  ///
  /// Defaults to [Axis.horizontal].
  ///
  /// The `scrollDirection` argument corresponds to the [PageView.scrollDirection] property.
  final Axis scrollDirection;

  /// The `dragStartBehavior` argument corresponds to the [PageView.dragStartBehavior] property.
  final DragStartBehavior dragStartBehavior;

  /// The `clipBehavior` argument corresponds to the [PageView.clipBehavior] property.
  /// Defaults to [Clip.hardEdge].
  final Clip clipBehavior;

  /// Whether the page view scrolls in the reading direction.
  ///
  /// For example, if the reading direction is left-to-right and
  /// [scrollDirection] is [Axis.horizontal], then the page view scrolls from
  /// left to right when [reverse] is false and from right to left when
  /// [reverse] is true.
  ///
  /// Similarly, if [scrollDirection] is [Axis.vertical], then the page view
  /// scrolls from top to bottom when [reverse] is false and from bottom to top
  /// when [reverse] is true.
  ///
  /// Defaults to false.
  ///
  /// The `reverse` argument corresponds to the [PageView.reverse] property.
  final bool reverse;

  /// How the page view should respond to user input.
  ///
  /// For example, determines how the page view continues to animate after the
  /// user stops dragging the page view.
  ///
  /// The physics are modified to snap to page boundaries using
  /// [PageScrollPhysics] prior to being used.
  ///
  /// If an explicit [ScrollBehavior] is provided to [scrollBehavior], the
  /// [ScrollPhysics] provided by that behavior will take precedence after
  /// [physics].
  ///
  /// Defaults to matching platform conventions.
  ///
  /// The `physics` argument corresponds to the [PageView.physics] property.
  final ScrollPhysics? physics;

  /// Set to false to disable page snapping, useful for custom scroll behavior.
  ///
  /// If the [padEnds] is false and [PageController.viewportFraction] < 1.0,
  /// the page will snap to the beginning of the viewport; otherwise, the page
  /// will snap to the center of the viewport.
  ///
  /// The `pageSnapping` argument corresponds to the [PageView.pageSnapping] property.
  final bool pageSnapping;

  /// Called whenever the page in the center of the viewport changes.
  ///
  /// The `onPageChanged` argument corresponds to the [PageView.onPageChanged] property.
  final ValueChanged<int>? onPageChanged;

  /// Set to false to disable page snapping, useful for custom scroll behavior.
  ///
  /// If the [padEnds] is false and [PageController.viewportFraction] < 1.0,
  /// the page will snap to the beginning of the viewport; otherwise, the page
  /// will snap to the center of the viewport.
  ///
  /// The `padEnds` argument corresponds to the [PageView.padEnds] property.
  final bool padEnds;

  /// Whether to shrink wrap the first page indicators or not.
  final bool enableShrinkWrapForFirstPageIndicators;

  @override
  Widget build(BuildContext context) {
    return PaginationLayoutBuilder(
      layoutStrategy: LayoutStrategy.box,
      delegate: delegate,
      enableShrinkWrapForFirstPageIndicators:
          enableShrinkWrapForFirstPageIndicators,
      layoutChildBuilder: _buildPageView,
    );
  }

  Widget _buildPageView(
    BuildContext context,
    IndexedWidgetBuilder itemBuilder,
    int itemCount,
    WidgetBuilder? bottomLoaderBuilder,
  ) {
    return PageView.custom(
      key: key,
      restorationId: restorationId,
      controller: controller,
      onPageChanged: onPageChanged,
      scrollBehavior: scrollBehavior,
      scrollDirection: scrollDirection,
      dragStartBehavior: dragStartBehavior,
      clipBehavior: clipBehavior,
      allowImplicitScrolling: allowImplicitScrolling,
      reverse: reverse,
      physics: physics,
      pageSnapping: pageSnapping,
      padEnds: padEnds,
      childrenDelegate: PaginationLayoutBuilder.createSliverChildDelegate(
        builder: itemBuilder,
        childCount: itemCount,
        bottomLoaderBuilder: bottomLoaderBuilder,
        addAutomaticKeepAlives: addAutomaticKeepAlives,
        addRepaintBoundaries: addRepaintBoundaries,
        addSemanticIndexes: addSemanticIndexes,
      ),
    );
  }
}
