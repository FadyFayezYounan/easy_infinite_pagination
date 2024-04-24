import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

import '../../models/post_model.dart';

part 'posts_list_state.dart';

class PostsListCubit extends Cubit<PostsListState> {
  PostsListCubit() : super(PostsFetchLoading());

  /// List of all posts fetched so far.
  List<Post> get allPosts => List.unmodifiable(_allPosts);
  final List<Post> _allPosts = [];

  /// Flag indicating if we have reached the maximum number of posts.
  bool get hasReachedMax => _hasReachedMax;
  bool _hasReachedMax = false;

  /// Current page number.
  int get page => _page;
  int _page = 1;

  /// Refreshes the list of posts by clearing the current list, resetting
  /// the page number and the hasReachedMax flag, and fetching new posts.
  Future<void> refreshPosts() async {
    _allPosts.clear();
    _page = 1;
    _hasReachedMax = false;
    await fetchPosts();
  }

  /// Fetches new posts by emitting a loading state, making the API request,
  /// adding the new posts to the list, incrementing the page number, and
  /// checking if we have reached the maximum number of posts. If an error
  /// occurs, emits an error state.
  Future<void> fetchPosts() async {
    emit(PostsFetchLoading());
    try {
      final posts = await _fetchPosts(page: _page);
      _allPosts.addAll(posts);
      if (posts.length < 25) {
        _hasReachedMax = true;
      } else {
        _page++;
      }
      emit(PostsFetchLoaded());
    } catch (e) {
      emit(PostsFetchError(e.toString()));
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
