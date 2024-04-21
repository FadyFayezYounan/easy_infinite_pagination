/// An enumeration representing the different statuses of a pagination operation.
///
/// Each status corresponds to a specific state a pagination operation can be in.
enum PaginationStatus {
  /// Indicates that the initial page of data is currently being loaded.
  ///
  /// This status is typically used when the initial page of data is being fetched from a server.
  firstPageLoading,

  /// Indicates that an error occurred while loading the initial page of data.
  ///
  /// This status is typically used when an error occurred while fetching the initial page of data.
  firstPageError,

  /// Indicates that no items were found in the initial page of data.
  ///
  /// This status is typically used when the initial page of data is empty.
  firstPageNoItemsFound,

  /// Indicates that the pagination operation has reached the last page of data.
  ///
  /// This status is typically used when there is no more data to be loaded.
  loadMoreReachedLastPage,

  /// Indicates that the next page of data is currently being loaded.
  ///
  /// This status is typically used when the next page of data is being fetched from a server.
  loadMoreLoading,

  /// Indicates that an error occurred while loading the next page of data.
  ///
  /// This status is typically used when an error occurred while fetching the next page of data.
  loadMoreError,
}
