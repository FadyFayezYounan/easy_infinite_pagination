import 'package:easy_infinite_pagination/easy_infinite_pagination.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/posts_list_cubit/posts_list_cubit.dart';
import 'custom_error_screen.dart';
import '../widgets/post_list_tile_widget.dart';

class PostListViewScreen extends StatelessWidget {
  const PostListViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostsListCubit(),
      child: Scaffold(
        appBar: AppBar(title: const Text('List View Example With Bloc')),
        body: BlocBuilder<PostsListCubit, PostsListState>(
          builder: (context, state) {
            final posts = context.read<PostsListCubit>().allPosts;
            return RefreshIndicator.adaptive(
              onRefresh: context.read<PostsListCubit>().refreshPosts,
              child: InfiniteListView.separated(
                delegate: PaginationDelegate(
                  isLoading: state is PostsFetchLoading,
                  hasError: state is PostsFetchError,
                  hasReachedMax: context.read<PostsListCubit>().hasReachedMax,
                  // The number of remaining invisible items that should trigger a new fetch.
                  // The default value is 3.
                  invisibleItemsThreshold: 5,
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    final post = posts[index];
                    return PostWidget(post: post);
                  },
                  // here we add a custom error screen if the state is an error state.
                  // and this screen will be shown if an error occurs while fetching data for the first page.
                  firstPageErrorBuilder: state is PostsFetchError
                      ? (context, onRetry) => CustomErrorScreen(
                            errorMessage: state.message,
                            onRetry: onRetry,
                          )
                      : null,
                  // this method will be called when the user reaches the end of the list or for the first page.
                  onFetchData: () async {
                    await context.read<PostsListCubit>().fetchPosts();
                  },
                ),
                separatorBuilder: (context, index) => const Divider(),
              ),
            );
          },
        ),
      ),
    );
  }
}
