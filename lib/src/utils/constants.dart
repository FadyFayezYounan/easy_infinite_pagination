/// The default duration for debouncing.
const Duration defaultDebounceDuration = Duration(milliseconds: 150);

/// The default number of invisible items that triggers pagination.
///
/// If there are at least [defaultInvisibleItemsThreshold] invisible items
/// in a list, it is considered to be at the end of the list, and
/// another page of data should be fetched.
///
/// It is used in [InfiniteListView], [InfinitePageView], [InfiniteGridView] widgets.
///
/// This value is used as a threshold to determine when to fetch more data.
const int defaultInvisibleItemsThreshold = 3;

/// The default padding at the bottom of a list when using a bottom loader.
///
/// This padding is used in [InfiniteListView], [InfinitePageView] and
/// [InfiniteGridView] widgets.
///
/// It is used as the padding at the bottom of the list to leave space for
/// the bottom loader.
///
/// It is a constant with a default value of 16.0.
const double defaultBottomLoaderPadding = 16.0;

/// The default error message that is displayed when an error occurs.
const String defaultErrorMessage = 'Something went wrong. Tap to try again.';
