import 'package:flutter/material.dart';

/// Builds a widget for displaying an error message when the first page
/// of the application fails to load.
///
/// The [onRetry] callback is triggered when the user taps the 'Try Again' button.
Widget firstPageErrorBuilder(BuildContext context, VoidCallback onRetry) {
  return FirstPageErrorBuilder(onRetry: onRetry);
}

class FirstPageErrorBuilder extends StatelessWidget {
  /// A widget that displays an error message when the first page of
  /// the application fails to load.
  const FirstPageErrorBuilder({
    required this.onRetry,
    super.key,
  });

  /// The callback that is triggered when the user taps the 'Try Again' button.
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 32.0,
          horizontal: 16.0,
        ),
        child: Column(
          children: [
            // Error message title
            Text(
              'Something went wrong!',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16.0),
            // Error message description
            const Text(
              'The application has encountered an unknown error.\n'
              'Please try again later.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48.0),
            // Button for retrying
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(
                Icons.refresh_rounded,
                color: Colors.white,
              ),
              label: const Text(
                'Try Again',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
