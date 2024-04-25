part of 'posts_list_cubit.dart';

sealed class PostsListState extends Equatable {
  const PostsListState();

  @override
  List<Object> get props => [];
}

final class PostsFetchInitial extends PostsListState {}

final class PostsFetchLoading extends PostsListState {}

final class PostsFetchLoaded extends PostsListState {}

final class PostsFetchError extends PostsListState {
  final String message;

  const PostsFetchError(this.message);

  @override
  List<Object> get props => [message];
}
