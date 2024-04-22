import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';

import '../../core/core.dart';
import '../../models/models.dart';

class InfinitePageView extends StatelessWidget {
  const InfinitePageView({
    super.key,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.allowImplicitScrolling = false,
    this.restorationId,
    this.pageController,
    this.scrollBehavior,
    this.scrollDirection = Axis.horizontal,
    this.dragStartBehavior = DragStartBehavior.start,
    this.clipBehavior = Clip.hardEdge,
    this.reverse = false,
    this.physics,
    this.onPageChanged,
    this.pageSnapping = true,
    this.padEnds = true,
    this.shrinkWrapFirstPageIndicators = false,
    required this.delegate,
  });

  /// [PaginationDelegate] contains all the necessary information for a paginated layout, such as
  /// the item count, item builder, loading indicator builder, error indicator
  /// builder, no more items indicator builder, loading state, error state,
  /// and more.
  final PaginationDelegate delegate;

  /// Matches [SliverChildBuilderDelegate.addAutomaticKeepAlives].
  final bool addAutomaticKeepAlives;

  /// Matches [SliverChildBuilderDelegate.addRepaintBoundaries].
  final bool addRepaintBoundaries;

  /// Matches [SliverChildBuilderDelegate.addSemanticIndexes].
  final bool addSemanticIndexes;

  /// Matches [PageView.allowImplicitScrolling].
  final bool allowImplicitScrolling;

  /// Matches [PageView.restorationId].
  final String? restorationId;

  /// Matches [PageView.controller].
  final PageController? pageController;

  /// Matches [PageView.scrollBehavior].
  final ScrollBehavior? scrollBehavior;

  /// Matches [PageView.scrollDirection].
  final Axis scrollDirection;

  /// Matches [PageView.dragStartBehavior].
  final DragStartBehavior dragStartBehavior;

  /// Matches [PageView.clipBehavior].
  final Clip clipBehavior;

  /// Matches [PageView.reverse].
  final bool reverse;

  /// Matches [PageView.physics].
  final ScrollPhysics? physics;

  /// Matches [PageView.pageSnapping].
  final bool pageSnapping;

  /// Matches [PageView.onPageChanged].
  final void Function(int)? onPageChanged;

  /// Matches [PageView.padEnds].
  final bool padEnds;

  /// Whether to shrink wrap the first page indicators
  final bool shrinkWrapFirstPageIndicators;

  @override
  Widget build(BuildContext context) {
    return PaginationLayoutBuilder(
      layoutStrategy: LayoutStrategy.box,
      delegate: delegate,
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
      controller: pageController,
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
      childrenDelegate: PaginationLayoutBuilder.createSliverDelegate(
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
