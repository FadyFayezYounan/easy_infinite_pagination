import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';
import 'bottom_loader_padding.dart';

/// Creates a [LoadMoreErrorBuilder] widget.
///
/// The [LoadMoreErrorBuilder] widget displays an error message and a refresh icon,
/// and allows the user to retry the operation by tapping on it.
///
/// The [onRetry] parameter is the callback that will be called when the user
/// taps on the widget.
Widget loadMoreErrorBuilder(BuildContext context, VoidCallback onRetry) {
  return LoadMoreErrorBuilder(onRetry: onRetry);
}

class LoadMoreErrorBuilder extends StatelessWidget {
  /// A widget that displays an error message and a refresh icon,
  /// and allows the user to retry the operation by tapping on it.
  const LoadMoreErrorBuilder({
    super.key,
    required this.onRetry,
  });

  /// The callback that will be called when the user taps on the widget.
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onRetry,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      elevation: 0.0,
      focusElevation: 0.0,
      hoverElevation: 0.0,
      highlightElevation: 0.0,
      child: const BottomLoaderPadding(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                defaultLoadMoreErrorMessage,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 4.0),
            Icon(
              Icons.refresh_rounded,
              size: 16.0,
            ),
          ],
        ),
      ),
    );
  }
}
