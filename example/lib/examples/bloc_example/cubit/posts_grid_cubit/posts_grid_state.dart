part of 'posts_grid_cubit.dart';

/// [PostsGridState] represents the state of the [PostsGridCubit].
///
/// It contains the list of posts, a flag indicating if we have reached
/// the maximum number of posts, a flag indicating if we are currently
/// loading posts, a flag indicating if an error occurred, and the current
/// page number.
class PostsGridState extends Equatable {
  /// The list of posts.
  final List<Post> posts;

  /// A flag indicating if we have reached the maximum number of posts.
  final bool hasReachedMax;

  /// A flag indicating if we are currently loading posts.
  final bool isLoading;

  /// A flag indicating if an error occurred.
  final bool hasError;

  /// The current page number.
  final int page;

  const PostsGridState({
    this.posts = const <Post>[],
    this.isLoading = true,
    this.hasReachedMax = false,
    this.hasError = false,
    this.page = 1,
  });

  /// Creates a new instance of [PostsGridState] with some of its parameters replaced
  /// with the provided values.
  ///
  /// If a value is not provided, the corresponding value from this instance of
  /// [PostsGridState] is used.
  PostsGridState copyWith({
    List<Post>? posts,
    bool? hasReachedMax,
    bool? isLoading,
    bool? hasError,
    int? page,
  }) {
    return PostsGridState(
      posts: posts ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      page: page ?? this.page,
    );
  }

  /// Returns a new instance of [PostsGridState] with all of its parameters replaced
  /// with their default values.
  PostsGridState invalidateSelf() {
    return const PostsGridState();
  }

  @override
  String toString() {
    return '''PostState { hasReachedMax: $hasReachedMax, posts: ${posts.length}, isLoading: $isLoading, hasError: $hasError, page: $page }''';
  }

  @override
  List<Object?> get props => [
        posts,
        hasReachedMax,
        isLoading,
        hasError,
        page,
      ];
}
