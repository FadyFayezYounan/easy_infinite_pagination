import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

import '../../models/post_model.dart';

part 'posts_grid_state.dart';

class PostsGridCubit extends Cubit<PostsGridState> {
  PostsGridCubit() : super(const PostsGridState());

  /// Fetches posts from the API and updates the state with the results.
  ///
  /// This method updates the state by setting the `isLoading` flag to true,
  /// making the API request, and updating the state with the fetched posts,
  /// the next page number, and the `hasReachedMax` flag.
  ///
  /// If an error occurs, the state is updated with the `hasError` flag set to true.

  Future<void> fetchPosts({bool refresh = false}) async {
    // If the `refresh` parameter is `true`, invalidates the current state by
    // returning a new state with the `invalidateSelf` method.
    if (refresh) {
      emit(state.invalidateSelf());
    } else {
      // If `refresh` is `false`, just set the loading flag to `true`.
      emit(state.copyWith(isLoading: true));
    }

    try {
      // Fetch posts from the API.
      final posts = await _fetchPosts(page: state.page);

      // Update the state with the fetched posts, the next page number,
      // and the hasReachedMax flag.
      emit(state.copyWith(
        isLoading: false,
        posts: List.of(state.posts)..addAll(posts),
        hasReachedMax: posts.length < 25,
        page: state.page + 1,
      ));
    } catch (e) {
      // If an error occurs, update the state with the hasError flag set to true.
      emit(state.copyWith(isLoading: false, hasError: true));
    }
  }

  /// Fetches posts from the API.
  ///
  /// Parameters:
  /// - page: the current page number.
  /// - limit: the number of posts per page (default is 25).
  ///
  /// Throws:
  /// - Exception: if the API request fails.
  Future<List<Post>> _fetchPosts({
    required int page,
    int limit = 25,
  }) async {
    final response = await http.get(
      Uri.https(
        'jsonplaceholder.typicode.com',
        '/posts',
        <String, String>{'_page': '$page', '_limit': '$limit'},
      ),
    );
    if (response.statusCode == 200) {
      final body = json.decode(response.body) as List;
      return body.map((dynamic json) => Post.fromJson(json)).toList();
    }
    throw Exception('Something went wrong while fetching posts');
  }
}
