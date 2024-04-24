import 'package:easy_infinite_pagination/easy_infinite_pagination.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/posts_grid_cubit/posts_grid_cubit.dart';
import '../widgets/post_grid_widget.dart';

class PostsGridViewScreen extends StatelessWidget {
  const PostsGridViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostsGridCubit(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Grid View Example With Bloc')),
        body: BlocBuilder<PostsGridCubit, PostsGridState>(
          builder: (context, state) {
            return RefreshIndicator.adaptive(
              onRefresh: () async {
                await context.read<PostsGridCubit>().fetchPosts(refresh: true);
              },
              child: InfiniteGridView(
                padding: const EdgeInsets.all(16.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                ),
                delegate: PaginationDelegate(
                  isLoading: state.isLoading,
                  hasError: state.hasError,
                  hasReachedMax: state.hasReachedMax,
                  // The number of remaining invisible items that should trigger a new fetch.
                  // The default value is 3.
                  invisibleItemsThreshold: 5,
                  itemCount: state.posts.length,
                  itemBuilder: (context, index) {
                    final post = state.posts[index];
                    return PostGridWidget(post: post);
                  },
                  // this method will be called when the user reaches the end of the list or for the first page.
                  onFetchData: () async {
                    await context.read<PostsGridCubit>().fetchPosts();
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
